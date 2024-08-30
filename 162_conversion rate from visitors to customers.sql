use sql_challenge;
/*
How can the conversion rate from visitors to customers be calculated for retail stores within a retail chain?
*/
/*
create table visitors(
visitor_id int,
visit_date date,
store_id int);


insert into visitors(visitor_id,	visit_date,	store_id)
values
(11,'2099-03-21',101),
(12,'2099-06-13',103),
(1,'2099-01-05',101),
(2,'2099-01-10',101),
(3,'2099-02-15',102),
(4,'2099-03-20',101),
(5,'2099-04-25',103),
(6,'2099-05-10',102),
(7,'2099-06-12',103),
(8,'2099-07-01',101),
(9,'2099-08-08',103),
(10,'2099-08-15',102)

create table store_orders(order_id int,
customer_id int,
visitor_id int,
order_date date,
store_id int)

insert into store_orders(order_id, customer_id,	visitor_id,	order_date,	store_id)
values(101,	1,	1,	'2099-01-05',	101),
(102,	2,	2,	'2099-01-10',	101),
(103,	3,	11,	'2099-03-21',	101),
(104,	4,	12,	'2099-06-13',	103),
(105,	5,	9,	'2099-08-08',	103)


select * from visitors;

select * from store_orders;
*/

with visitor_customer as
(
select v.*,
		o.customer_id,
		o.order_id,
		o.order_date
from visitors v full join store_orders o
on v.visitor_id = o.visitor_id
and v.visit_date = o.order_date
and v.store_id = o.store_id
)
select store_id, count(customer_id) as customer_count,
			count(visitor_id) as visitor_count,
			cast(cast(count(customer_id) as decimal(10,2))/count(visitor_id)*100 as decimal(10,2)) as con_rate
from visitor_customer
group by store_id

