use questions;

--Analyzing Product Sales Growth

/*
Scenario:
You have a table named product_sales that tracks the sales of different products over time. 
You need to calculate the month-over-month growth rate of the total quantity sold for each product in the year 2099.

The month-over-month growth rate can be defined as:

Growth Rate=( Current Month Quantity−Previous Month Quantity​ ) ×100
              -----------------------------------------------
			             Previous Month Quantity

*/

/*
CREATE TABLE product_sales (
    product_id INT,
    sale_date DATE,
    quantity INT,
    PRIMARY KEY (product_id, sale_date)
);

INSERT INTO product_sales (product_id, sale_date, quantity) VALUES
-- Product 1 sales data
(1, '2099-01-10', 100),
(1, '2099-01-20', 150),
(1, '2099-02-05', 200),
(1, '2099-02-18', 250),
(1, '2099-03-12', 300),
(1, '2099-03-25', 100),
(1, '2099-04-15', 400),
(1, '2099-04-20', 200),
-- Product 2 sales data
(2, '2099-01-15', 50),
(2, '2099-01-30', 70),
(2, '2099-02-08', 90),
(2, '2099-03-03', 60),
(2, '2099-03-20', 110),
(2, '2099-04-01', 130),
(2, '2099-04-22', 80),
-- Product 3 sales data
(3, '2099-01-05', 30),
(3, '2099-01-25', 60),
(3, '2099-02-14', 40),
(3, '2099-02-28', 70),
(3, '2099-03-05', 90),
(3, '2099-03-22', 80),
(3, '2099-04-10', 100);
*/

--select * from product_sales;

with total_sale as(
select product_id, sale_year_month, sale_month, sum(quantity) as total_quantity
from
(
select *,
		concat_ws('-',datename(month,sale_date),
		year(sale_date)) as sale_year_month,
		month(sale_date) as sale_month
from product_sales
where year(sale_date) = 2099) sales
group by product_id, sale_year_month, sale_month
--order by product_id asc, sale_month asc
),
previous_month_sales as(
select product_id,
		sale_year_month,
		sale_month,
		total_quantity as current_month_sales,
		lag(total_quantity,1,0) over(partition by product_id order by sale_month asc) as previous_month_sales
from total_sale
)
select product_id,
		sale_year_month,
		current_month_sales,
		previous_month_sales,
		cast(1.0*(current_month_sales-previous_month_sales)/nullif(previous_month_sales,0)*100
		as decimal(10,2)) as growth_rate
from previous_month_sales;