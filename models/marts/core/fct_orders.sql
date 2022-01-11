with orders as (
    select
         *
    from
        {{ ref('stg_orders') }}
),

payments as (
    select
         *
    from
        {{ ref('stg_payments') }}
),

order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount end) as amount
    from payments
    group by 1
),


final as (
    select
          orders.order_id
        , customer_id
        , order_payments.amount as amount
    from
        orders
        left join order_payments on orders.order_id = order_payments.order_id
)

select
    *
from
    final