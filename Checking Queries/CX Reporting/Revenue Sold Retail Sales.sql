SELECT DISTINCT 
    SUM(ord_net)
FROM dbo.tblOrder
LEFT JOIN dbo.tblContact ON ord_staffOwnerContactId = con_id 
WHERE 1=1
    AND ord_createdOn >= DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()) - 1, 0)
    AND ord_createdOn <  DATEADD(WEEK, DATEDIFF(WEEK, 0, GETDATE()), 0)
    AND ord_orderPaymentStatus = 'PAID'
    AND con_lastName IN ('Defeo', 'Alden', 'McGee', 'Rogers', 'Price', 'Thompson', 'Plant', 'Oliver') 