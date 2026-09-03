{% snapshot snapshot_stores %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='store_id',
        strategy='check',
        check_cols=['store_name', 'city', 'state', 'store_type', 'area_sqft']
    )
}}

select *
from {{ ref('silver_stores') }}

{% endsnapshot %}
