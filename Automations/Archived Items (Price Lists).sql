SELECT 
    [SKU], 
    [Product ID],
    MAX(CASE WHEN [Price List Name] = 'Bulk' THEN [Price] END) AS [Bulk],
    MAX(CASE WHEN [Price List Name] = 'Conatainer (EUR) EXW' THEN [Price] END) AS [Conatainer (EUR) EXW],
    --MAX(CASE WHEN [Price List Name] = 'Conatainer (GBP) DAP' THEN [Price] END) AS [Conatainer (GBP) DAP],
    MAX(CASE WHEN [Price List Name] = 'Conatainer (GBP) DDP' THEN [Price] END) AS [Conatainer (GBP) DDP],
    MAX(CASE WHEN [Price List Name] = 'Conatainer (USD) DDP' THEN [Price] END) AS [Conatainer (USD) DDP],
    --MAX(CASE WHEN [Price List Name] = 'Conatainer (USD) FOB' THEN [Price] END) AS [Conatainer (USD) FOB],
    MAX(CASE WHEN [Price List Name] = 'Cost' THEN [Price] END) AS [Cost],
    MAX(CASE WHEN [Price List Name] = 'DRENCH' THEN [Price] END) AS [DRENCH],
    MAX(CASE WHEN [Price List Name] = 'LIST' THEN [Price] END) AS [LIST],
    MAX(CASE WHEN [Price List Name] = 'ONLYRADIATORS' THEN [Price] END) AS [ONLYRADIATORS],
    --MAX(CASE WHEN [Price List Name] = 'Pre Rebate Cost' THEN [Price] END) AS [Pre Rebate Cost],
    MAX(CASE WHEN [Price List Name] = 'RRP' THEN [Price] END) AS [RRP],
    MAX(CASE WHEN [Price List Name] = 'Single' THEN [Price] END) AS [Single]
    --MAX(CASE WHEN [Price List Name] = 'Special' THEN [Price] END) AS [Special]
FROM 
    usr.ProductsView
WHERE 
    [Status] = 'ARCHIVED'
    AND [Price List Name] IN ('Bulk', 'Conatainer (EUR) EXW', 'Conatainer (GBP) DAP', 'Conatainer (GBP) DDP', 'Conatainer (USD) DDP', 'Conatainer (USD) FOB', 'Cost',
    'DRENCH', 'LIST', 'ONLYRADIATORS', 'Pre Rebate Cost', 'RRP', 'Single', 'Special')
GROUP BY 
    [SKU], 
    [Product ID];
