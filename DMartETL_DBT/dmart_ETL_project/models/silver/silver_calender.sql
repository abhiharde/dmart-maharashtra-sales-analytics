{{ config(materialized='view') }}

with source_calendar as (

	select *
	from {{ ref('bronze_calendar') }}

), cleaned_calendar as (

	select
		try_to_date(trim(to_varchar(date)), 'YYYY-MM-DD') as calendar_date,
		try_to_number(nullif(trim(to_varchar(month)), '')) as month_number,
		try_to_number(nullif(trim(to_varchar(year)), '')) as year_number,
		initcap(nullif(trim(to_varchar(day_of_week)), '')) as day_of_week,
		upper(nullif(trim(to_varchar(quarter)), '')) as quarter,
		coalesce(
			try_to_boolean(nullif(trim(to_varchar(holiday_flag)), '')),
			false
		) as is_holiday,
		nullif(initcap(trim(to_varchar(festival_name))), '') as festival_name,
		initcap(nullif(trim(to_varchar(season)), '')) as season
	from source_calendar

)

select *
from cleaned_calendar
