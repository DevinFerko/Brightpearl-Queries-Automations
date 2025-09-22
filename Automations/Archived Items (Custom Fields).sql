SELECT DISTINCT
    p.[SKU]
    ,p.[Product ID]
    ,[Additional Product Information] = pcf1.pcf_value
    ,[Commodity Code] = pcf2.pcf_value
    ,[Country of Origin] = pcf3.pcf_value
    ,[Primary Category] = pcf8.pcf_value
    ,[Promotions] = pcf4.pcf_value
    ,[Quaternary Category] = pcf5.pcf_value
    ,[Secondary Category] = pcf6.pcf_value
    ,[Tertiary Category] = pcf7.pcf_value
FROM
    usr.ProductsView AS p
LEFT JOIN 
    dbo.tblProductCustomField AS pcf ON p.[Product ID] = pcf.[pcf_prd_id]
LEFT JOIN 
    dbo.tblProductCustomField AS pcf1 ON [Product ID] = pcf1.[pcf_prd_id] AND pcf1.pcf_name='PCF_ADDITION'
LEFT JOIN 
    dbo.tblProductCustomField AS pcf2 ON [Product ID] = pcf2.[pcf_prd_id] AND pcf2.pcf_name='PCF_COMMCODE'
LEFT JOIN 
    dbo.tblProductCustomField AS pcf3 ON [Product ID] = pcf3.[pcf_prd_id] AND pcf3.pcf_name='PCF_ORIGIN'
LEFT JOIN 
    dbo.tblProductCustomField AS pcf4 ON [Product ID] = pcf4.[pcf_prd_id] AND pcf4.pcf_name='PCF_PROMO'
LEFT JOIN 
    dbo.tblProductCustomField AS pcf5 ON [Product ID] = pcf5.[pcf_prd_id] AND pcf5.pcf_name='PCF_CAT4'
LEFT JOIN
    dbo.tblProductCustomField AS pcf6 ON [Product ID] = pcf6.[pcf_prd_id] AND pcf6.pcf_name='PCF_CAT2'
LEFT JOIN
    dbo.tblProductCustomField AS pcf7 ON [Product ID] = pcf7.[pcf_prd_id] AND pcf7.pcf_name='PCF_CAT3'
LEFT JOIN
    dbo.tblProductCustomField AS pcf8 ON [Product ID] = pcf8.[pcf_prd_id] AND pcf8.pcf_name='PCF_CAT1'
WHERE
    [Status] <> 'ARCHIVED'
    AND pcf.[pcf_name] IN ('PCF_ADDITION', 'PCF_ORIGIN', 'PCF_COMMCODE', 'PCF_CAT1', 'PCF_CAT2', 'PCF_CAT3', 'PCF_CAT4', 'PCF_PROMO')