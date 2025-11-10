-- Update existing records in usr.Journals
UPDATE j
SET
    j.[Contact ID] = src.[Contact ID],  
    j.[Company] = src.[Company],  
    j.[First Name] = src.[First Name],  
    j.[Last Name] = src.[Last Name],  
    j.[Channel ID] = src.[Channel ID],  
    j.[Channel] = src.[Channel],  
    j.[Email] = src.[Email],  
    j.[Description] = src.[Description],  
    j.[Created Contact ID] = src.[Created Contact ID],  
    j.[Due Date] = src.[Due Date],  
    j.[Journal Due Date] = src.[Journal Due Date],  
    j.[Journal Entered Date] = src.[Journal Entered Date],  
    j.[Tax Date] = src.[Tax Date],  
    j.[Tax Reconciliation Date] = src.[Tax Reconciliation Date],  
    j.[Tax Code ID] = src.[Tax Code ID],  
    j.[Currency ID] = src.[Currency ID],  
    j.[Exchange Rate] = src.[Exchange Rate],  
    j.[Order ID] = src.[Order ID],  
    j.[Invoice Reference] = src.[Invoice Reference],  
    j.[Journal Type] = src.[Journal Type],  
    j.[Nominal Code] = src.[Nominal Code],  
    j.[Nominal Code Name] = src.[Nominal Code Name],  
    j.[Project ID] = src.[Project ID],  
    j.[Transaction Credit] = src.[Transaction Credit],  
    j.[Transaction Debit] = src.[Transaction Debit],  
    j.[Journal Credit] = src.[Journal Credit],  
    j.[Journal Debit] = src.[Journal Debit],  
    j.[Account Reference] = src.[Account Reference],  
    j.[Credit Limit] = src.[Credit Limit],  
    j.[Credit Term Days] = src.[Credit Term Days],  
    j.[Financial Details Currency ID] = src.[Financial Details Currency ID],  
    j.[Discount Percent] = src.[Discount Percent],  
    j.[Lead Source ID] = src.[Lead Source ID],  
    j.[Lead Source] = src.[Lead Source],  
    j.[Price List ID] = src.[Price List ID],  
    j.[Staff (Yes/No)] = src.[Staff (Yes/No)],  
    j.[Supplier (Yes/No)] = src.[Supplier (Yes/No)],  
    j.[Trade Status] = src.[Trade Status]  
FROM usr.Journals j  
JOIN (
    -- This is the source data from Script 1
    SELECT DISTINCT  
        j.jou_id AS [Journal ID],  
        j.jou_contactId AS [Contact ID],  
        c.con_organisationName AS [Company],  
        c.con_firstName AS [First Name],  
        c.con_lastName AS [Last Name],  
        jtr_assignmentChannelId AS [Channel ID],  
        ch.chn_name AS [Channel],  
        c.con_emailsPRI AS [Email],  
        j.jou_description AS [Description],  
        j.jou_createdByContactId AS [Created Contact ID],  
        j.jou_dueDate AS [Due Date],  
        j.jou_dueDate AS [Journal Due Date],  
        j.jou_createdOn AS [Journal Entered Date],  
        j.jou_taxDate AS [Tax Date],  
        j.jou_taxReconciliationDate AS [Tax Reconciliation Date],  
        jt.jtr_taxCode AS [Tax Code ID],  
        j.jou_currencyId AS [Currency ID],  
        j.jou_exchangeRate AS [Exchange Rate],  
        jt.jtr_orderId AS [Order ID],  
        jt.jtr_invoiceReference AS [Invoice Reference],  
        j.jou_journalTypeCode AS [Journal Type],  
        jt.jtr_nominalCode AS [Nominal Code],  
        n.nom_name AS [Nominal Code Name],  
        o.ord_projectId AS [Project ID],  
        CASE WHEN jt.jtr_creditDebit = 'C' THEN jt.jtr_transactionAmount ELSE NULL END AS [Transaction Credit],  
        CASE WHEN jt.jtr_creditDebit = 'D' THEN jt.jtr_transactionAmount ELSE NULL END AS [Transaction Debit],
        CASE WHEN jt.jtr_creditDebit = 'C' THEN jt.jtr_transactionAmount ELSE NULL END AS [Journal Credit],
        CASE WHEN jt.jtr_creditDebit = 'D' THEN jt.jtr_transactionAmount ELSE NULL END AS [Journal Debit],  
        c.con_assignmentAccountReference AS [Account Reference],  
        c.con_financialDetailsCreditLimit AS [Credit Limit],  
        c.con_financialDetailsCreditTermDays AS [Credit Term Days],  
        c.con_financialDetailsCurrencyId AS [Financial Details Currency ID],  
        c.con_financialDetailsDiscountPercentage AS [Discount Percent],  
        jtr_assignmentLeadSourceId AS [Lead Source ID],  
        ls.lsc_name AS [Lead Source],  
        c.con_financialDetailsPriceListID AS [Price List ID],  
        CASE WHEN con_isStaff = 0 THEN 'No' ELSE 'Yes' END AS [Staff (Yes/No)],  
        CASE WHEN con_isStaff = 0 THEN 'No' ELSE 'Yes' END AS [Supplier (Yes/No)],  
        c.con_tradeStatus AS [Trade Status]  
    FROM dbo.tblJournal AS j  
    LEFT JOIN dbo.tblJournalTransaction AS jt ON j.jou_id = jt.jtr_jou_id  
    LEFT JOIN dbo.tblOrder AS o ON jt.jtr_orderId = o.ord_id  
    LEFT JOIN dbo.tblContact AS c ON j.jou_contactId = c.con_id  
    LEFT JOIN dbo.tblChannel AS ch ON jtr_assignmentChannelId = ch.chn_id  
    LEFT JOIN dbo.tblNominal AS n ON jt.jtr_nominalCode = n.nom_code  
    LEFT JOIN dbo.tblLeadSource AS ls ON c.con_assignmentLeadSourceId = ls.lsc_id  
) AS src 
ON j.[Journal ID] = src.[Journal ID];

