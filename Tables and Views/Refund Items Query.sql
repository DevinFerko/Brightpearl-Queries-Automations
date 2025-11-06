SELECT
    [Order Id] = ord_id
    ,[Parent Order Row Id] = ord_parentOrderId
    ,[Refund Line Item Id] = orl_orderRowSequence
    ,[SKU] = orl_productSku
    ,[Product Id] = orl_productId
    ,[Name] = orl_productName
    ,[Nominal Code] = orl_nominalCode
    ,[Price Currency Code] = orl_itemCostCurrencyCode
    ,[Net Currency Code] = orl_rowNetCurrencyCode
    ,[Tax Currency Code] = orl_rowTaxCurrencyCode
    ,[Cost Currency Code] = ord_accountingCurrencyCode
    ,[Price] = orl_productPriceValue
    ,[Tax Code] = orl_taxCode
    ,[Tax Rate] = orl_taxRate
    ,[Amount] = (orl_rowTaxValue + orl_rowNetValue)
    ,[Tax] = orl_rowTaxValue
    ,[Net Total] = orl_rowNetValue
    ,[Cost] = (orl_itemCostValue * orl_quantity)
    ,[Discount] = orl_discountPercentage
    ,[Quantity] = orl_quantity
    ,[Bundle Child (Yes / No)] = CASE WHEN orl_compositionBundleChild = 0 THEN 'No' ELSE 'Yes' END
    ,[Bundle Parent (Yes / No)] = CASE WHEN orl_compositionBundleParent = 0 THEN 'No' ELSE 'Yes' END
    ,[Bundle Product Name] = CASE WHEN prd_compositionBundle = 0 THEN 'No' ELSE prd_firstChannelProductName END
    ,[Type] = ord_orderTypeCode
FROM 
    dbo.tblOrder
LEFT JOIN 
    dbo.tblOrderLine ON ord_id = orl_ord_id
LEFT JOIN 
    dbo.tblProduct ON orl_productId = prd_id
WHERE 
    ord_orderTypeCode = 'SC' OR ord_orderTypeCode = 'PC'