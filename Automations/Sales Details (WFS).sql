SELECT DISTINCT
    o.[Order ID],
    opB.par_addressFullName AS [Billing Name],
    o.[Status],
    p.[Organisation Name] AS [Supplier],
    oi.[Product SKU] AS [SKU],
    o.[Created At Date] AS [Created at Time],
    CAST(o.[Delivery Date] AS DATE) AS [Delivery Date],
    o.[Lead Source Name] AS [Lead Source],
    oi.[Quantity],
    o.[Shipping Method],
    pa.pav_inStock AS [In Stock],
    pa.pav_allocated AS [Allocated],
    pa.pav_onOrderTotal AS [On Order]
FROM
    usr.Orders AS o
LEFT JOIN
    usr.OrderItemsView AS oi ON o.[Order ID] = oi.[Order ID]
LEFT JOIN
    dbo.tblOrderParty AS opB ON opB.par_ord_id = o.[Order ID] AND opB.par_type = 'billing'
LEFT JOIN
    usr.ProductsView AS p ON oi.[Product ID] = p.[Product ID]
LEFT JOIN 
    dbo.tblProductAvailability AS pa ON p.[Product ID] = pa.pav_prd_id
WHERE
    CAST(o.[Status] AS VARCHAR(255)) IN ('Waiting for stock', 'Unconfirmed Dropship', 'Back Order')
    AND o.[Type] = 'SO'
    --AND p.[Organisation Name] <> 'CONTINUOUS DATAPRINT (UK) LTD'
AND o.[Delivery Date] IS NOT NULL
AND oi.[Product SKU] = 'MULTA-70-B'