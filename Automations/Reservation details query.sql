SELECT 
  ol.orl_ord_id
  ,ol.orl_id
  ,p.prd_id
  ,ol.orl_productSku
  ,ol.orl_productName
  ,rd.red_rowId
  ,rd.red_quantity
FROM dbo.tblOrderLine AS ol 
LEFT JOIN dbo.tblReservationDetail AS rd ON ol.orl_id = rd.red_rowId
LEFT JOIN dbo.tblProduct AS p ON rd.red_productId = p.prd_id
WHERE ol.orl_ord_id = 2272824 -- Sample OrderId to test