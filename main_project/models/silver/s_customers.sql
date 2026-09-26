{{
  config(
    materialized = 'incremental',
    unique_key = 'customer_id',
    )
}}

select 
    * except (created_timestamp, updated_timestamp),
    created_timestamp as customer_created_timestamp,
    updated_timestamp as customer_updated_timestamp
from{{ source('blinkit_raw', 'customers') }}
{% if is_incremental() %}
  where updated_timestamp > coalesce((select max(customer_updated_timestamp) from {{ this }}), '1900-01-01')
{% endif %}