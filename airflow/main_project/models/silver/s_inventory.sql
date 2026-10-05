{{
  config(
    materialized = 'incremental',
    unique_key = 'inventory_id',
    )
}}
SELECT
    inventory_id,
    product_id,
    CASE 
    -- Format 1: Short text like 'sep-24' (Length is 6)
      WHEN LENGTH(TRIM(date)) = 6 THEN 
      TO_DATE(
        CONCAT(TRIM(LOWER(date)), '-', '2025'), 
        'MMM-dd-yyyy'
      )

    -- Format 2: Complete date like '17-03-2023' (Length is 10)
      WHEN LENGTH(TRIM(date)) = 10 THEN 
      TO_DATE(TRIM(date), 'dd-MM-yyyy')

    -- Fallback for safety
      ELSE NULL 
    END AS inventory_date,
    stock_received,
    damaged_stock,
    created_timestamp AS inventory_created_timestamp,
    updated_timestamp AS inventory_updated_timestamp
FROM {{ source('blinkit_raw', 'inventory') }}
{% if is_incremental() %}
  where updated_timestamp > coalesce((select max(inventory_updated_timestamp) from {{ this }}), '1900-01-01')
{% endif %}