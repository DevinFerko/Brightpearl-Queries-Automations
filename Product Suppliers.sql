SELECT 
    psu_prd_id AS [Product Id]
    ,psu_con_id AS [Contact Id]
    ,con_organisationName AS [Organisation Name]
    ,prd_identitySKU AS [Product SKU]
    ,prd_status AS [Status]
FROM dbo.tblProductSupplier
LEFT JOIN dbo.tblContact ON psu_con_id = con_id
LEFT JOIN dbo.tblProduct ON psu_prd_id = prd_id
WHERE con_isSupplier = 1
ORDER BY psu_prd_id