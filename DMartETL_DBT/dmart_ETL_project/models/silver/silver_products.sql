{{ config(materialized='view') }}

with source_products as (

    select *
    from {{ ref('bronze_products') }}

), cleaned_products as (

    select
        upper(nullif(trim(to_varchar(product_id)), '')) as product_id,
        initcap(nullif(trim(to_varchar(category)), '')) as category,
        initcap(nullif(trim(to_varchar(subcategory)), '')) as subcategory,
        nullif(trim(to_varchar(brand)), '') as brand,
        nullif(trim(to_varchar(unit_size)), '') as unit_size,
        lower(nullif(trim(to_varchar(unit_measure)), '')) as unit_measure,
        try_to_number(nullif(trim(to_varchar(mrp)), '')) as mrp,
        upper(nullif(trim(to_varchar(supplier_id)), '')) as supplier_id,
        try_to_number(nullif(trim(to_varchar(shelf_life_days)), '')) as shelf_life_days,
        initcap(nullif(trim(to_varchar(import_flag)), '')) as import_source
    from source_products

)

select *
from cleaned_products
