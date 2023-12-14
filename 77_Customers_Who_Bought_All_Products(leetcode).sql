--create database leetcode;

use leetcode;

/*
create table customer(
customer_id int,
product_key int
)

create table product(
product_key int
)

insert into customer(customer_id, product_key)
values(1,5),(2,6),(3,5),(3,6),(1,6)

insert into product(product_key)
values(5),(6)
*/


--Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.


select * from customer;
select * from product;

--method 1
select customer_id
from
(
select customer_id, count(distinct product_key) as product_count
from customer
group by customer_id
) a 
where product_count = (select count(distinct product_key) from product)

--method 2 using having clause
select customer_id, count(distinct product_key) as product_count
from customer
group by customer_id
having count(distinct product_key) = (select count(distinct product_key) from product)







