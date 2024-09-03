use sql_challenge;

--Question
/*

Write an SQL query to determine the number of days between the first "Shipped" order and 
the first "Delivered" order for each customer. 
If a customer does not have both types of orders, they should not be included in the results.
Note:- first "Deilvered" order after "Shipped" order should be considered
*/
/*
create table customer_orders(order_id int,
customer_id int,
order_date date,
status varchar(20));

insert into customer_orders(order_id, customer_id, order_date, status)
values(1,	1001,	'2024-08-01',	'Shipped'),
(2,	1001,	'2024-08-02',	'Delivered'),
(3,	1002,	'2024-08-01',	'Shipped'),
(4,	1002,	'2024-08-05',	'Shipped'),
(5,	1003,	'2024-08-02',	'Delivered'),
(6,	1003,	'2024-08-10',	'Shipped'),
(7,	1003,	'2024-08-15',	'Delivered')
*/


--select * from customer_orders;
--order by customer_id asc, order_date asc;

with customer_frst_ship_date as(
select distinct customer_id,
		first_value(order_date) over(partition by customer_id order by order_date asc) as first_ship_date
from customer_orders
where status = 'Shipped'),
shipped_delivered_date as(
select c.*,
		s.first_ship_date
from customer_orders c
left join customer_frst_ship_date s
on c.customer_id = s.customer_id
where status = 'Delivered'
and order_date > first_ship_date)

select customer_id,
		order_date as first_delivered_date,
		first_ship_date,
		datediff(day,first_ship_date,order_date) as diff
from shipped_delivered_date;


