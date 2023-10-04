--Get Common Records From Two Tables Without Using Join

select top 10 * from [dbo].[ORDERS]
select top 10 * from [dbo].[CUSTOMERS]

--Find the orderid common to both the tables?
--using intersect
select id as order_id
from orders
intersect
select order_id 
from customers

--using in operator

select id,price,order_date
from orders
where id in (select order_id from customers)