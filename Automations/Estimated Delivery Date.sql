SELECT
    oi.[Order Id],
    CAST(GETDATE() AS DATE) AS [Last Update]
FROM
    usr.OrderItemsView AS oi
LEFT JOIN
    usr.OrdersView AS o ON o.[Order Id] = oi.[Order Id]
WHERE
    o.[Type] = 'SO'
    AND o.[Status] IN ('Waiting for stock', 'Unconfirmed Dropship', 'Back Order')
    AND oi.[Order Id] NOT IN (1789585, 1793735, 1785427, 1615047, 1612041, 1583776, 1488394, 1445676, 1420702, 1420699, 1401950, 1355899, 1334838, 1334786, 1910414)