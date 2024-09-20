use questions;

/*
Question ?
How Would You Write a Query to Find Consecutive Days with Increasing Stock Prices?
--Note: check price for three consecutive days
*/

/*
CREATE TABLE stock_price (
    stock_id INT,
    stock_date DATE,
    price DECIMAL(10, 2)
);

INSERT INTO stock_price (stock_id, stock_date, price) VALUES
(1, '2024-09-01', 100.00),
(1, '2024-09-02', 105.00),
(1, '2024-09-03', 110.00),
(1, '2024-09-04', 102.00),
(1, '2024-09-05', 108.00),
(1, '2024-09-06', 115.00),
(1, '2024-09-07', 120.00),
(2, '2024-09-01', 200.00),
(2, '2024-09-02', 195.00),
(2, '2024-09-03', 205.00),
(2, '2024-09-04', 210.00),
(2, '2024-09-05', 215.00);
*/


select * from stock_price;

--method 1
--when only one boundary date is required
select stock_id,
		stock_date,
		price,
		lag(price,1,0) over(partition by stock_id order by stock_date asc) as prev_day_price,
		lag(price,2,0) over(partition by stock_id order by stock_date asc) as before_prev_day_price
from stock_price;

--method 2
--print range of date for a stock
with prev_day_price as(
select *,
		row_number() over(partition by stock_id order by  stock_date asc) as row_id,
		lead(price,1,0) over(partition by stock_id order by stock_date asc) as next_day_price
from stock_price ),
row_cte as(
select *,
		row_number() over(partition by stock_id order by  stock_date asc) as new_row_id	
from prev_day_price
where price < next_day_price
--order by stock_id, stock_date asc
),
count_days_cte as(
select *,
		(row_id - new_row_id) as flag,
		1+(count(*) over(partition by stock_id,(row_id - new_row_id))) as consecutive_days
from row_cte),
price_increase_start_cte as(
select stock_id,consecutive_days,min(stock_date) as date_increase
from count_days_cte
group by stock_id,flag, consecutive_days
) 
select stock_id, date_increase, dateadd(day,consecutive_days,date_increase) as date_2_increase
from price_increase_start_cte
		

