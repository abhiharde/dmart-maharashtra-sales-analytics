select
    transaction_id,
    revenue
from {{ ref('fact_sales') }}
where revenue < 0
