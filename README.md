# Working session 2

We just got some payment data into our warehouse:

`select * from raw.stripe.payment`

1. Build a stg_payments model to stage the payment data.

2. Build an orders model with the following fields:
- order_id
- customer_id
- amount (hint: this has to come from payments)

3. Add a new field to the customers model:
- customers.lifetime_value: the total amount a customer has spent at jaffle_shop

By the way, the Excel spreadsheet I've been using to raise venture capital says my all-time revenue is $1,672.