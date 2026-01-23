SELECT DISTINCT TOP(100)
    CAST(ord_invoicetaxDate AS DATE)
    ,ord_id
    ,ord_orderStatusId
    ,ord_orderStatusName
    ,op.par_addressFullName
    ,o.ord_net
    ,o.ord_parentOrderId
    ,o.ord_leadSourceId
    ,o.ord_channelId
    ,(c.con_firstName + ' ' + con_lastName) AS [Assigned to]
FROM
    dbo.tblOrder AS o
JOIN
    dbo.tblContact AS c ON o.ord_staffOwnerContactId = c.con_id
JOIN
    dbo.tblOrderParty AS op ON o.ord_id = op.par_ord_id 
WHERE
    o.ord_id = 2250165
    AND op.par_type = 'customer'
