with
raw_source as ( select * from {{ source('jaffle_shop', 'supplies') }}),

final as (
    select
        id,
        name,
        cost,
        perishable,
        sku
    from raw_source
)

select *
from final
