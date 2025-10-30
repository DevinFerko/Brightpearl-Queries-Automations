SELECT
  i.item_name,
  i.item_id,
  event_date,
  event_name,
  traffic_source.source AS first_user_source,
  traffic_source.medium AS first_user_medium,
  traffic_source.name AS first_user_campaign,
  (
    SELECT value.string_value
    FROM UNNEST(event_params)
    WHERE key = "session_source"
  ) AS session_source,
  (
    SELECT value.string_value
    FROM UNNEST(event_params)
    WHERE key = "session_medium"
  ) AS session_medium,
  (
    SELECT value.string_value
    FROM UNNEST(event_params)
    WHERE key = "session_campaign"
  ) AS session_campaign,
  COUNT(*) AS event_count
FROM
  `ga4-data-XXXXXXX.analytics_XXXXXXX.events_*`,
  UNNEST(items) AS i
WHERE
  event_name IN ('view_item', 'add_to_cart', 'purchase')
GROUP BY
  i.item_name,
  i.item_id,
  event_name,
  event_date,
  first_user_source,
  first_user_medium,
  first_user_campaign,
  session_source,
  session_medium,
  session_campaign
ORDER BY
  event_count DESC