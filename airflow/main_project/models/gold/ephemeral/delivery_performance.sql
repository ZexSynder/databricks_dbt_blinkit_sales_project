select
    distinct
    delivery_partner_id,
    promised_delivery_time,
    actual_delivery_time,
    delivery_time_minutes,
    delivery_status,
    distance_km,
    reasons_if_delayed,
    delivery_performance_created_timestamp,
    delivery_performance_updated_timestamp
from {{ ref('obt') }}