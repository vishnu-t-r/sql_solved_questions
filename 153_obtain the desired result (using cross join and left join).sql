use sql_challenge;

/*
Question :- Write a SQL query to print the desired Output as shown below using two
tables i.e :- customer_tab and month_tab
*/

/*
create table customer_tab(
cust_id int,
name varchar(20),
month_id int,
amount_spend int);

create table month_tab(
month_id int,
month_name varchar(20));

insert into customer_tab
values(1,'John',1,1000),(1,'John',2,3000),
(4,'David',3,4000),(4,'David',5,2000)

insert into month_tab(month_id, month_name)
values(1,'Jan'),
(2,'Feb'),(3,'Mar'),(4,'Apr'),
(5,'May'),(6,'Jun'),(7,'Jul'),
(8,'Aug'),(9,'Sep'),(10,'Oct'),
(11,'Nov'),(12,'Dec')

select * from customer_tab;
select * from month_tab;
*/

with cte as(
select c.cust_id as customer_id, c.name as customer_name, 
		m.month_id, m.month_name 
from customer_tab c
cross join month_tab m
group by c.cust_id, c.name, m.month_id, m.month_name
) 
select cte.customer_id, 
		cte.customer_name, 
		cte.month_name, 
		c.amount_spend 
from cte left join customer_tab c
on cte.customer_id = c.cust_id and cte.month_id = c.month_id




