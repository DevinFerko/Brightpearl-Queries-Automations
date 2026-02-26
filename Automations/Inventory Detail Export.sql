SELECT DISTINCT
    CAST(GETDATE() AS DATE) AS [Inventory Date],
    prd_id AS [Product ID],
    prd_identitySKU AS [SKU],
    prd_firstChannelProductName AS [Name],
    pav_inStock AS [In Stock],
    pav_allocated AS [Allocated],
    pav_onHand AS [On Hand],
    prp_price1 AS [Price],
    prp_priceListId AS [Price List ID],
    whs_name AS [Warehouse],
    loc_groupingA AS [Aisle],
    loc_groupingB AS [Bay],
    loc_groupingC AS [Shelf],
    loc_groupingD AS [Bin]
    
    -- Looking for Received Date
    --prd_createdOn Not
    --prd_updatedOn Not

    
FROM dbo.tblProduct
LEFT JOIN dbo.tblProductAvailability ON prd_id = pav_prd_id
LEFT JOIN dbo.tblProductPrice ON prd_id = prp_productId
LEFT JOIN dbo.tblProductWarehouse ON prd_id = pwh_prd_id
LEFT JOIN dbo.tblWarehouse ON pwh_whs_id = whs_id
LEFT JOIN dbo.tblProductAvailabilityByLocation on prd_id = pal_prd_id
LEFT JOIN dbo.tblLocation ON pal_loc_id = loc_id
WHERE prp_priceListId =1
AND prd_identitySKU = '2/C626'
