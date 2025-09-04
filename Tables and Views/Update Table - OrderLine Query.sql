-- Ensure the table exists before altering
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OrderLine' AND TABLE_SCHEMA = 'usr')
BEGIN
    CREATE TABLE usr.OrderLine
    (  
    [Order Line ID] INT PRIMARY KEY
    ,[Order Id] INT 
    ,[Parent Order Row Id] INT
    ,[Type] NVARCHAR(255)
    ,[Reference Number] NVARCHAR(255)
    ,[Invoice Reference] NVARCHAR(255)
    ,[Status] NVARCHAR(255)
    ,[Allocation Status] NVARCHAR(255)
    ,[Inventory Status] NVARCHAR(255)
    ,[Shipping Status] NVARCHAR(255)
    ,[Payment Status] NVARCHAR(255)
    ,[Channel ID] INT
    ,[Channel Name] NVARCHAR(255)
    ,[Billing City] NVARCHAR(255)
    ,[Billing Country Id] INT
    ,[Billing Country Code] NVARCHAR(255)
    ,[Billing State] NVARCHAR(255)
    ,[Billing Zip] NVARCHAR(255)
    ,[Delivery City] NVARCHAR(255)
    ,[Delivery Country Id] INT
    ,[Delivery Country Code] NVARCHAR(255)
    ,[Delivery State] NVARCHAR(255)
    ,[Delivery Zip] NVARCHAR(255)
    ,[Created By ID] INT
    ,[Employee ID] INT
    ,[Currency] NVARCHAR(255) 
    ,[Order Date] DATETIME
    ,[Created At Date] DATETIME
    ,[Tax Date] DATETIME
    ,[Original Invoice Due Date] DATETIME
    ,[Delivery Date] DATETIME
    ,[Exchange Rate] DECIMAL(18,2)
    ,[Fixed Exchange Rate] INT
    ,[Net Value] DECIMAL(18,2)
    ,[Cost] DECIMAL(18,2)
    ,[Revenue] DECIMAL(18,2)
    ,[Tax Amount] DECIMAL(18,2)
    ,[Quantity] DECIMAL(18,2)
    ,[Historical Order (Yes / No)] NVARCHAR(255)
    ,[Is Dropship (Yes/No)] NVARCHAR(255)
    ,[Lead Source ID] INT
    ,[Lead Source Name] NVARCHAR(255)
    ,[Payment Method Code] NVARCHAR(255)
    ,[Payment Method] NVARCHAR(255)
    ,[Cost Price ID] INT
    ,[Price List] INT
    ,[Shipping Method ID] INT
    ,[Shipping Method] NVARCHAR(255)
    ,[Warehouse ID] INT
    ,[Supplier City] NVARCHAR(255)
    ,[Supplier Company] NVARCHAR(255)
    ,[Supplier Contact Id] INT
    ,[Supplier Country Code] NVARCHAR(255)
    ,[Supplier Country Id] INT
    ,[Supplier State] NVARCHAR(255)
    ,[Supplier Zip] NVARCHAR(255)
    ,[Supplier Email] NVARCHAR(255)
    ,[Supplier Name] NVARCHAR(255)
    );  
END;


