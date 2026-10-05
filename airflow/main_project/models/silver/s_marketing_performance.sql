{{
  config(
    materialized = 'incremental',
    unique_key = 'campaign_id',
    )
}}
select 
  * except (created_timestamp, updated_timestamp),
  created_timestamp as marketing_performance_created_timestamp,
  updated_timestamp as marketing_performance_updated_timestamp
from 
  {{ source('blinkit_raw', 'marketing_performance') }}
{% if is_incremental() %}
  where updated_timestamp > coalesce((select max(marketing_performance_updated_timestamp) from {{ this }}), '1900-01-01')
{% endif %}
