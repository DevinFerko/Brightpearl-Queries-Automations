SELECT 
    SUM(bpar_orl_calcRowNetValue)
FROM 
    Perceptium.tblOrderLineParentView
LEFT JOIN
    dbo.tblOrder ON bpar_orl_ord_id = ord_id
WHERE
    ord_orderPaymentStatus IN ('PAID', 'PARTIALLY_PAID')
    AND ord_reference = ''
    AND ord_invoicetaxDate >= '2025-08-01'
    AND ord_invoicetaxDate <= '2025-08-31'