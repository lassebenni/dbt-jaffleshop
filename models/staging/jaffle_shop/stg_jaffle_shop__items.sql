with
    raw_source as (select * from {{ source("jaffle_shop", "items") }}),

    final as (
        select id, order_id, sku
        from raw_source
        )

select *
from final
