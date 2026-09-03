{% snapshot snapshot_products %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='product_id',
        strategy='check',
        check_cols=['category', 'subcategory', 'brand', 'mrp', 'supplier_id']
    )
}}

select *
from {{ ref('silver_products') }}

{% endsnapshot %}
