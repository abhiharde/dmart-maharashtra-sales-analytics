{{ config(materialized='view') }}

with source_stores as (

    select *
    from {{ ref('bronze_stores') }}

), cleaned_stores as (

    select
        upper(nullif(trim(to_varchar(store_id)), '')) as store_id,
        nullif(trim(to_varchar(store_name)), '') as store_name,
        initcap(nullif(trim(to_varchar(city)), '')) as city,
        initcap(nullif(trim(to_varchar(district)), '')) as district,
        initcap(nullif(trim(to_varchar(state)), '')) as state,
        try_to_date(trim(to_varchar(opening_date)), 'YYYY-MM-DD') as opening_date,
        initcap(nullif(trim(to_varchar(store_type)), '')) as store_type,
        try_to_number(nullif(trim(to_varchar(area_sqft)), '')) as area_sqft,
        upper(nullif(trim(to_varchar(manager_id)), '')) as manager_id,
        try_to_decimal(nullif(trim(to_varchar(latitude)), ''), 10, 6) as latitude,
        try_to_decimal(nullif(trim(to_varchar(longitude)), ''), 10, 6) as longitude
    from source_stores

)

select *
from cleaned_stores
