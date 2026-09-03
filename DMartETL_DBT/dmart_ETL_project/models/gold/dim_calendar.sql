{{ config(materialized='table') }}

select distinct
    date_id,
    sale_date as calendar_date,
    month_number,
    year_number,
    day_of_week,
    quarter,
    is_holiday,
    festival_name,
    season
from {{ ref('obt_sales') }}
where date_id is not null
