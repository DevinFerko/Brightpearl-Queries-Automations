SELECT DISTINCT 
  *,
  CASE
    WHEN YEAR(ord_invoiceTaxDate) > YEAR(ord_placedOn)
      OR (
            YEAR(ord_invoiceTaxDate) = YEAR(ord_placedOn)
        AND MONTH(ord_invoiceTaxDate) > MONTH(ord_placedOn)
      )
    THEN 1
    ELSE 0
  END AS pipeline_order,
  CASE
    WHEN ord_orderStatusName IN ('Cancelled', 'Cancelled SO Refund') -- Are Needed ?? 'Damaged / Missing It', 'Incorrect Goods Rece', 'Refund Awaiting Info', 'Refund Due', 'Unconfirmed Cancelle', ' Unprocessed orders'
    THEN 1
    ELSE 0
  END AS cancelled_order
FROM dbo.tblOrder
LEFT JOIN dbo.tblOrderLine ON ord_id = orl_ord_id 
WHERE 1=1
  AND ord_placedOn >= '2020-01-01'
  --AND DATEDIFF(MONTH, ord_placedOn, ord_invoiceTaxDate) >= 1
  --AND ord_orderStatusName IN ('Cancelled', 'Cancelled SO Refund')
  --AND ord_id = 2361910
  --AND ord_invoicetaxDate IS NOT NULL
  --ORDER BY ord_placedOn DESC;
