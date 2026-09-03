{{ config(materialized='table') }}

select distinct
    store_id,
    store_name,
    city,
    district,
    state,
    store_type,
    area_sqft
from {{ ref('obt_sales') }}
where store_id is not null