-- Insert new records into usr.Journals if they do not exist
INSERT INTO usr.Journals (
    [Journal ID], [Contact ID], [Company], [First Name], [Last Name], [Channel ID], [Channel], [Email], 
    [Description], [Created Contact ID], [Due Date], [Journal Due Date], [Journal Entered Date], [Tax Date], [Tax Reconciliation Date], 
    [Tax Code ID], [Currency ID], [Exchange Rate], [Order ID], [Invoice Reference], [Journal Type], 
    [Nominal Code], [Nominal Code Name], [Project ID], [Transaction Credit], [Transaction Debit], [Journal Credit], [Journal Debit], 
    [Account Reference], [Credit Limit], [Credit Term Days], [Financial Details Currency ID], 
    [Discount Percent], [Lead Source ID], [Lead Source], [Price List ID], [Staff (Yes/No)], [Supplier (Yes/No)], [Trade Status]
)
SELECT DISTINCT  
    src.*
FROM (
    -- Reusing the same subquery from above
    SELECT DISTINCT  
        j.jou_id AS [Journal ID],  
        j.jou_contactId AS [Contact ID],  
        c.con_organisationName AS [Company],  
        c.con_firstName AS [First Name],  
        c.con_lastName AS [Last Name],  
        jtr_assignmentChannelId AS [Channel ID],  
        ch.chn_name AS [Channel],  
        c.con_emailsPRI AS [Email],  
        j.jou_description AS [Description],  
        j.jou_createdByContactId AS [Created Contact ID],  
        j.jou_dueDate AS [Due Date],  
        j.jou_dueDate AS [Journal Due Date],  
        j.jou_createdOn AS [Journal Entered Date],  
        j.jou_taxDate AS [Tax Date],  
        j.jou_taxReconciliationDate AS [Tax Reconciliation Date],  
        jt.jtr_taxCode AS [Tax Code ID],  
        j.jou_currencyId AS [Currency ID],  
        j.jou_exchangeRate AS [Exchange Rate],  
        jt.jtr_orderId AS [Order ID],  
        jt.jtr_invoiceReference AS [Invoice Reference],  
        j.jou_journalTypeCode AS [Journal Type],  
        jt.jtr_nominalCode AS [Nominal Code],  
        n.nom_name AS [Nominal Code Name],  
        o.ord_projectId AS [Project ID],  
        CASE WHEN jt.jtr_creditDebit = 'C' THEN jt.jtr_transactionAmount ELSE NULL END AS [Transaction Credit],  
        CASE WHEN jt.jtr_creditDebit = 'D' THEN jt.jtr_transactionAmount ELSE NULL END AS [Transaction Debit],
        c.con_tradeStatus AS [Trade Status]  
    FROM dbo.tblJournal AS j  
    LEFT JOIN dbo.tblJournalTransaction AS jt ON j.jou_id = jt.jtr_jou_id  
) AS src
WHERE NOT EXISTS (
    SELECT 1 FROM usr.Journals jn WHERE jn.[Journal ID] = src.[Journal ID]
);
