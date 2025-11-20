SELECT 
    SUM(jtr_transactionAmount) AS TotalTransactionAmount
    ,jou_taxDate
FROM dbo.tblJournalTransaction
INNER JOIN dbo.tblJournal ON jtr_jou_id = jou_id
--WHERE jou_taxDate < '2025-11-20 00:00:00.0000000'
GROUP BY jou_taxDate
ORDER BY jou_taxDate DESC;