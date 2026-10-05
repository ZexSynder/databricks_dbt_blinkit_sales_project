{{
  config(
    materialized = 'incremental',
    unique_key = 'order_item_id',
    )
}}
select 
  *
from {{ source('blinkit_raw', 'order_items') }}
{% if is_incremental() %}
  where updated_timestamp > coalesce((select max(updated_timestamp) from {{ this }}), '1900-01-01')
{% endif %}