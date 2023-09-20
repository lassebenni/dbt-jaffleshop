with
    raw_source as (select * from {{ source("jaffle_shop", "products") }}),

    final as (
        select sku, name, type, price, description
        from raw_source
        )

select *
from final
