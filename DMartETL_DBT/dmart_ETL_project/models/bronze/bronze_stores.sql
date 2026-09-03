{{config(
    materialized = 'incremental'
)}}

SELECT * FROM {{ source('raw_data', 'store_info') }}