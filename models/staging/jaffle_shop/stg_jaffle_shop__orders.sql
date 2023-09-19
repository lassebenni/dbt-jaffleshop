with
    raw_source as (select * from {{ source("jaffle_shop", "orders") }}),

    final as (

        select id, customer, ordered_at, store_id, subtotal, tax_paid, order_total
        from raw_source
    )

select *
from final
