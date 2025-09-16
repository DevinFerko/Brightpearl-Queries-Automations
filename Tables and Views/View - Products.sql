CREATE OR ALTER VIEW usr.ProductsView
AS
SELECT DISTINCT
    [Product ID] = prd_id
    ,[SKU] = prd_identitySKU
    ,[Brand] = brd_name
    ,[Barcode] = prd_identityBarcode
    ,[Ean] = prd_identityEAN
    ,[Isbn] = prd_identityISBN
    ,[Mpn] = prd_identityMPN
    ,[Upc] = prd_identityUPC
    ,[Name] = prd_firstChannelProductName
    ,[Bundle (Yes / No)] = CASE WHEN prd_bundle = 0 THEN 'No' ELSE 'Yes' END
    ,[Category ID] = prd_reportingCategoryId
    ,[Category] = BC.bct_name
    ,[Reporting Category] = prd_reportingCategoryId
    ,[Subcategory ID] = prd_reportingSubcategoryId
    ,[Sub Category] = BC1.bct_name
    ,[Created Time] = prd_createdOn
    ,[Height] = prd_height
    ,[Length] = prd_length
    ,[Volume] = prd_volume
    ,[Width] = prd_width
    ,[Weight] = prd_weight
    ,[Nominal Code Purchases] = prd_nominalCodePurchases
    ,[Nominal Code Sales] = prd_nominalCodeSales
    ,[Nominal Code Stock] = prd_nominalCodeStock
    ,[Primary Supplier ID] = prd_primarySupplierId
    ,[Supplier First Name] = con_firstName
    ,[Supplier Last Name] = con_lastName
    ,[Organisation Name] = con_organisationName
    ,[Sales Channel] = psc_salesChannelName
    ,[Short Description] = prd_shortDescription
    ,[Status] = prd_status
    ,[Tax Code] = prd_financialDetailsTaxCodeCode
    ,[Type] = prd_productTypeId
    ,[Currency ID] = prp_currencyId
    ,[Currency Code] = prp_currencyCode
    ,[Price List ID] = prp_priceListId
    ,[Price List Name] = prc_name
    ,[Price] = prp_price1
    ,[Custom Field Name] = pcf_name
    ,[Custom Field Value ID] = pcf_id
    ,[Custom Field Value] = pcf_value

    FROM
        dbo.tblProduct

    LEFT JOIN dbo.tblBrand ON prd_brandId = brd_id
    LEFT JOIN dbo.tblBrightpearlCategory AS BC ON prd_reportingCategoryId = bct_id
    LEFT JOIN dbo.tblProductSalesChannel ON prd_id = psc_prd_id
    LEFT JOIN dbo.tblProductPrice ON prd_id = prp_productId
    LEFT JOIN dbo.tblPriceList ON prp_priceListId = prc_id   
    LEFT JOIN dbo.tblProductCustomField ON prd_id = pcf_prd_id
    LEFT JOIN dbo.tblContact ON prd_primarySupplierId = con_id
    LEFT JOIN dbo.tblBrightpearlCategory AS BC1 ON prd_reportingSubCategoryId = BC1.bct_id 