{{
  config(
    materialized = 'incremental',
    unique_key = 'order_id',
    )
}}
select 
  * except (created_timestamp, updated_timestamp),
  created_timestamp as order_created_timestamp,
  updated_timestamp as order_updated_timestamp
from {{ source('blinkit_raw', 'orders') }}
{% if is_incremental() %}
  where updated_timestamp > coalesce((select max(order_updated_timestamp) from {{ this }}), '1900-01-01')
{% endif %}