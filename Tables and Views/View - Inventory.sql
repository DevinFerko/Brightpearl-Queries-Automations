CREATE OR ALTER VIEW usr.InventoryView
AS
SELECT DISTINCT
    ProductID = pa.pav_prd_id,
    Quantity = pa.pav_inStock,  
    Allocated = pa.pav_allocated,  
    OnHand = pa.pav_onHand,  
    InTransit = pa.pav_inTransit,  
    OnOrderShipped = pa.pav_onOrderShipped,  
    OnOrderTotal = pa.pav_onOrderTotal,  
    WarehouseID = pa.pav_whs_id,  
    WarehouseName = w.whs_name,  
    LocationID = w.whs_addressId,  
    UpdatedOnDate = p.prd_updatedOn  
FROM dbo.tblProductAvailability AS pa 
LEFT JOIN dbo.tblWarehouse AS w ON pa.pav_whs_id = w.whs_id  
LEFT JOIN dbo.tblProduct AS p ON pa.pav_prd_id = p.prd_id;