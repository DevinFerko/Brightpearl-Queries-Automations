SELECT DISTINCT
    CAST(j.[Tax Date] AS DATE) AS [Tax Date]
    ,CASE
        WHEN j.[Channel] = 'Tap Warehouse' THEN 'Tap Warehouse'
        WHEN j.[Channel] = 'Drench' THEN 'Drench'
        WHEN j.[Channel] = 'Only Radiators' THEN 'OR'
        WHEN j.[Channel] = 'Trade' THEN 'Trade'
        WHEN j.[Channel] = 'TW Trade' THEN 'Trade'
        WHEN j.[Channel] = 'DR Trade' THEN 'Trade'
        WHEN j.[Channel] = 'OR Trade' THEN 'Trade'
        WHEN j.[Channel] = 'Remedials' THEN 'Remedials'
        WHEN j.[Channel] = 'Beyond Outlet' THEN 'Outlet'
        ELSE 'Other'
        END AS [Revenue Source]
    ,CASE 
        WHEN j.[Journal Type] = 'GO' AND j.[Nominal Code] = '5000' AND (j.[Contact ID] = 0 OR j.[Contact ID] IS NULL) THEN j.[Journal Debit] 
        ELSE NULL
    END AS [Goods Out Cost Debit]
    ,CASE 
        WHEN j.[Journal Type] = 'GO' AND j.[Nominal Code] = '5000' AND (j.[Contact ID] = 0 OR j.[Contact ID] IS NULL) THEN j.[Journal Credit] 
        ELSE NULL
    END AS [Goods Out Cost Credit]
    ,CASE 
        WHEN j.[Journal Type] = 'SG' AND j.[Nominal Code] = '5000'  THEN j.[Journal Debit] 
        ELSE NULL
    END AS [Returns Cost Debit]
    ,CASE 
        WHEN j.[Journal Type] = 'SG' AND j.[Nominal Code] = '5000'  THEN j.[Journal Credit] 
        ELSE NULL
    END AS [Returns Cost Credit]
    ,CASE 
        WHEN j.[Journal Type] = 'SI' AND j.[Invoice Reference] LIKE '%SI-%' AND j.[Nominal Code] IN ('4000', '4002', '4010', '4030', '4040') THEN j.[Journal Credit] 
    END AS [Sales Revenue Credit]
    ,CASE 
        WHEN j.[Journal Type] = 'SI' AND j.[Invoice Reference] LIKE '%SI-%' AND j.[Nominal Code] IN ('4000', '4002', '4010', '4030', '4040') THEN j.[Journal Debit] 
    END AS [Sales Revenue Debit]
    ,CASE 
        WHEN j.[Journal Type] = 'SC' AND j.[Invoice Reference] LIKE '%SC-%' AND j.[Nominal Code] IN ('4000', '4002', '4010', '4030', '4040') THEN j.[Journal Credit] 
    END AS [Sales Refunds Credit]
    ,CASE 
        WHEN j.[Journal Type] = 'SC' AND j.[Invoice Reference] LIKE '%SC-%' AND j.[Nominal Code] IN ('4000', '4002', '4010', '4030', '4040') THEN j.[Journal Debit] 
    END AS [Sales Refunds Debit]
    ,j.[Contact ID]
    ,j.[Channel]
    ,j.[Journal ID]
    ,j.[Order ID]
    ,j.[Invoice Reference]
    ,j.[Journal Type]
    ,j.[Nominal Code]
    ,j.[Nominal Code Name]
    ,j.[Transaction Credit]
    ,j.[Transaction Debit]
    ,j.[Journal Credit]
    ,j.[Journal Debit]
    ,j.[Lead Source ID]
    ,j.[Lead Source]
    ,CASE 
        WHEN o.[Type] = 'SO'
        AND o.[Status] NOT IN ('Cancelled', 'Cancelled SO Refund Due', 'Unconfirmed Cancelled Dropship', 'Failed Quotes', 'Quote sent')
        AND o.[Shipping Method] = 'Supplier Direct Delivery'
        AND o.[Invoice Reference] <> ''
        AND o.[Original Invoice Due Date] IS NOT NULL
        AND oi.[Nominal Code] IN ('4000', '4002', '4010', '4030')
        THEN oi.[Cost] 
    END AS [Cost of Dropshipped Goods]
    ,j.[Tax Code ID]
  
FROM
    usr.Journals as j 
    INNER JOIN usr.Orders AS o ON j.[Order ID] = o.[Order ID]
    LEFT JOIN usr.OrderItems AS oi ON o.[Order ID] = oi.[Order ID] 

WHERE j.[Tax Date] >= '2023-01-01' 


--AND j.[Journal ID] = 4159668
--WHERE j.[Journal ID] = 4118145
--WHERE j.[Nominal Code] = '4000' OR j.[Nominal Code] = '5000'
--ORDER BY j.[Journal ID] DESC