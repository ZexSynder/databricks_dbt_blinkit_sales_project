select
    distinct
    customer_id,
    customer_name,
    email as customer_email,
    phone as customer_phone,
    address as customer_address,
    area as customer_area,
    pincode as customer_pincode,
    customer_segment,
    registration_date,
    total_orders,
    avg_order_value,
    customer_created_timestamp,
    customer_updated_timestamp
from {{ ref('obt') }}