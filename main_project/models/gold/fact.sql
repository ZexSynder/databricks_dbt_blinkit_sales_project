select
    order_item_id,
    order_id,
    product_id,
    customer_id,
    store_id,
    delivery_partner_id,
    CAST(DATE_FORMAT(order_date, 'yyyyMMdd') AS INT) AS date_id,
    feedback_id,
    inventory_id,
    quantity,
    unit_price,
    quantity * unit_price as total_amount
from {{ ref('obt') }}