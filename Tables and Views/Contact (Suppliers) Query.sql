SELECT
    [Contact Id] = con_id
    ,[Organization Id] = con_organisationOrganisationId
    ,[Organization Name] = con_organisationName
    ,[Credit Limit] = con_financialDetailsCreditLimit
    ,[Credit Term Days] = con_financialDetailsCreditTermDays
    ,[Credit Term Type] =con_financialDetailsCreditTermTypeId
    ,[Currency Id] = con_financialDetailsCurrencyId
    ,[Discount Percent] = con_financialDetailsDiscountPercentage
    ,[Email] = con_emailsPRI
    ,[First Name] = con_firstName
    ,[Last Name] = con_lastName
    ,[Lead Source Id] = con_assignmentLeadSourceId
    ,[Lead Source] = lsc_name
    ,[Nominal Code] = con_financialDetailsNominalCode
    ,[Owner Id] = con_assignmentStaffOwnerContactId
    ,[Price List Id] = con_financialDetailsPriceListID
    ,[Trade Status] = con_tradeStatus
    ,[Staff (Yes/No)] = CASE WHEN con_isStaff = 0 THEN 'No' ELSE 'Yes' END
    ,[Supplier (Yes/No)] = CASE WHEN con_isStaff = 0 THEN 'No' ELSE 'Yes' END
    ,[Recieve Newsletter (Yes/No)] = CASE WHEN con_marketingDetailsIsReceiveEmailNewsletter = 0 THEN 'No' ELSE 'Yes' END
    ,[Tag Id] = cct_cta_id


FROM
    dbo.tblContact
LEFT JOIN dbo.tblLeadSource ON con_assignmentLeadSourceId = lsc_id
LEFT JOIN dbo.tblContactCTag ON con_id = cct_con_id