SELECT DISTINCT
    CASE
        WHEN o.ord_leadSourceId = 8 THEN 'LiveChat'
        WHEN o.ord_leadSourceId = 5 THEN 'Telephone'
        WHEN o.ord_leadSourceId = 7 THEN 'Email'
    END AS 'Lead Source Name',
    SUM(ol.orl_quantity) AS 'Items',
    APPROX_COUNT_DISTINCT(o.ord_id) AS 'Orders'
FROM
    dbo.tblOrder AS o 
LEFT JOIN
    dbo.tblOrderLine AS ol ON o.ord_id = ol.orl_ord_id
LEFT JOIN
    dbo.tblContact AS c ON o.ord_staffOwnerContactId = c.con_id
WHERE
    o.ord_channelId IN (2,7,8)
    AND o.ord_orderTypeCode = 'SO'
    AND o.ord_invoicetaxDate IS NOT NULL
    AND o.ord_invoicetaxDate >= '2026/01/01'
    AND o.ord_invoicetaxDate <= '2026/01/31'
    AND c.con_firstName = 'Lottie'
GROUP BY
    o.ord_leadSourceId