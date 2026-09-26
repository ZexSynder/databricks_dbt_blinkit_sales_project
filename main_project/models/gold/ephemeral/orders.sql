select
    distinct
    order_id,
    order_date,
    payment_method,
    order_total,
    order_created_timestamp,
    order_updated_timestamp
from {{ ref('obt') }}