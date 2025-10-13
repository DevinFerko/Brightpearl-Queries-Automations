SELECT DISTINCT 
    o.[Order ID]
    ,CASE
        WHEN o.[Allocation Status] = 'ANR' THEN 'Allocation Not Required'
        WHEN o.[Allocation Status] = 'ANA' THEN 'Not allocated'
        WHEN o.[Allocation Status] = 'APA' THEN 'Partially allocated'
        WHEN o.[Allocation Status] = 'AAA' THEN 'All stock allocated'
    END
    ,o.[Lead Source Name] AS [Lead Source]
    ,CAST(GETDATE() AS DATE) AS [Last Update]

FROM
    usr.OrdersView AS o
LEFT JOIN
    usr.OrderItemsView AS oi ON o.[Order ID] = oi.[Order ID]

WHERE
    o.[Type] = 'SO'
    AND o.[Status] IN ('Waiting for stock', 'Unconfirmed Dropship', 'Back Order') 
    AND o.[Allocation Status] IN ('ANA', 'APA') 
    AND o.[Tax Date] < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
    AND o.[Order ID] NOT IN (1910414, 1793735, 1789585, 1785427, 1615047, 1612041, 1583776, 1488394, 1445676, 1420702, 1420699, 1401950, 1355899, 1334838, 1334786)
    AND oi.[Order ID] NOT IN (1910414, 1793735, 1789585, 1785427, 1615047, 1612041, 1583776, 1488394, 1445676, 1420702, 1420699, 1401950, 1355899, 1334838, 1334786)