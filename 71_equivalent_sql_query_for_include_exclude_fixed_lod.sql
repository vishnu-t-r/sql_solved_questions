--create database tableau;

use tableau;

select top 10 * from superstore;

--drop table superstore;

select distinct sales
from superstore;

--sales transformation
select sum(convert(int,nw_sales)) as tot
from
(
select distinct sales, (len(sales)-1) as len,
			replace(substring(sales,2,(len(sales)-1)),',','') as nw_sales--ltrim(sales,'$') as nw_sales
from superstore) a

--sales
--quantity
--profit

select sales, quantity, profit
from superstore

--profit transformation
select distinct profit,-- (len(profit)-1) as len,
		replace(replace(profit, '$',''),',','') --ltrim(sales,'$') as nw_sales
from superstore


--

select distinct quantity--, profit
from superstore

--update table with the new transformed sales and profit
--sales
update superstore
set sales = replace(substring(sales,2,(len(sales)-1)),',','');
--profit
update superstore
set profit = replace(replace(profit, '$',''),',','');

select distinct sales, profit from superstore;

--modify the datatype of column in the parent table using ALTER statement
-- columns 'sales', 'profit' and 'quantity'

--changing datatype of multiple columns is not allowed
--sales
alter table superstore
alter column sales int;

--profit
alter table superstore
alter column profit int

--quantity
alter table superstore
alter column quantity int;

--checking if the datatype got changed
select * from 
information_schema.columns
where table_name = 'superstore'
and column_name in ('sales','profit','quantity')



-- INCLUDE LOD

--What is the Average Customer Sales Amount per Region?


select region, avg(sales) as avg_sales
from
(
select customer_name, region, sum(sales) as sales
from superstore
group by customer_name, region
--order by customer_name
) a
group by region 
order by avg_sales desc

--normal average (avgerage sales per region)

select region, avg(sales) as avg_sales
from superstore
group by region
order by avg_sales desc


--FIXED LOD

--Calculate the Maximum Sales per Order?
-- Output should contain order_id, product_id, max_sales_per_order (max amount within an order), sales
/*
select order_id,
		product_name,--product_id,
		sales
from superstore
*/

--version 1
select order_id, product_name,
		sales,
		max(sales) over(partition by order_id) as fixed_lod
from superstore
order by order_id asc

--version 2

with t1 as 
(
select order_id, max(sales) as max_sales
from superstore
group by order_id
)
select superstore.order_id
		,superstore.product_name
		,superstore.sales
		,t1.max_sales
from superstore
left join t1 on superstore.order_id = t1.order_id
order by superstore.order_id asc


--EXCLUDE LOD

--perform aggregation at a lesser granular level than in the visualization

--sales by category and sub-category + category wise sales in a seperate column

with t1 as
(
select category, sub_category,
		sum(sales) as sales_by_cat_subcat
from superstore
group by category, sub_category
),
t2 as
(
select category, sum(sales) as sales_by_cat
from superstore
group by category
)
select t1.category,
		t1.sub_category,
		t1.sales_by_cat_subcat as sales_by_cat_subcat,
		t2.sales_by_cat as sales_by_cat
from t1 
left join t2 on t1.category = t2.category
order by t1.category asc, t1.sub_category asc