{{
  config(
    materialized='table'
  )
}}

with
    orders as (select * from {{ ref("stg_jaffle_shop__orders") }}),

    items as (select * from {{ ref("stg_jaffle_shop__items") }}),

    customers as (select * from {{ ref("stg_jaffle_shop__customers") }}),

    products as (select * from {{ ref("stg_jaffle_shop__products") }}),

    stores as (select * from {{ ref("stg_jaffle_shop__stores") }}),

    supplies as (select * from {{ ref("stg_jaffle_shop__supplies") }}),

    joined as (
        select
            orders.id,
            orders.customer as customer_id,
            orders.ordered_at as order_date,
            orders.store_id,
            orders.subtotal,
            orders.tax_paid,
            orders.order_total,
            items.sku as product_sku,
            customers.name as customer_name,
            products.name as product_name,
            products.type as product_type,
            products.price as product_price,
            products.description as product_description,
            stores.name as store_name,
            stores.opened_at as store_opened_at,
            stores.tax_rate as store_tax_rate,
            supplies.id as supply_id,
            supplies.name as supply_name,
            supplies.cost as supply_cost,
            supplies.perishable,
            supplies.sku as supply_sku
        from orders
        join items on orders.id = items.order_id
        join customers on orders.customer = customers.id
        join products on items.sku = products.sku
        join stores on orders.store_id = stores.id
        join supplies on items.sku = supplies.sku
    )

select *
from joined
