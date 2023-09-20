{{ config(materialized="incremental") }}

with
    raw_source as (select * from {{ source("jaffle_shop", "items") }}),

    final as (

        select id, order_id, sku, ingestion_date

        from raw_source


        {% if is_incremental() %}
        where ingestion_date > (select max(ingestion_date) from {{ this }})
        {% endif %}

    )

select *
from final
