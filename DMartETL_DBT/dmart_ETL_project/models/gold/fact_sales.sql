{{ config(materialized='table') }}

select
    invoice_id as transaction_id,
    store_id,
    product_id,
    date_id,
    sale_date,
    quantity,
    price,
    discount,
    invoice_amount as revenue,
    gst_amount,
    payment_mode,
    sales_channel,
    customer_id,
    cashier_id,
    is_return
from {{ ref('obt_sales') }}
where invoice_id is not null