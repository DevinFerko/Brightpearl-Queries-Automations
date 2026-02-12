WITH data as (
    SELECT DISTINCT -- Added Distinct to remove any possible duplicated rows
        CAST(ord_placedOn AS date) AS order_date,
        
        CAST(ord_invoicetaxDate AS date) AS invoice_tax_date, -- For Tax Dates, can also be used to filter for invoiced or not
        CAST(ord_createdOn AS date) AS created_on_date, -- For created on Dates 
        
        ord_channelId, -- one half of revenue source calc (Brand)
        ord_leadSourceId, -- second half (Brand)
        
        ord_id,
        COUNT(DISTINCT ord_id) AS order_count, 
        sum(ord_net) as net,
        sum(ord_taxAmount) as texAmount,
        sum(ord_baseNet) as baseNet,
        sum(ord_baseTaxAmount) as baseTaxAmount,
        sum(ord_baseTotal) as baseTotal,
        sum(ord_total) as total
    FROM dbo.tblOrder
    WHERE CAST(ord_placedOn AS date) = '2026-01-27'
    GROUP BY CAST(ord_placedOn AS date),
        ord_channelId, ord_id, CAST(ord_invoicetaxDate AS date),CAST(ord_createdOn AS date), ord_leadSourceId, ord_net
),


channel as (
    SELECT DISTINCT -- Added Distinct to remove any possible duplicated rows
        chn_id, 
        chn_name 
    FROM [dbo].[tblChannel]
    Group By chn_id, chn_name),


products as ( 
    SELECT DISTINCT -- Added Distinct to remove any possible duplicated rows
        orl_ord_id,
        orl_productID,
        orl_productSku, 
        orl_productName, 
        orl_quantity,
        
        CASE -- Case statement for categories, in dbo.tblProductCustomField table
            WHEN pcf_name = 'PCF_CAT1' THEN pcf_value -- Use PCF_CAT2, PCF_CAT3, PCF_CAT4 for other categories.
        END AS primary_category 

    FROM [dbo].[tblOrderLine]
    LEFT JOIN dbo.tblProductCustomField ON orl_productId = pcf_prd_id
    
    )

SELECT DISTINCT -- Added Distinct to remove any possible duplicated rows
    primary_category,
    sum(net) 
FROM data d
LEFT JOIN channel c ON d.ord_channelId = c.chn_id
LEFT JOIN products p ON d.ord_id = p.orl_ord_id
--WHERE invoice_tax_date = '2026-12-27' -- Will get orders with invoiced dates
Group by primary_category
--WHERE invoice_tax_date = '2026-12-27' -- Will get orders with invoiced dates