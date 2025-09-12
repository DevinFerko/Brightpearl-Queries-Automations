CREATE OR ALTER VIEW usr.ContactSuppliersView
AS
 SELECT DISTINCT
        con_id AS [Contact Id],
        con_organisationOrganisationId AS [Organization Id],
        con_organisationName AS [Organization Name],
        con_financialDetailsCreditLimit AS [Credit Limit],
        con_financialDetailsCreditTermDays AS [Credit Term Days],
        con_financialDetailsCreditTermTypeId AS [Credit Term Type],
        con_financialDetailsCurrencyId AS [Currency Id],
        con_financialDetailsDiscountPercentage AS [Discount Percent],
        con_emailsPRI AS [Email],
        con_firstName AS [First Name],
        con_lastName AS [Last Name],
        con_assignmentLeadSourceId AS [Lead Source Id],
        lsc_name AS [Lead Source],
        con_financialDetailsNominalCode AS [Nominal Code],
        con_assignmentStaffOwnerContactId AS [Owner Id],
        con_financialDetailsPriceListID AS [Price List Id],
        con_tradeStatus AS [Trade Status],
        CASE WHEN con_isStaff = 0 THEN 'No' ELSE 'Yes' END AS [Staff (Yes/No)],
        CASE WHEN con_isSupplier = 0 THEN 'No' ELSE 'Yes' END AS [Supplier (Yes/No)],
        CASE WHEN con_marketingDetailsIsReceiveEmailNewsletter = 0 THEN 'No' ELSE 'Yes' END AS [Recieve Newsletter (Yes/No)],
        cct_cta_id AS [Tag Id]
    FROM dbo.tblContact
    LEFT JOIN dbo.tblLeadSource ON con_assignmentLeadSourceId = lsc_id
    LEFT JOIN dbo.tblContactCTag ON con_id = cct_con_id