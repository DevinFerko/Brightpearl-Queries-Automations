SELECT DISTINCT
    o.[Order ID] 
    ,o.[Invoice Reference]
    ,o.[Reference Number]
    ,o.[Status]
    ,(j.[First Name] + ' ' + j.[Last Name]) AS [Customer]
    ,o.[Revenue]
    ,o.[Created At Date]
    ,o.[Shipping Method]
FROM 
    usr.OrdersView AS o
LEFT JOIN (
    SELECT [Order ID], [First Name], [Last Name]
    FROM usr.JournalView AS j1
    WHERE [Journal ID] = (SELECT MIN([Journal ID]) FROM usr.JournalView AS j2 WHERE j1.[Order ID] = j2.[Order ID])
) AS j ON o.[Order ID] = j.[Order ID]
WHERE
    o.[Type] = 'SO'
    AND o.[Status] NOT IN ('Cancelled', 'Cancelled Order - Rec Req', 'Cancelled SO Refund Due', 'Quote sent', 'Failed Quotes')
    AND o.[Original Invoice Due Date] IS NOT NULL
    AND o.[Tax Date] >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
    AND o.[Tax Date] < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0);