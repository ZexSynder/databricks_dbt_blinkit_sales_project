{{
  config(
    materialized = 'incremental',
    unique_key = 'product_id',
    )
}}
select 
  * except (created_timestamp, updated_timestamp),
  created_timestamp as products_created_timestamp,
  updated_timestamp as products_updated_timestamp
from {{ source('blinkit_raw', 'products') }}
{% if is_incremental() %}
  where updated_timestamp > coalesce((select max(products_updated_timestamp) from {{ this }}), '1900-01-01')
{% endif %}