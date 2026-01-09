SELECT DISTINCT
    oi.[Order ID],
    op.par_addressFullName AS [Contact Name],
    o.[Status],
    p.[Organisation Name] AS [Supplier],
    oi.[Product SKU] AS [SKU],
    o.[Created At Date] AS [Created at Time],
    CAST(o.[Delivery Date] AS DATE) AS [Delivery Date],
    o.[Lead Source Name] AS [Lead Source ID],
    o.[Shipping Method],
    oi.[Quantity],
    (c.con_firstName + ' ' + c.con_lastName) AS [Assigned To],
    CASE
        WHEN o.[Channel ID] = 2 THEN 'Tap Warehouse'
        WHEN o.[Channel ID] = 7 THEN 'Drench'
        WHEN o.[Channel ID] = 8 THEN 'OR'
        WHEN o.[Channel ID] IN (10, 12, 13, 14) THEN 'Trade'
        WHEN o.[Channel ID] = 3 THEN 'Remedials'
        WHEN o.[Channel ID] = 11 THEN 'Outlet'
        WHEN o.[Channel ID] IN (1, 4, 9, 5, 6) THEN 'Other'
    ELSE 'Other' END AS [Channel Name],
    c.con_id

FROM
    usr.OrdersView AS o
LEFT JOIN
    usr.OrderItemsView AS oi ON o.[Order ID] = oi.[Order ID]
LEFT JOIN
    dbo.tblOrderParty AS op ON op.par_ord_id = o.[Order Id] AND op.par_type = 'customer'
LEFT JOIN
    dbo.tblContact AS c ON o.[Employee ID]= c.con_id 
LEFT JOIN
    usr.ProductsView AS p ON oi.[Product ID] = p.[Product ID]
WHERE
    o.[Type] = 'SO'
    AND o.[Status] IN ('Back Order', 'Unconfirmed Dropship', 'Waiting for stock')
    AND o.[Order ID] NOT IN (1910414, 1793735, 1789585, 1785427, 1615047, 1612041, 1583776, 1488394, 1445676, 1420702, 1420699, 1401950, 1355899, 1334838, 1334786)
    AND o.[Delivery Date] IS NOT NULL