CREATE OR ALTER VIEW usr.RefundsView
AS
SELECT DISTINCT 
    [Refund ID] = ord_id
    ,[Parent Order ID] = ord_parentOrderId
    ,[Type] = ord_orderTypeCode
    ,[Channel] = ord_channelId
    ,[Status] = ord_orderStatusName
    ,[Inventory Status] = ord_stockStatusCode
    ,[Payment Status] = ord_orderPaymentStatus
    ,[Shipping Status] = ord_shippingStatusCode
    ,[Shipping Method] = ord_shippingMethodId
    ,[Shipping] = shm_name
    ,[Created By ID] = ord_createdById
    ,[Employee ID] = ord_staffOwnerContactId
    ,[Refund Date] = ord_placedOn
    ,[Tax Date] = ord_invoicetaxDate
    ,[Due Date] = ord_invoicedueDate
    ,[Reference Number] = ord_reference
    ,[Invoice Reference] = ord_invoiceReference
    ,CASE WHEN ord_isDropship = 0 THEN 'No' ELSE 'Yes' END AS [Is Dropship (Yes / No)]
    ,[Lead Source ID] = ord_leadSourceId
    ,[Lead Source] = lsc_name
    ,[Quantity] = orl_quantity
    ,[Cost] = (orl_itemCostValue * orl_quantity)
    ,[Tax] = orl_rowTaxValue
    ,[Amount] = (orl_rowTaxValue + orl_rowNetValue)
    ,[Discount] = orl_discountPercentage
    ,[Supplier Name] = con_organisationName
    ,[Customer ID] = par_contactId
    ,[Name] = par_addressFullName
    ,[Company] = par_companyName
    ,[Email] = par_email
    ,[City] = par_addressLine3
    ,[State] = par_addressLine4
    ,[Country] = par_country
    ,[Postal Code] = par_postalCode
    ,[Delivery Postal Code] = con_deliveryPostalCode
    ,[Warehouse ID] = ord_warehouseId
    ,[Custom Field Code] = ocf_name
    ,[Custom Field Type] = omd_type
    ,[Custom Field Value] = ocf_value
    ,[Custom Field Value ID] = ocf_id
FROM
    dbo.tblOrder
LEFT JOIN 
    dbo.tblShippingMethod ON ord_shippingMethodId = shm_id
LEFT JOIN 
    dbo.tblOrderLine ON ord_Id = orl_ord_id
LEFT JOIN 
    dbo.tblLeadSource ON ord_leadSourceId = lsc_id
LEFT JOIN 
    dbo.tblOrderParty ON ord_id = par_ord_id
LEFT JOIN 
    dbo.tblContact ON ord_createdById = con_id AND con_isSupplier = 1
LEFT JOIN 
    dbo.tblOrderCustomField ON ord_id = ocf_ord_id
LEFT JOIN 
    dbo.tblOrderCustomFieldMetadata ON ocf_name = omd_code
WHERE 
    ord_orderTypeCode = 'SC' OR ord_orderTypeCode = 'PC'