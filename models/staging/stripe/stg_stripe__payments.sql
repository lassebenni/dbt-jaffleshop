with
    payments as (select * from {{ source("stripe", "payment") }}),

    final as (
        select
            id as payment_id,
            orderid as order_id,
            paymentmethod as payment_method,
            status,
            -- `amount` is currently stored in cents, so we convert it to dollars
            amount / 100 as amount_usd
        from payments
    )

select *
from final
