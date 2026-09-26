{{
  config(
    materialized = 'incremental',
    unique_key = 'delivery_partner_id',
    )
}}
select 
  delivery_partner_id,
  * except (delivery_partner_id, created_timestamp, updated_timestamp),
  created_timestamp as delivery_performance_created_timestamp, 
  updated_timestamp as delivery_performance_updated_timestamp 
from 
  {{ source('blinkit_raw', 'delivery_performance') }}
{% if is_incremental() %}
  where updated_timestamp > coalesce((select max(delivery_performance_updated_timestamp) from {{ this }}), '1900-01-01')
{% endif %}