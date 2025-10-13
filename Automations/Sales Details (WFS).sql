DECLARE @Today DATE = CAST(GETDATE() AS DATE);
DECLARE @DayOfWeek INT = DATEPART(WEEKDAY, @Today);

SELECT DISTINCT
    o.[Order ID],
    opB.par_addressFullName AS [Billing Name],
    o.[Status],
    p.[Organisation Name] AS [Supplier],
    oi.[Product SKU] AS [SKU],
    o.[Created At Date] AS [Created at Time],
    CAST(o.[Delivery Date] AS DATE) AS [Delivery Date],
    o.[Lead Source Name] AS [Lead Source],
    oi.[Quantity]
FROM
    usr.Orders AS o
LEFT JOIN
    usr.OrderItemsView AS oi ON o.[Order ID] = oi.[Order ID]
LEFT JOIN
    usr.ContactSuppliersView AS c ON o.[Supplier Contact ID] = c.[Contact ID]
LEFT JOIN
    dbo.tblOrderParty AS opB ON opB.par_ord_id = o.[Order ID] AND opB.par_type = 'billing'
LEFT JOIN
    usr.ProductsView AS p ON oi.[Product ID] = p.[Product ID]
WHERE
    CAST(o.[Status] AS VARCHAR(255)) IN ('Waiting for stock', 'Unconfirmed Dropship', 'Back Order')
    AND o.[Type] = 'SO'
    AND p.[Organisation Name] <> 'CONTINUOUS DATAPRINT (UK) LTD'
    AND o.[Order ID] NOT IN (1793735, 1785427, 1615047, 1612041, 1583776, 1488394, 1445676, 1420702, 1420699, 1401950, 1355899, 1334838, 1334786, 1789585, 1910414)
    AND oi.[Order ID] NOT IN (1793735, 1785427, 1615047, 1612041, 1583776, 1488394, 1445676, 1420702, 1420699, 1401950, 1355899, 1334838, 1334786, 1789585, 1910414)
    AND o.[Delivery Date] IS NOT NULL
    AND (
        (@DayOfWeek BETWEEN 2 AND 5 AND o.[Delivery Date] BETWEEN @Today AND DATEADD(DAY, 5, @Today))
        OR
        (@DayOfWeek IN (6, 7, 1) AND o.[Delivery Date] BETWEEN @Today AND DATEADD(DAY, 7, @Today))
    )
ORDER BY
    o.[Order ID];