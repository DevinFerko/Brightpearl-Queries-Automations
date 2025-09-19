-- Ensure the table exists before altering
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Inventory' AND TABLE_SCHEMA = 'usr')
BEGIN
    CREATE TABLE usr.Inventory  
    (  
        ProductID INT,  
        Quantity INT,  
        Allocated INT,  
        OnHand INT,  
        InTransit INT,  
        OnOrderShipped INT,  
        OnOrderTotal INT,  
        WarehouseID INT,  
        WarehouseName NVARCHAR(255),  
        LocationID INT,  
        UpdatedOnDate DATETIME  
    );
END;

-- Update existing records
UPDATE usr.Inventory  
SET  
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
FROM usr.Inventory inv  
JOIN dbo.tblProductAvailability AS pa ON inv.ProductID = pa.pav_prd_id  
LEFT JOIN dbo.tblWarehouse AS w ON pa.pav_whs_id = w.whs_id  
LEFT JOIN dbo.tblProduct AS p ON pa.pav_prd_id = p.prd_id;

-- Insert new records if they don’t already exist
INSERT INTO usr.Inventory (ProductID, Quantity, Allocated, OnHand, InTransit, OnOrderShipped, OnOrderTotal, WarehouseID, WarehouseName, LocationID, UpdatedOnDate)
SELECT DISTINCT  
    pa.pav_prd_id,  
    pa.pav_inStock,  
    pa.pav_allocated,  
    pa.pav_onHand,  
    pa.pav_inTransit,  
    pa.pav_onOrderShipped,  
    pa.pav_onOrderTotal,  
    pa.pav_whs_id,  
    w.whs_name,  
    w.whs_addressId,  
    p.prd_updatedOn  
FROM dbo.tblProductAvailability AS pa  
LEFT JOIN dbo.tblWarehouse AS w ON pa.pav_whs_id = w.whs_id  
LEFT JOIN dbo.tblProduct AS p ON pa.pav_prd_id = p.prd_id  
WHERE NOT EXISTS (
    SELECT 1 FROM usr.Inventory inv WHERE inv.ProductID = pa.pav_prd_id AND inv.WarehouseID = pa.pav_whs_id
);