{{ config(materialized='table') }}

with sales as (

    select *
    from {{ ref('silver_sales') }}

), products as (

    select *
    from {{ ref('silver_products') }}

), stores as (

    select *
    from {{ ref('silver_stores') }}

), calendar as (

    select *
    from {{ ref('silver_calender') }}

)

select
    sales.invoice_id,
    sales.sale_date,
    to_number(to_char(sales.sale_date, 'YYYYMMDD')) as date_id,
    sales.store_id,
    stores.store_name,
    stores.city,
    stores.district,
    stores.state,
    stores.store_type,
    stores.area_sqft,
    sales.product_id,
    products.category,
    products.subcategory,
    products.brand,
    products.unit_size,
    products.unit_measure,
    products.mrp,
    products.supplier_id,
    products.shelf_life_days,
    products.import_source,
    calendar.month_number,
    calendar.year_number,
    calendar.day_of_week,
    calendar.quarter,
    calendar.is_holiday,
    calendar.festival_name,
    calendar.season,
    sales.quantity,
    sales.price,
    sales.discount,
    sales.invoice_amount,
    sales.gst_amount,
    sales.payment_mode,
    sales.sales_channel,
    sales.customer_id,
    sales.cashier_id,
    sales.is_return
from sales
left join products
    on sales.product_id = products.product_id
left join stores
    on sales.store_id = stores.store_id
left join calendar
    on sales.sale_date = calendar.calendar_date
