CREATE OR ALTER VIEW usr.OrderRemedialsAndReturnsReason
AS
SELECT DISTINCT
    o.ord_id AS [Order ID],
    ocf1.ocf_name AS [PCF_Remedial],
    ocf1.ocf_value AS [Remedial Value],
    ocf2.ocf_name AS [PCF_Reasonfo],
    ocf2.ocf_value AS [Reasonfo Value],
    ocf3.ocf_name AS [PCF_Reasoncr],
    ocf3.ocf_value AS [Reasoncr Value]
FROM
    dbo.tblOrder AS o
LEFT JOIN 
    dbo.tblOrderCustomField AS ocf1 ON ocf1.ocf_ord_id = ord_id AND ocf1.ocf_name = 'PCF_REMEDIAL'
LEFT JOIN 
    dbo.tblOrderCustomField AS ocf2 ON ocf2.ocf_ord_id = ord_id AND ocf2.ocf_name = 'PCF_REASONFO'
LEFT JOIN 
    dbo.tblOrderCustomField AS ocf3 ON ocf3.ocf_ord_id = ord_id AND ocf3.ocf_name = 'PCF_REASONCR'
WHERE 
    ocf1.ocf_name IS NOT NULL OR ocf2.ocf_name IS NOT NULL OR ocf3.ocf_name IS NOT NULL