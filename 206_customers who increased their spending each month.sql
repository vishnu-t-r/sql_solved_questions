/*
--Question:
--Write a SQL query to find customers who increased their spending each month compared to the previous month.
*/

use questions;

/*
CREATE TABLE Orders_Info (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2)
);


INSERT INTO Orders_Info (order_id, customer_id, order_date, amount) VALUES
(501, 1, '2099-01-10', 300),
(502, 2, '2099-01-15', 500),
(503, 1, '2099-02-12', 400),
(504, 1, '2099-03-10', 600),
(505, 2, '2099-02-18', 450),
(506, 2, '2099-03-20', 470),
(507, 1, '2099-04-21', 700);
*/

select * from orders_info;

with t1 as(
select *, 
		concat(month(order_date),'-',year(order_date)) as month_year
from orders_info
), t2 as(
select customer_id,month_year, sum(amount) as amount
from t1
group by customer_id,month_year
), t3 as(
select *,
		lead(amount,1,amount) over(partition by customer_id order by month_year asc) lead_amount
from t2
), t4 as(
select *,
		(lead_amount - amount) as flag
from t3
), t5 as(
select customer_id, min(flag) as flag from t4
group by customer_id
)
select * from t5
where flag >= 0;


