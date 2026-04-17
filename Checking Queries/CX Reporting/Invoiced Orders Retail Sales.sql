SELECT DISTINCT 
    COUNT(ord_id)
FROM dbo.tblOrder
LEFT JOIN dbo.tblContact ON ord_staffOwnerContactId = con_id 
WHERE 1=1
    AND ord_invoicetaxDate >= DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()) - 1, 0)
    AND ord_invoicetaxDate <  DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0)
    AND ord_invoicetaxDate IS NOT NULL
    AND con_lastName IN ('Defeo', 'Alden', 'McGee', 'Rogers', 'Price', 'Thompson', 'Plant', 'Oliver') 
    AND ord_orderTypeCode = 'SO'