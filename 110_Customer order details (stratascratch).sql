--Order Details

use int_ques;

/*
Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.
*/

--tables
--customers, orders

/*
create table customer(
id int,
first_name varchar(50),
last_name varchar(50),
city varchar(50),
address varchar(50),
phone_number varchar(50)
)

insert into customer(id, first_name, last_name, city, address, phone_number)
values(8	,'John','Joseph','	San Francisco','','928-386-8164'),
(7	,'Jill','Michael','Austin','','813-297-0692'),
(4	,'William','Daniel','Denver','','813-368-1200'),
(5	,'Henry','Jackson','Miami','','808-601-7513'),
(13	,'Emma','Isaac	','Miami','','808-690-5201'),
(14	,'Liam','Samuel	','Miami','','808-555-5201'),
(15	,'Mia','Owen','Miami','','808-640-5201'),
(1	,'Mark','Thomas','Arizona	','4476 Parkway Drive','	602-993-5916'),
(12	,'Eva','Lucas','Arizona	','4379 Skips Lane	','301-509-8805'),
(6	,'Jack','Aiden','Arizona	','4833 Coplin Avenue','	480-303-1527'),
(2	,'Mona','Adrian','Los Angeles	','1958 Peck Court	','714-409-9432'),
(10	,'Lili','Oliver','Los Angeles	','3832 Euclid Avenue	','530-695-1180'),
(3	,'Farida','Joseph','San Francisco	','3153 Rhapsody Street','	813-368-1200'),
(9	,'Justin','Alexander','Denver	','4470 McKinley Avenue	','970-433-7589'),
(11	,'Frank','Jacob','Miami','1299 Randall Drive	','808-590-5201')


select * from customer
*/

/*
create table orders(
id int,
cust_id int,
order_date date,
order_details varchar(20),
total_order_cost int
)

insert into orders(id, cust_id, order_date, order_details, total_order_cost)
values(1,	3,'	2019-03-04','	Coat',	100),(
2,	3	,'2019-03-01','	Shoes',	80),(
3,	3	,'2019-03-07','	Skirt',	30),(
4,	7	,'2019-02-01','	Coat',	25),(
5,	7	,'2019-03-10','	Shoes',	80),(
6,	15	,'2019-02-01','	Boats',	100),(
7,	15	,'2019-01-11','	Shirts',	60),(
8,	15	,'2019-03-11','	Slipper',	20),(
9,	15	,'2019-03-01','	Jeans',	80),(
10,	15	,'2019-03-09','	Shirts',	50),(
11,	5	,'2019-02-01','	Shoes',	80),(
12,	12	,'2019-01-11','	Shirts',	60),(
13,	12	,'2019-03-11','	Slipper',	20),(
14,	4	,'2019-02-01','	Shoes',	80),(
15,	4	,'2019-01-11','	Shirts',	60),(
16,	3	,'2019-04-19','	Shirts',	50),(
17,	7	,'2019-04-19','	Suit',	150),(
18,	15	,'2019-04-19','	Skirt',	30),(
19,	15	,'2019-04-20','	Dresses',	200),(
20,	12	,'2019-01-11','	Coat',	125),(
21,	7	,'2019-04-01','	Suit',	50),(
22,	7	,'2019-04-02','	Skirt',	30),(
23,	7	,'2019-04-03','	Dresses',	50),(
24,	7	,'2019-04-04','	Coat',	25),(
25,	7	,'2019-04-19','	Coat',	125)
*/


select c.first_name, o.order_date, o.order_details, o.total_order_cost
from orders o left join customer c
on o.cust_id = c.id
where c.first_name in ('Jill','Eva')
order by c.id asc