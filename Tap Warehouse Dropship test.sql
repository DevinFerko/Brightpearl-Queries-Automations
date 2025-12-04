SELECT TOP(10000)
    *
FROM usr.Orders AS o
LEFT JOIN usr.OrderItems AS oi ON o.[Order ID] = oi.[Order Id]
WHERE o.[Type] = 'SO'
    AND o.[Status] <> 'Cancelled'
    AND o.[Status] <> 'Cancelled SO Refund Due'
    AND o.[Status] <> 'Unconfirmed Cancelled Dropship'
    AND o.[Status] <> 'Failed Quotes'
    AND o.[Status] <>  'Quote sent'
    AND o.[Shipping Method] = 'Supplier Direct Delivery'
    AND o.[Invoice Reference] <> ''
    AND oi.[Nominal Code] IN (4000, 4002, 4010, 4030)
    AND o.[Invoice Reference] IS NOT NULL
    AND o.[Original Invoice Due Date] IS NOT NULL
    AND o.[Order ID] = 1835864
ORDER BY o.[Order ID] DESC