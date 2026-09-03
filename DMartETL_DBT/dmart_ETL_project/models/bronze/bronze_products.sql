{{config(
    materialized = 'incremental'
)}}

SELECT * FROM {{ source('raw_data', 'products') }}