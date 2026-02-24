SELECT 
    psu_prd_id,
    psu_con_id,
    con_organisationName
FROM dbo.tblProductSupplier
LEFT JOIN dbo.tblContact ON psu_con_id = con_id