-- Update existing records (DO NOT update Order Line ID since it's a primary key)
UPDATE o 
SET
    o.[Order Id] = src.[Order Id],
    o.[Parent Order Row Id] = src.[Parent Order Row Id],
    o.[Type] = src.[Type],
    o.[Reference Number] = src.[Reference Number],
    o.[Invoice Reference] = src.[Invoice Reference],
    o.[Status] = src.[Status],
    o.[Allocation Status] = src.[Allocation Status],
    o.[Inventory Status] = src.[Inventory Status],
    o.[Shipping Status] = src.[Shipping Status],
    o.[Payment Status] = src.[Payment Status],
    o.[Channel ID] = src.[Channel ID],
    o.[Channel Name] = src.[Channel Name],
    o.[Billing City] = src.[Billing City],
    o.[Billing Country Id] = src.[Billing Country Id],
    o.[Billing Country Code] = src.[Billing Country Code],
    o.[Billing State] = src.[Billing State],
    o.[Billing Zip] = src.[Billing Zip],
    o.[Delivery City] = src.[Delivery City],
    o.[Delivery Country Id] = src.[Delivery Country Id],
    o.[Delivery Country Code] = src.[Delivery Country Code],
    o.[Delivery State] = src.[Delivery State],
    o.[Delivery Zip] = src.[Delivery Zip],
    o.[Created By ID] = src.[Created By ID],
    o.[Employee ID] = src.[Employee ID],
    o.[Currency] = src.[Currency],
    o.[Order Date] = src.[Order Date],
    o.[Created At Date] = src.[Created At Date],
    o.[Tax Date] = src.[Tax Date],
    o.[Original Invoice Due Date] = src.[Original Invoice Due Date],
    o.[Delivery Date] = src.[Delivery Date],
    o.[Exchange Rate] = src.[Exchange Rate],
    o.[Fixed Exchange Rate] = src.[Fixed Exchange Rate],
    o.[Net Value] = src.[Net Value],
    o.[Cost] = src.[Cost],
    o.[Revenue] = src.[Revenue],
    o.[Tax Amount] = src.[Tax Amount],
    o.[Quantity] = src.[Quantity],
    o.[Historical Order (Yes / No)] = src.[Historical Order (Yes / No)],
    o.[Is Dropship (Yes/No)] = src.[Is Dropship (Yes/No)],
    o.[Lead Source ID] = src.[Lead Source ID],
    o.[Lead Source Name] = src.[Lead Source Name],
    o.[Payment Method Code] = src.[Payment Method Code],
    o.[Payment Method] = src.[Payment Method],
    o.[Cost Price ID] = src.[Cost Price ID],
    o.[Price List] = src.[Price List],
    o.[Shipping Method ID] = src.[Shipping Method ID],
    o.[Shipping Method] = src.[Shipping Method],
    o.[Warehouse ID] = src.[Warehouse ID],
    o.[Supplier City] = src.[Supplier City],
    o.[Supplier Company] = src.[Supplier Company],
    o.[Supplier Contact Id] = src.[Supplier Contact Id],
    o.[Supplier Country Code] = src.[Supplier Country Code],
    o.[Supplier Country Id] = src.[Supplier Country Id],
    o.[Supplier State] = src.[Supplier State],
    o.[Supplier Zip] = src.[Supplier Zip],
    o.[Supplier Email] = src.[Supplier Email],
    o.[Supplier Name] = src.[Supplier Name] 
FROM usr.OrderLine o   
JOIN (  
    SELECT DISTINCT
        orl_id AS [Order Line ID],
        ord_Id AS [Order Id],  
        ord_parentOrderId AS [Parent Order Row Id],
        ord_orderTypeCode AS [Type],
        ord_reference AS [Reference Number],
        ord_invoiceReference AS [Invoice Reference],
        ord_orderStatusName AS [Status],
        ord_allocationStatusCode AS [Allocation Status],
        ord_stockStatusCode AS [Inventory Status],
        ord_shippingStatusCode AS [Shipping Status],
        ord_orderPaymentStatus AS [Payment Status],
        ord_channelId AS [Channel ID],
        chn_name AS [Channel Name],
        con_billingAddressLine3 AS [Billing City],
        con_billingcountryId AS [Billing Country Id],
        con_billingCountryIsoCode AS [Billing Country Code],
        con_billingAddressLine4 AS [Billing State],
        con_billingPostalCode AS [Billing Zip],
        con_defaultaddressLine3 AS [Delivery City],
        con_defaultcountryId AS [Delivery Country Id],
        con_defaultcountryIsoCode AS [Delivery Country Code],
        con_defaultaddressLine4 AS [Delivery State],
        con_defaultPostalCode AS [Delivery Zip],
        ord_createdById AS [Created By ID],
        ord_staffOwnerContactId AS [Employee ID],
        ord_orderCurrencyCode AS [Currency],
        ord_placedOn AS [Order Date],
        ord_createdOn AS [Created At Date],
        ord_invoicetaxDate AS [Tax Date],
        ord_invoicedueDate AS [Original Invoice Due Date],
        ord_deliveryDate AS [Delivery Date],
        ord_exchangeRate AS [Exchange Rate],
        ord_fixedExchangeRate AS [Fixed Exchange Rate],
        ord_net AS [Net Value],
        orl_itemCostValue AS [Cost],
        ord_total AS [Revenue],
        orl_rowTaxValue AS [Tax Amount],
        orl_quantity AS [Quantity],
        CASE WHEN ord_historicalOrder = 0 THEN 'No' ELSE 'Yes' END AS [Historical Order (Yes / No)],
        CASE WHEN ord_isDropship = 0 THEN 'No' ELSE 'Yes' END AS [Is Dropship (Yes/No)],
        ord_leadSourceId AS [Lead Source ID],
        lsc_name AS [Lead Source Name],
        cmp_paymentMethodCode AS [Payment Method Code],
        cmp_paymentType AS [Payment Method],
        ord_costPriceListId AS [Cost Price ID],
        ord_priceListId AS [Price List],
        ord_shippingMethodId AS [Shipping Method ID],
        shm_name AS [Shipping Method],
        ord_warehouseId AS [Warehouse ID]
        ,[Supplier City] = CASE WHEN con_isSupplier = 1 THEN con_defaultaddressLine3 ELSE NULL END
        ,[Supplier Company] = CASE WHEN con_isSupplier = 1 THEN con_organisationName ELSE NULL END
        ,[Supplier Contact Id] = CASE WHEN con_isSupplier = 1 THEN con_id ELSE NULL END
        ,[Supplier Country Code] = CASE WHEN con_isSupplier = 1 THEN con_defaultcountryIsoCode ELSE NULL END
        ,[Supplier Country Id] = CASE WHEN con_isSupplier = 1 THEN con_defaultcountryId ELSE NULL END
        ,[Supplier State] = CASE WHEN con_isSupplier = 1 THEN con_defaultaddressLine4 ELSE NULL END
        ,[Supplier Zip] = CASE WHEN con_isSupplier = 1 THEN con_defaultPostalCode ELSE NULL END
        ,[Supplier Email] = CASE WHEN con_isSupplier = 1 THEN con_emailsPRI ELSE NULL END
        ,[Supplier Name] = CASE WHEN con_isSupplier = 1 THEN CONCAT(con_firstName, ' ', con_lastName) ELSE NULL END

    FROM dbo.tblOrderLine
    LEFT JOIN dbo.tblOrder ON orl_ord_id = ord_id
    LEFT JOIN dbo.tblContact ON ord_createdById = con_id
    LEFT JOIN dbo.tblLeadSource ON ord_leadSourceId = lsc_id
    LEFT JOIN dbo.tblCustomerPayment ON orl_ord_id = cmp_orderId
    LEFT JOIN dbo.tblShippingMethod ON ord_shippingMethodId = shm_id
    LEFT JOIN dbo.tblChannel ON ord_channelId = chn_id
) AS src ON o.[Order Line ID] = src.[Order Line ID];


-- Insert new records if they don’t already exist
WITH src AS (
    SELECT DISTINCT  
        orl_id, ord_id, ord_parentOrderId, ord_orderTypeCode, ord_reference, ord_invoiceReference, ord_orderStatusName,
        ord_allocationStatusCode, ord_stockStatusCode, ord_shippingStatusCode, ord_orderPaymentStatus, ord_channelId,
        chn_name, con_billingAddressLine3, con_billingcountryId, con_billingCountryIsoCode, con_billingAddressLine4,
        con_billingPostalCode, con_defaultaddressLine3, con_defaultcountryId, con_defaultcountryIsoCode,
        con_defaultaddressLine4, con_defaultPostalCode, ord_createdById, ord_staffOwnerContactId, ord_orderCurrencyCode,
        ord_placedOn, ord_createdOn, ord_invoicetaxDate, ord_invoicedueDate, ord_deliveryDate, ord_exchangeRate,
        ord_fixedExchangeRate, ord_net, orl_itemCostValue, ord_total, orl_rowTaxValue, orl_quantity,
        CASE WHEN ord_historicalOrder = 0 THEN 'No' ELSE 'Yes' END AS [Historical Order (Yes / No)],
        CASE WHEN ord_isDropship = 0 THEN 'No' ELSE 'Yes' END AS [Is Dropship (Yes/No)],
        ord_leadSourceId, lsc_name, cmp_paymentMethodCode, cmp_paymentType, ord_costPriceListId, ord_priceListId,
        ord_shippingMethodId, shm_name, ord_warehouseId,
        CASE WHEN con_isSupplier = 1 THEN con_defaultaddressLine3 ELSE NULL END AS [Supplier City],
        CASE WHEN con_isSupplier = 1 THEN con_organisationName ELSE NULL END AS [Supplier Company],
        CASE WHEN con_isSupplier = 1 THEN con_id ELSE NULL END AS [Supplier Contact Id],
        CASE WHEN con_isSupplier = 1 THEN con_defaultcountryIsoCode ELSE NULL END AS [Supplier Country Code],
        CASE WHEN con_isSupplier = 1 THEN con_defaultcountryId ELSE NULL END AS [Supplier Country Id],
        CASE WHEN con_isSupplier = 1 THEN con_defaultaddressLine4 ELSE NULL END AS [Supplier State],
        CASE WHEN con_isSupplier = 1 THEN con_defaultPostalCode ELSE NULL END AS [Supplier Zip],
        CASE WHEN con_isSupplier = 1 THEN con_emailsPRI ELSE NULL END AS [Supplier Email],
        CASE WHEN con_isSupplier = 1 THEN CONCAT(con_firstName, ' ', con_lastName) ELSE NULL END AS [Supplier Name]
    FROM dbo.tblOrderLine
    LEFT JOIN dbo.tblOrder ON orl_ord_id = ord_id
    LEFT JOIN dbo.tblContact ON ord_createdById = con_id
    LEFT JOIN dbo.tblLeadSource ON ord_leadSourceId = lsc_id
    LEFT JOIN dbo.tblCustomerPayment ON orl_ord_id = cmp_orderId
    LEFT JOIN dbo.tblShippingMethod ON ord_shippingMethodId = shm_id
    LEFT JOIN dbo.tblChannel ON ord_channelId = chn_id
)
INSERT INTO usr.OrderLine (
    [Order Line ID], [Order Id], [Parent Order Row Id], [Type], [Reference Number], [Invoice Reference], [Status],
    [Allocation Status], [Inventory Status], [Shipping Status], [Payment Status], [Channel ID],
    [Channel Name], [Billing City], [Billing Country Id], [Billing Country Code], [Billing State],
    [Billing Zip], [Delivery City], [Delivery Country Id], [Delivery Country Code], [Delivery State],
    [Delivery Zip], [Created By ID], [Employee ID], [Currency], [Order Date], [Created At Date],
    [Tax Date], [Original Invoice Due Date], [Delivery Date], [Exchange Rate], [Fixed Exchange Rate],
    [Net Value], [Cost], [Revenue], [Tax Amount], [Quantity], [Historical Order (Yes / No)],
    [Is Dropship (Yes/No)], [Lead Source ID], [Lead Source Name], [Payment Method Code],
    [Payment Method], [Cost Price ID], [Price List], [Shipping Method ID], [Shipping Method],
    [Warehouse ID], [Supplier City], [Supplier Company], [Supplier Contact Id],
    [Supplier Country Code], [Supplier Country Id], [Supplier State], [Supplier Zip], [Supplier Email],
    [Supplier Name]
)
SELECT * FROM src
WHERE NOT EXISTS (
    SELECT 1 FROM usr.OrderLine o WHERE o.[Order Line ID] = src.orl_id
);

    --LEFT JOIN dbo.tblOrderCustomField ON orl_ord_id = ocf_ord_id
    --LEFT JOIN dbo.tblOrderCustomFieldMetadata ON ocf_id = omd_id