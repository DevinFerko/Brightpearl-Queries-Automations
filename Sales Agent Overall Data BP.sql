SELECT DISTINCT TOP(1000)
    CAST(o.ord_invoicetaxDate AS date) AS [Tax Date]
    ,o.ord_id AS [Order ID]
    ,o.ord_orderTypeCode AS [Order Type]
    ,o.ord_orderStatusName AS [Order Status]
    ,o.ord_total AS [Total]
    ,o.ord_baseTotal AS [Paid]
    ,o.ord_net AS [Net Value]
    ,o.ord_leadSourceId AS [Lead Source ID]
    ,o.ord_channelId AS [Channel ID]
    ,o.ord_createdById AS [Created By ID]
    ,cb.con_firstName + ' ' + cb.con_lastName AS [Created By Name]
    ,o.ord_staffOwnerContactId AS [Assigned to ID]
    ,c.con_firstName + ' ' + c.con_lastName AS [Assigned to Name]
FROM
    dbo.tblOrder AS o
LEFT JOIN
    dbo.tblContact AS c ON o.ord_staffOwnerContactId = c.con_id
LEFT JOIN
    dbo.tblContact AS cb ON o.ord_createdById = cb.con_id
WHERE
    (o.ord_orderStatusName = 'Invoiced' OR o.ord_orderStatusName = 'Ready to Ship')
    AND o.ord_invoicetaxDate >= '2024-12-01'