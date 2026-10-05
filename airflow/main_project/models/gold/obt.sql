{% set configs = [
    {
        "table": "blinkit_2.silver.s_order_items",
        "columns": "oi.order_item_id,
                    oi.order_id,
                    oi.product_id,
                    oi.quantity,
                    oi.unit_price,
                    oi.created_timestamp as order_items_created_timestamp,
                    oi.updated_timestamp as order_items_updated_timestamp
                    ",
        "alias": "oi"
    },
    {
        "table": "blinkit_2.silver.s_orders",
        "columns": "o.customer_id, 
                    o.store_id, 
                    o.order_date, 
                    o.promised_delivery_time,
                    o.actual_delivery_time,
                    o.delivery_status,
                    o.order_total,
                    o.payment_method, 
                    o.delivery_partner_id,
                    o.order_created_timestamp,
                    o.order_updated_timestamp",
        "alias": "o",
        "join_condition": "o.order_id = oi.order_id"
    },
    {
        "table": "blinkit_2.silver.s_products",
        "columns": "p.product_name,
                    p.category,
                    p.brand,
                    p.price,
                    p.mrp as max_retail_price,
                    p.margin_percentage,
                    p.shelf_life_days,
                    p.min_stock_level,
                    p.max_stock_level,
                    p.products_created_timestamp,
                    p.products_updated_timestamp
                    ",
        "alias": "p",
        "join_condition": "p.product_id = oi.product_id"
    },
    {
        "table": "blinkit_2.silver.s_customers",
        "columns": "c.customer_name,
                    c.email,
                    c.phone,
                    c.address,
                    c.area,
                    c.pincode,
                    c.registration_date,
                    c.customer_segment,
                    c.total_orders,
                    c.avg_order_value,
                    c.customer_created_timestamp,
                    c.customer_updated_timestamp
                    ",
        "alias": "c",
        "join_condition": "c.customer_id = o.customer_id"
    },
    {
        "table": "blinkit_2.silver.s_delivery_performance",
        "columns": "dp.promised_time,
                    dp.actual_time,
                    dp.delivery_time_minutes,
                    dp.distance_km,
                    dp.reasons_if_delayed,
                    dp.delivery_performance_created_timestamp,
                    dp.delivery_performance_updated_timestamp
                    ",
        "alias": "dp",
        "join_condition": "dp.delivery_partner_id = o.delivery_partner_id"
    },
    {
        "table": "blinkit_2.silver.s_customers_feedback",
        "columns": "cf.feedback_id,
                    cf.rating,
                    cf.feedback_text,
                    cf.feedback_category,
                    cf.sentiment,
                    cf.feedback_date,
                    cf.customer_feedback_created_timestamp,
                    cf.customer_feedback_updated_timestamp
                    ",
        "alias": "cf",
        "join_condition": "cf.order_id = o.order_id"
    },
    {
        "table": "blinkit_2.silver.s_inventory",
        "columns": "i.inventory_id,
                    i.inventory_date,
                    i.stock_received,
                    i.damaged_stock,
                    i.inventory_created_timestamp,
                    i.inventory_updated_timestamp
                    ",
        "alias": "i",
        "join_condition": "i.product_id = p.product_id"
    }
] %}


select
    {% for config in configs %}
      {{ config['columns'] }}{% if not loop.last %}
        ,
      {% endif %}
    {% endfor %}
from
    {% for config in configs %}
      {% if loop.first %}
        {{ config['table'] }} as {{ config['alias'] }}
      {% else %}
        left join {{ config['table'] }} as {{ config['alias'] }}
        on {{ config['join_condition'] }}
      {% endif %}
    {% endfor %}
    