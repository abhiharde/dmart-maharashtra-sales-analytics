select
    fact.transaction_id,
    fact.product_id
from {{ ref('fact_sales') }} as fact
left join {{ ref('dim_product') }} as product
    on fact.product_id = product.product_id
where fact.product_id is not null
  and product.product_id is null
