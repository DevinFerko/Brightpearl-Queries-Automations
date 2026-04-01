SELECT 
    SUM(jtr_transactionAmount) AS transaction_amount
FROM dbo.tblJournalTransaction
LEFT JOIN dbo.tblJournal ON jou_id = jtr_jou_id
WHERE jou_taxDate = '2026-03-16'