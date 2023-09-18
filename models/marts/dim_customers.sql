with
    orders as (select * from {{ ref("stg_jaffle_shop__orders") }}),

    customers as (select * from {{ ref("stg_jaffle_shop__customers") }}),

    order_amount as (select * from {{ ref("fct_orders") }}),

    customer_orders as (

        select
            customer_id,

            min(orders.order_date) as first_order_date,
            max(orders.order_date) as most_recent_order_date,
            count(orders.order_id) as number_of_orders,
            sum(order_amount.total_amount_usd) as lifetime_value_usd

        from orders
        left join order_amount using (order_id)

        group by 1

    ),

    final as (

        select
            customers.customer_id,
            customers.first_name,
            customers.last_name,
            customer_orders.first_order_date,
            customer_orders.most_recent_order_date,
            coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
            coalesce(customer_orders.lifetime_value_usd, 0) as lifetime_value_usd

        from customers
        left join customer_orders using (customer_id)
    )

select *
from final
