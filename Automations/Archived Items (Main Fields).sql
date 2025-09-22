SELECT DISTINCT
    [SKU]
    ,[Name]
    ,[Product ID]
    ,[Brand]
    ,[Category]
    ,[Barcode]
    ,[Weight]
    ,[Short Description]
FROM
    usr.ProductsView
WHERE 
    [Status] = 'ARCHIVED'
    AND [Product ID] NOT IN (32875, 56351, 60298, 60299, 60301, 60302, 60300, 60303)