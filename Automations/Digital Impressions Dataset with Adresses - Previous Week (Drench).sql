SELECT DISTINCT
    CAST(o.[Created at Date] AS DATE) AS [Created At Date]
    ,o.[Delivery City]
    ,o.[Delivery Zip]
    ,o.[Revenue]
    ,oi.[Quantity]
FROM 
    usr.OrdersView AS o
LEFT JOIN
    usr.OrderItemsView AS oi ON o.[Order ID] = oi.[Order ID]
WHERE o.[Delivery City] IS NOT NULL
    AND o.[Status] NOT IN ('Failed Quotes', 'Quote sent', 'Replacement Quote', 'Cancelled', 'Cancelled Order - Rec Req', 'Cancelled SO Refund Due', 'Unconfirmed Cancelled Dropship')
    AND o.[Channel Name] = 'Drench'
    AND o.[Type] = 'SO'
    AND o.[Created at Date] >= DATEADD(WEEK, -1, DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0))
    AND o.[Created at Date] < DATEADD(WEEK, 0, DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0))
