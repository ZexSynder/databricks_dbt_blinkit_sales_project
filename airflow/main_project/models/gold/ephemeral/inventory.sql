select
    distinct
    inventory_id,
    inventory_date,
    stock_received,
    damaged_stock,
    inventory_created_timestamp,
    inventory_updated_timestamp
from {{ ref('obt') }}