/*

Scenario

An e-commerce company wants to identify customers whose every order amount is greater than their first order amount.

In other words:

Ignore the first order

Check if all subsequent orders have higher value than the first order

Return the customer_ids that satisfy this condition.

*/

use learn;

/*
CREATE TABLE ecommerce_orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount INT
);


INSERT INTO ecommerce_orders (order_id, customer_id, order_date, amount) VALUES
(1, 101, '2026-01-01', 100),
(2, 101, '2026-01-05', 120),
(3, 101, '2026-01-10', 150),
(4, 102, '2026-01-02', 200),
(5, 102, '2026-01-06', 180),
(6, 103, '2026-01-01', 90),
(7, 103, '2026-01-03', 95),
(8, 103, '2026-01-07', 110);
*/

with base as(
select order_id, customer_id, order_date, amount,
first_value(amount) over(partition by customer_id order by order_date asc) as first_order_amount,
rank() over(partition by customer_id order by order_date asc) as order_number
from ecommerce_orders
)
select distinct customer_id
from base
where order_number <> 1
and amount > first_order_amount;