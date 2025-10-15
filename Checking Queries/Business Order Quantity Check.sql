SELECT DISTINCT
    c.con_emailsPRI,
    j.jou_taxDate,
    SUM(ol.orl_quantity)
FROM tblJournal AS j
INNER JOIN tblJournalTransaction AS jt ON j.jou_id = jt.jtr_jou_id
INNER JOIN tblOrder AS o ON jt.jtr_orderId = o.ord_id
INNER JOIN tblOrderLine AS ol ON o.ord_id = ol.orl_ord_id
INNER JOIN tblContact AS c ON j.jou_contactId = c.con_id
WHERE c.con_emailsPRI = 'accounts@islandbathrooms.co.uk'
GROUP BY c.con_emailsPRI, j.jou_taxDate
ORDER BY j.jou_taxDate DESC;