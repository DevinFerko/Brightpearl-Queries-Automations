-- Ensure the table exists before altering
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ContactSuppliers' AND TABLE_SCHEMA = 'usr')
BEGIN
    CREATE TABLE usr.ContactSuppliers  
    (  
        [Contac Id] INT PRIMARY KEY,  
        [Organization Id] INT,  
        [Organization Name] NVARCHAR(255),  
        [Credit Limit] DECIMAL(18,2),  
        [Credit Term Days] INT,  
        [Credit Term Type] INT,  
        [Currency Id] INT,  
        [Discount Percent] DECIMAL(5,2),  
        [Email] NVARCHAR(255),  
        [First Name] NVARCHAR(100),  
        [Last Name] NVARCHAR(100),  
        [Lead Source Id] INT,  
        [Lead Source] NVARCHAR(255),  
        [Nominal Code] INT,  
        [Owner Id] INT,  
        [Price List Id] INT,  
        [Trade Status] NVARCHAR(50),  
        [Staff (Yes/No)] NVARCHAR(3),  
        [Supplier (Yes/No)] NVARCHAR(3),  
        [Receive Newsletter (Yes/No)] NVARCHAR(3),  
        [TagId] INT  
    );
END;

-- Update existing records (DO NOT update ContactId since it's a primary key)
UPDATE cs
SET
    [Organization Id] = src.[Organization Id],  
    [Organization Name] = src.[Organization Name],  
    [Credit Limit] = src.[Credit Limit],  
    [Credit Term Days] = src.[Credit Term Days],  
    [Credit Term Type] = src.[Credit Term Type],  
    [Currency Id] = src.[Currency Id],  
    [Discount Percent] = src.[Discount Percent],  
    [Email] = src.[Email],  
    [First Name] = src.[First Name],  
    [Last Name] = src.[Last Name],  
    [Lead Source Id] = src.[Lead Source Id],  
    [Lead Source] = src.[Lead Source],  
    [Nominal Code] = src.[Nominal Code],  
    [Owner Id] = src.[Owner Id],  
    [Price List Id] = src.[Price List Id],  
    [Trade Status] = src.[Trade Status],  
    [Staff (Yes/No)] = src.[Staff (Yes/No)],  
    [Supplier (Yes/No)] = src.[Supplier (Yes/No)],  
    [Recieve Newsletter (Yes/No)] = src.[Recieve Newsletter (Yes/No)],  
    [Tag Id] = src.[Tag Id] 
FROM usr.ContactSuppliers cs  
JOIN (
    SELECT
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
) AS src ON cs.[Contact Id] = src.[Contact Id] AND 
    cs.[First Name] = src.[First Name] AND 
    cs.[Last Name] = src.[Last Name] AND 
    cs.[Email] = src.[Email] AND 
    cs.[Organization Name] = src.[Organization Name] AND 
    cs.[Organization Id] = src.[Organization Id];

-- Insert new records if they don’t already exist
WITH RankedContacts AS (
    SELECT
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
        cct_cta_id AS [Tag Id],
        ROW_NUMBER() OVER (PARTITION BY con_id ORDER BY cct_cta_id ASC) AS rn
    FROM dbo.tblContact
    LEFT JOIN dbo.tblLeadSource ON con_assignmentLeadSourceId = lsc_id
    LEFT JOIN dbo.tblContactCTag ON con_id = cct_con_id
)
INSERT INTO usr.ContactSuppliers (
    [Contact Id], [Organization Id], [Organization Name], [Credit Limit], 
    [Credit Term Days], [Credit Term Type], [Currency Id], [Discount Percent], 
    [Email], [First Name], [Last Name], [Lead Source Id], [Lead Source], 
    [Nominal Code], [Owner Id], [Price List Id], [Trade Status], 
    [Staff (Yes/No)], [Supplier (Yes/No)], [Recieve Newsletter (Yes/No)], [Tag Id]
)
SELECT DISTINCT 
    [Contact Id], [Organization Id], [Organization Name], [Credit Limit], 
    [Credit Term Days], [Credit Term Type], [Currency Id], [Discount Percent], 
    [Email], [First Name], [Last Name], [Lead Source Id], [Lead Source], 
    [Nominal Code], [Owner Id], [Price List Id], [Trade Status], 
    [Staff (Yes/No)], [Supplier (Yes/No)], [Recieve Newsletter (Yes/No)], [Tag Id]
FROM RankedContacts
WHERE rn = 1  -- Ensure only one row per Contact Id
AND NOT EXISTS (
    SELECT 1 FROM usr.ContactSuppliers cs WHERE cs.[Contact Id] = RankedContacts.[Contact Id]
);

