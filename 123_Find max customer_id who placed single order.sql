--Find max customer id who placed only single order

/*
Retrieve the customer information for the customer who has the highest customer_id and has placed only one order.
*/

use int_ques;

/*
create table customer_tab(
customer_id int,
name varchar(20),
country varchar(20),
state varchar(20)
)

create table order_tab(
order_id int,
customer_id int,
item varchar(20),
quantity int)

insert into order_tab(order_id, customer_id, item, quantity)
values(1,1,'pen',2),
(2,2,'pencil',3),
(3,2,'book',4),
(4,4,'cycle',3),
(5,5,'umbrella',3),
(6,6,'pencil',5),
(7,6,'pen',3),
(8,6,'book',6),
(9,7,'cycle',3),
(10,8,'pen',7),
(11,8,'umbrella',5),
(12,8,'pencil',7),
(13,9,'book',2),
(14,9,'pen',8)

insert into customer_tab(customer_id, name, country, state)
values(1,'toto','US','texas'),
(2,'john','US','florida'),
(4,'mary','US','ohio'),
(5,'george','US','texas'),
(6,'susie','US','ohio'),
(7,'lewis','US','texas'),
(8,'max','US','florida'),
(9,'charles','US','florida')
*/


select * from customer_tab;
select * from order_tab;

with t1 as(
select max(a.customer_id) as customer_id
from(
select customer_id
from order_tab
group by customer_id
having count(*) = 1 
) a
) 
select c.* from t1
left join customer_tab c
on t1.customer_id = c.customer_id;