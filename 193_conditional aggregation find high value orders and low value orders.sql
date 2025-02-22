/*
You are given an orders table containing information about customer orders. 
Write an SQL query to 
1.find the total revenue
2.the revenue from high-value orders (amount ≥ 500)
3.the revenue from low-value orders (amount < 500) for each customer

*/

use int_ques;

/*
CREATE TABLE orders_transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    sale_amount DECIMAL(10,2)
);

INSERT INTO orders_transactions (transaction_id, customer_id, sale_amount) VALUES
(201, 101, 250),
(202, 102, 750),
(203, 101, 600),
(204, 103, 400),
(205, 102, 180),
(206, 103, 900);
*/

--select * from orders_transactions;

select customer_id,
		sum(sale_amount) as total_revenue,
		sum(case when sale_amount >= 500 then sale_amount else 0 end) as high_value_orders,
		sum(case when sale_amount < 500 then sale_amount else 0 end) as low_value_orders
from orders_transactions
group by customer_id;

with t1 as(
select *,
	case when sale_amount >= 500 then 'high_value_order' else 'low_value_order'  end as flag
from 
orders_transactions
)
select customer_id,
		sum(sale_amount) as total_revenue,
		sum(case when flag = 'high_value_order' then sale_amount else 0 end) high_value_orders,
		sum(case when flag = 'low_value_order' then sale_amount else 0 end) low_value_orders
from t1
group by customer_id;


