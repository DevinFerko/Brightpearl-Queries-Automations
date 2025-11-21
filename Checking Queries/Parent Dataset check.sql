SELECT
    bpar_orl_ord_id,
    bpar_orl_productName,
    bpar_orl_productSku,
    bpar_orl_quantity,
    bpar_orl_calcRowNetValue,
    bpar_orl_calcRowCost
FROM perceptium.tblOrderLineParentView
WHERE bpar_orl_ord_id = 2181357