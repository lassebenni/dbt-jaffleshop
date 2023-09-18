with
    orders as (select * from {{ ref("stg_jaffle_shop__orders") }}),
    payments as (select * from {{ ref("stg_stripe__payments") }}),

    grouped_payments as (
        select order_id, sum(amount_usd) as total_amount_usd
        from payments
        where status = 'success'
        group by order_id
    ),

    final as (
        select orders.order_id, grouped_payments.total_amount_usd
        from orders
        left join grouped_payments using (order_id)
    )

select *
from final
