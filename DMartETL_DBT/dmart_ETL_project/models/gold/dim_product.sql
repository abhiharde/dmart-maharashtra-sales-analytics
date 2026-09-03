{{ config(materialized='table') }}

select distinct
    product_id,
    category,
    subcategory,
    brand,
    unit_size,
    unit_measure,
    mrp,
    supplier_id,
    shelf_life_days,
    import_source
from {{ ref('obt_sales') }}
where product_id is not null
