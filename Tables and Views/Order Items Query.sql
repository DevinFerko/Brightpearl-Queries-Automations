SELECT DISTINCT
    [Order Line ID] = orl_id
    ,[Order Id] = ord_id
    ,[Parent Order Row Id] = ord_parentOrderId
    ,[Product ID] = orl_productId
    ,[Product SKU] = orl_productSku
    ,[Bundle Parent (Yes / No)] = CASE WHEN orl_compositionBundleParent = 0 THEN 'No' ELSE 'Yes' END
    ,[Bundle Child (Yes / No)] = CASE WHEN orl_compositionBundleChild = 0 THEN 'No' ELSE 'Yes' END
    ,[Bundle Product] = CASE WHEN prd_compositionBundle = 0 THEN 'No' ELSE 'Yes' END
    ,[Currency Code] = ord_orderCurrencyCode
    ,[Cost Currency Code] = ord_accountingCurrencyCode
    ,[Price Currency Code] = orl_itemCostCurrencyCode
    ,[Amount] = ord_net
    ,[Tax] = ord_taxAmount
    ,[Discount] = orl_discountPercentage
    ,[Unit Cost] = orl_itemCostValue
    ,[Cost] = (orl_itemCostValue * orl_quantity)
    ,[Price] = orl_productPriceValue
    ,[Quantity] = orl_quantity
    ,[Name] = orl_productName
    ,[Nominal Code] = orl_nominalCode
    ,[Order Time] = ord_placedOn
    ,[Tax Code] = orl_taxCode
    ,[Tax Rate] = orl_taxRate
FROM
    dbo.tblOrder 
LEFT JOIN dbo.tblOrderLine ON ord_id = orl_ord_id
LEFT JOIN dbo.tblProduct ON orl_ProductId = prd_id

WHERE orl_id = NULL