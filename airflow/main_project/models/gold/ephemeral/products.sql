select
    distinct
    product_id,
    product_name,
    category,
    brand,
    price,
    max_retail_price,
    margin_percentage,
    shelf_life_days,
    min_stock_level,
    max_stock_level,
    products_created_timestamp,
    products_updated_timestamp
from {{ ref('obt') }}