--E-Commerce: Customer Purchase Patterns
--Find customers who ordered in consecutive months (repeated customers) and their spending growth.

use questions;

/*
CREATE TABLE customer_order_info (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL
);

INSERT INTO customer_order_info VALUES
('1001', 'C001', '2099-01-05', 'P100', 2, 25.00, 'Electronics'),
('1002', 'C002', '2099-01-12', 'P200', 1, 120.00, 'Furniture'),
('1003', 'C001', '2099-02-03', 'P150', 3, 35.00, 'Clothing'),
('1004', 'C003', '2099-02-10', 'P100', 1, 25.00, 'Electronics'),
('1005', 'C002', '2099-03-15', 'P300', 2, 40.00, 'Home'),
('1006', 'C001', '2099-03-20', 'P400', 2, 75.00, 'Electronics'),
('1007', 'C003', '2099-04-05', 'P150', 2, 20.00, 'Clothing'),
('1008', 'C002', '2099-04-12', 'P200', 2, 120.00, 'Furniture');
*/


with t1 as(
select *, MONTH(order_date) as order_date_month
from customer_order_info
), t2 as(
select order_date_month, customer_id, sum(unit_price * quantity) as total_amount
from t1
group by order_date_month, customer_id
), t3 as(
select a.order_date_month as first_order_month,
		a.customer_id as customer_id,
		a.total_amount as first_month_order_amount,
		b.order_date_month as second_order_month,
		b.total_amount as second_month_order_amount
from t2 as a
inner join t2 as b
on a.customer_id = b.customer_id
and (a.order_date_month + 1) = b.order_date_month
)
select *, (second_month_order_amount - first_month_order_amount) / first_month_order_amount * 100 as growth_percent
from t3;



