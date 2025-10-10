SELECT DISTINCT
    pa.pav_prd_id AS 'Product ID',
    pa.pav_inStock AS 'Quantity',
    pa.pav_allocated AS 'Allocated',
    pa.pav_onHand AS 'On Hand',
    pa.pav_inTransit AS 'In Transit',
    pa.pav_onOrderShipped AS 'On Order Shipped',
    pa.pav_onOrderTotal AS 'On Order Total',
    pa.pav_whs_id AS 'Warehouse ID',
    w.whs_name AS 'Wharehouse Name', 
    w.whs_addressId AS 'Location ID',
    p.prd_updatedOn AS 'Updated On Date'

FROM
    dbo.tblProductAvailability AS pa

LEFT JOIN
    dbo.tblWarehouse AS w ON pa.pav_whs_id = w.whs_id

LEFT JOIN
    dbo.tblProduct AS p ON pa.pav_prd_id = p.prd_id

WHERE
    pa.pav_prd_id = 1072