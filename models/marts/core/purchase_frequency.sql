with
    stg_orders as (select * from {{ ref("stg_jaffle_shop__orders") }}),

    customer_daily_orders as (

        select
            customer,
            date(ordered_at) as order_date,
            count(distinct id) as customer_daily_orders,
            sum(order_total) as customer_daily_total

        from stg_orders
        group by 1, 2
    ),

    frequency as (
        select
            customer,
            count(distinct order_date) as total_orders,
            sum(customer_daily_total) as total_amount,
            date_diff(max(order_date), min(order_date), day) as total_days
        from customer_daily_orders
        group by 1
    ),

    purchase_frequency as (
        select
            customer,
            total_orders,
            total_days,
            total_amount,
            round(total_orders / nullif(total_days, 0), 2) as orders_per_day,
            round(total_amount / nullif(total_days, 0), 2) as amount_per_day

        from frequency
    )

select *
from purchase_frequency
