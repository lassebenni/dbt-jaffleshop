with
    stg_orders as (select * from {{ ref("stg_jaffle_shop__orders") }}),

    orders_revenue as (
        select date_trunc(ordered_at, month) as order_month, sum(order_total) as revenue
        from stg_orders
        group by 1
    ),

    final as (

        select
            order_month,
            revenue,
            revenue - lag(revenue) over (order by order_month) as revenue_growth
        from orders_revenue
        order by order_month
    )

select *
from final
