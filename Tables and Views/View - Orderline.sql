CREATE OR ALTER VIEW usr.OrderLineView
AS
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