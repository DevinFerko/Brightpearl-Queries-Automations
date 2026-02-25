SELECT 
    psu_prd_id,
    psu_con_id,
    con_organisationName,
    CASE WHEN pcf_name = 'PCF_CAT1' THEN pcf_value END AS [Primary Category]
FROM dbo.tblProductSupplier
LEFT JOIN dbo.tblContact ON psu_con_id = con_id
LEFT JOIN dbo.tblProductCustomField ON psu_prd_id = pcf_prd_id