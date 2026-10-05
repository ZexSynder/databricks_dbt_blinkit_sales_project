select
    distinct
    feedback_id,
    feedback_text,
    feedback_category,
    sentiment,
    feedback_date
    customer_feedback_created_timestamp,
    customer_feedback_updated_timestamp
from {{ ref('obt') }}