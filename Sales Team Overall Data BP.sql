SELECT DISTINCT
    CAST(o.ord_invoicetaxDate AS date) AS [Tax Date]
    ,o.ord_id AS [Order ID]
    ,o.ord_orderTypeCode AS [Order Type]
    ,o.ord_orderStatusName AS [Order Status]
    ,o.ord_net AS [Net Value]
    ,o.ord_parentOrderId AS [Parent Order]
    ,o.ord_leadSourceId AS [Lead Source ID]
    ,o.ord_channelId AS [Channel ID]
    ,o.ord_staffOwnerContactId AS [Staff Owner Contact ID]
    ,c.con_firstName + ' ' + c.con_lastName AS [Staff Owner Name]
FROM
    dbo.tblOrder AS o
LEFT JOIN
    dbo.tblContact AS c ON o.ord_staffOwnerContactId = c.con_id
WHERE
    o.ord_orderStatusName = 'Invoiced'
    AND o.ord_invoicetaxDate >= '2024-12-01'