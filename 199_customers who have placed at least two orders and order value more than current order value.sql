use questions;

/*
Question:- Find customers who have placed at least two orders and
whose latest order value is lower than their previous order value.
*/

/*
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_value DECIMAL(10,2)
);

INSERT INTO customer_orders (order_id, customer_id, order_date, order_value) VALUES 
(101, 1, '2099-02-10', 500),
(102, 2, '2099-02-12', 200),
(103, 1, '2099-02-15', 300),
(104, 3, '2099-02-20', 700),
(105, 2, '2099-02-25', 400),
(106, 3, '2099-02-28', 600),
(107, 1, '2099-03-01', 150),
(108, 4, '2099-03-05', 1000),
(109, 2, '2099-03-10', 50),
(110, 3, '2099-03-12', 500),
(111, 4, '2099-03-15', 700),
(112, 1, '2099-03-18', 200),
(113, 2, '2099-03-20', 800),
(114, 3, '2099-03-22', 900),
(115, 4, '2099-03-25', 400),
(116, 1, '2099-03-28', 100),
(117, 2, '2099-03-30', 300),
(118, 5, '2099-02-10', 500)
*/

select * from customer_orders;

with t1 as(
select *,
	lag(order_value, 1, null) over(partition by customer_id order by order_date asc) as previous_order_value
from customer_orders
where customer_id in (select customer_id
						from customer_orders
						group by customer_id
						having count(*) > 1)
)
select distinct customer_id
from t1
where previous_order_value > order_value;