SELECT DISTINCT
    CAST(GETDATE() AS DATE) AS [Inventory Date]
    ,p.[SKU]
    ,i.[ProductID] AS [Product ID]
    ,i.[OnHand]
    ,(i.[OnOrderTotal] - i.[OnOrderShipped]) AS [On Order]
FROM
    usr.InventoryView AS i
LEFT JOIN 
    usr.ProductsView AS p ON i.[ProductID] = p.[Product ID]
WHERE 
    i.[WarehouseName] = 'Main Warehouse'
    AND p.[Status] <> 'ARCHIVED'