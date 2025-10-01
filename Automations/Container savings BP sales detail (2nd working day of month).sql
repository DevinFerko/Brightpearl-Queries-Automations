SELECT DISTINCT
    o.[Order ID],
    o.[Status],
    o.[Tax Date],
    oi.[Name],
    oi.[Product SKU],
    oi.[Quantity],
    (oi.[Amount] / NULLIF(oi.[Quantity], 0)) AS [GBP item net],
    o.[Exchange Rate],
    (oi.[Cost] / NULLIF(oi.[Quantity], 0)),
    oi.[Cost]
FROM 
    usr.OrdersView AS o
LEFT JOIN
    usr.OrderItemsView AS oi ON o.[Order Id] = oi.[Order Id]
WHERE
    o.[Type] = 'SO'
    AND o.[Original Invoice Due Date] IS NOT NULL
    AND (o.[Invoice Reference] <> '' OR o.[Invoice Reference] IS NOT NULL)
    AND (o.[Channel Name] <> 'TW Trade' AND o.[Channel Name] <> 'DR Trade' AND o.[Channel Name] <> 'OR Trade')
    AND (oi.[Product SKU] <> '' OR oi.[Product SKU] IS NOT NULL)
    AND o.[Tax Date] >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
    AND o.[Tax Date] < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0);