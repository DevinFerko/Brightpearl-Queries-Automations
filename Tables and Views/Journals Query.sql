SELECT DISTINCT
    j.jou_contactId AS 'Contact ID',
    c.con_organisationName AS 'Company',
    c.con_firstName AS 'First Name',
    c.con_lastName AS 'Last Name',
    jtr_assignmentChannelId AS 'Channel ID',
    ch.chn_name AS 'Channel',
    c.con_emailsPRI AS 'Email',
    j.jou_description AS 'Description',
    j.jou_createdByContactId AS 'Created Contact ID',
    j.jou_dueDate AS 'Due Date',
    j.jou_dueDate AS 'Journal Due Date',
    j.jou_createdOn AS 'Journal Entered Date',
    j.jou_taxDate AS 'Tax Date',
    j.jou_taxReconciliationDate AS 'Tax Reconciliation Date',
    jt.jtr_taxCode AS 'Tax Code ID',
    j.jou_currencyId AS 'Currency ID',
    j.jou_exchangeRate AS 'Exchange Rate',
    j.jou_id AS 'Journal ID',
    jt.jtr_orderId AS 'Order ID',
    jt.jtr_invoiceReference AS 'Invoice Reference',
    j.jou_journalTypeCode AS 'Journal Type',
    jt.jtr_nominalCode AS 'Nominal Code',
    n.nom_name AS 'Nominal Code Name',
    o.ord_projectId AS 'Project ID',
    CASE 
        WHEN jt.jtr_creditDebit = 'C' THEN jt.jtr_transactionAmount 
        ELSE NULL
    END AS 'Transaction Credit',
    CASE 
        WHEN jt.jtr_creditDebit = 'D' THEN jt.jtr_transactionAmount
        ELSE NULL
    END AS 'Transaction Debit',
    CASE 
        WHEN jt.jtr_creditDebit = 'C' THEN jt.jtr_transactionAmount
        ELSE NULL
    END AS 'Journal Credit',
    CASE 
        WHEN jt.jtr_creditDebit = 'D' THEN jt.jtr_transactionAmount
        ELSE NULL
    END AS 'Journal Debit',
    c.con_assignmentAccountReference AS 'Account Reference',
    c.con_financialDetailsCreditLimit AS 'Credit Limit',
    c.con_financialDetailsCreditTermDays AS 'Credit Term Days',
    c.con_financialDetailsCurrencyId AS 'Currency ID',
    c.con_financialDetailsDiscountPercentage AS 'Discount Percent',
    jtr_assignmentLeadSourceId AS 'Lead Source ID',
    ls.lsc_name AS 'Lead Source',
    c.con_financialDetailsPriceListID AS 'Price List ID',
    [Staff (Yes/No)] = CASE WHEN con_isStaff = 0 THEN 'No' ELSE 'Yes' END,
    [Supplier (Yes/No)] = CASE WHEN con_isStaff = 0 THEN 'No' ELSE 'Yes' END,
    c.con_tradeStatus AS 'Trade Status'
FROM
    dbo.tblJournal AS j
LEFT JOIN
    dbo.tblJournalTransaction AS jt ON j.jou_id = jt.jtr_jou_id
LEFT JOIN
    dbo.tblOrder AS o ON jt.jtr_orderId = o.ord_id 
LEFT JOIN
    dbo.tblContact AS c ON j.jou_contactId = c.con_id
LEFT JOIN
    dbo.tblChannel AS ch ON jtr_assignmentChannelId = ch.chn_id
LEFT JOIN
    dbo.tblNominal AS n ON jt.jtr_nominalCode = n.nom_code
LEFT JOIN
    dbo.tblLeadSource AS ls ON c.con_assignmentLeadSourceId = ls.lsc_id

WHERE jou_id = 5520087