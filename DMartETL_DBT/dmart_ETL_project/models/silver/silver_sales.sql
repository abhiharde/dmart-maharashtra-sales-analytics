{{ config(materialized='view') }}

with source_sales as (

    select *
    from {{ ref('bronze_sales') }}

), cleaned_sales as (

    select
        upper(nullif(trim(to_varchar(invoice_id)), '')) as invoice_id,
        upper(nullif(trim(to_varchar(store_id)), '')) as store_id,
        upper(nullif(trim(to_varchar(product_id)), '')) as product_id,
        try_to_date(trim(to_varchar(date)), 'YYYY-MM-DD') as sale_date,
        try_to_number(nullif(trim(to_varchar(quantity)), '')) as quantity,
        try_to_number(nullif(trim(to_varchar(price)), '')) as price,
        try_to_number(nullif(trim(to_varchar(discount)), '')) as discount,
        initcap(nullif(trim(to_varchar(payment_mode)), '')) as payment_mode,
        upper(nullif(trim(to_varchar(customer_id)), '')) as customer_id,
        initcap(nullif(trim(to_varchar(sales_channel)), '')) as sales_channel,
        upper(nullif(trim(to_varchar(cashier_id)), '')) as cashier_id,
        try_to_number(nullif(trim(to_varchar(invoice_amount)), '')) as invoice_amount,
        try_to_number(nullif(trim(to_varchar(gst_amount)), '')) as gst_amount,
        coalesce(
            try_to_boolean(nullif(trim(to_varchar(return_flag)), '')),
            false
        ) as is_return
    from source_sales

)

select *
from cleaned_sales
