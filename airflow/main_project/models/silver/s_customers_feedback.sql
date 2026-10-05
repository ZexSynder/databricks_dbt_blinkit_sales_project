{{
  config(
    materialized = 'incremental',
    unique_key = 'feedback_id',
    )
}}

select 
  * except(created_timestamp, updated_timestamp),
  created_timestamp as customer_feedback_created_timestamp,
  updated_timestamp as customer_feedback_updated_timestamp
from 
  {{ source('blinkit_raw', 'customer_feedback') }}
{% if is_incremental() %}
  where updated_timestamp > coalesce((select max(customer_feedback_updated_timestamp) from {{ this }}), '1900-01-01')
{% endif %}