{{ config(materialized="incremental") }}

with
    raw_source as (select * from {{ source("jaffle_shop", "orders") }}),

    final as (

        select
            id,
            customer,
            ordered_at,
            store_id,
            subtotal,
            tax_paid,
            order_total,
            ingestion_date

        from raw_source

        {% if is_incremental() %}
        where ingestion_date > (select max(ingestion_date) from {{ this }})
        {% endif %}

    )

select *
from final
