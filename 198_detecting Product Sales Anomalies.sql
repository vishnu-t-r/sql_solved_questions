--Detecting Product Sales Anomalies
--Given a table of product sales. 
--Identify products that were sold on two or more non-consecutive days, 
--meaning they had a gap of at least one day between sales.

use questions;

/*
CREATE TABLE sales_products (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT
);


INSERT INTO sales_products (sale_id, product_id, sale_date, quantity) VALUES
(1, 101, '2099-03-01', 10),
(2, 101, '2099-03-02', 5),
(3, 101, '2099-03-05', 8),  -- Non-consecutive sale
(4, 102, '2099-03-01', 7),
(5, 102, '2099-03-02', 6),  -- Consecutive sales, not in output
(6, 103, '2099-03-03', 12),
(7, 103, '2099-03-06', 15),  -- Non-consecutive sale
(8, 103, '2099-03-07', 9);
*/

--select * from sales_products;

select distinct s1.product_id
from sales_products s1
inner join sales_products s2
on s1.product_id = s2.product_id
where datediff(day,s2.sale_date,s1.sale_date) > 1;


with t1 as(
select *,
		lag(sale_date,1,null) over(partition by product_id order by sale_date asc) as previous_sale_date
from sales_products
)
select distinct product_id
from t1
where datediff(day,previous_sale_date,sale_date) > 1;