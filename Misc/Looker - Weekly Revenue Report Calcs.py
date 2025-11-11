# Ranked Calc
case(
  when(${revenue_source}="Tap Web","A"),
  when(${revenue_source}="Tap Sales Team","B"),
  when(${revenue_source}="Drench Web","C"),
  when(${revenue_source}="Drench Sales Team","D"),
  when(${revenue_source}="Design","E"),
  when(${revenue_source}="OR","F"),
  when(${revenue_source}="Trade","G"),
  when(${revenue_source}="Outlet","H"),
  when(${revenue_source}="Other","I"),
  "I")

# Revenue Source Calc
case(
  when(${fact_brightpearl_journals_br.channel}="Tap Warehouse" AND ${fact_brightpearl_journals_br.lead_source_id}=0 AND ${fact_brightpearl_journals_br.lead_source_id}!=9, "Tap Web"),
  when(${fact_brightpearl_journals_br.channel}="Tap Warehouse" AND ${fact_brightpearl_journals_br.lead_source_id}!=0 AND ${fact_brightpearl_journals_br.lead_source_id}!=9, "Tap Sales Team"),
  when(${fact_brightpearl_journals_br.channel}="Drench" AND ${fact_brightpearl_journals_br.lead_source_id}=0 AND ${fact_brightpearl_journals_br.lead_source_id}!=9, "Drench Web"),
  when(${fact_brightpearl_journals_br.channel}="Drench" AND ${fact_brightpearl_journals_br.lead_source_id}!=0 AND ${fact_brightpearl_journals_br.lead_source_id}!=9, "Drench Sales Team"),
  

  when(${fact_brightpearl_journals_br.lead_source_id}=9, "Design"),
  
  when(${fact_brightpearl_journals_br.channel}="Only Radiators", "OR"),
  when(${fact_brightpearl_journals_br.channel}="Trade", "Trade"),
  when(${fact_brightpearl_journals_br.channel}="TW Trade", "Trade"),
  when(${fact_brightpearl_journals_br.channel}="DR Trade", "Trade"),
  when(${fact_brightpearl_journals_br.channel}="OR Trade", "Trade"),
  when(${fact_brightpearl_journals_br.channel}="Remedials", "Remedials"),
  when(${fact_brightpearl_journals_br.channel}="Beyond Outlet", "Outlet"),
  when(${fact_brightpearl_journals_br.channel}="Not in use - Tap Telephone", "Other"),
  when(${fact_brightpearl_journals_br.channel}="eBay: tapwarehouse", "Other"),
  when(${fact_brightpearl_journals_br.channel}="Beyond Retail", "Other"),
  when(${fact_brightpearl_journals_br.channel}="Amazon: UK", "Other"),
  when(${fact_brightpearl_journals_br.channel}="DO NOT USE - Old Magento", "Other"),
  
  "Other"
)

#Budget Revenue
case(
  when(${revenue_source}="Tap Web",pivot_index(${tap_web_budget},1)),
  when(${revenue_source}="Tap Sales Team",pivot_index(${tap_sales_team_budget},1)),
  when(${revenue_source}="Drench Web",pivot_index(${drench_web_budget},1)),
  when(${revenue_source}="Drench Sales Team",pivot_index(${drench_sales_team_budget},1)),
  when(${revenue_source}="Design",pivot_index(${design_budget},1)),
  when(${revenue_source}="OR",pivot_index(${or_budget},1)),
  when(${revenue_source}="Trade",pivot_index(${trade_budget},1)),
  when(${revenue_source}="Outlet",pivot_index(${outlet_budget},1)),
  when(${revenue_source}="Other",pivot_index(${other_budget},1)),
  when(${revenue_source}="Remedials",pivot_index(${remedials_budget},1)),
  0)

# Budget Revenue (Small table under large one (Totals)
sum(list(pivot_index(${drench_web_budget},1),pivot_index(${drench_sales_team_budget},1),pivot_index(${tap_web_budget},1),pivot_index(${tap_sales_team_budget},1),pivot_index(${or_budget},1),pivot_index(${trade_budget},1),pivot_index(${outlet_budget},1),pivot_index(${remedials_budget},1),pivot_index(${design_budget},1),pivot_index(${other_budget},1)))