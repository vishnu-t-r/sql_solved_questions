use leetcode;
--Customers Who Bought All Products


/*
create table customer_prod(
customer_id int,
product_key int
)

create table product_list(
product_key int
)

insert into customer_prod(customer_id, product_key)
values(1,5),
(2,6),
(3,5),
(3,6),
(1,6)

insert into product_list(product_key)
values(5),(6)
*/

--Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

/*
select * from customer_prod
select * from product_list
*/

select * from 
customer_prod, product_list


--method 1
--efficient scalable solution

with t1 as
(
select a.product_key, a.customer_id 
from
(
select distinct pl.product_key, cp.customer_id
from product_list pl
cross join
customer_prod cp
) a
left join customer_prod cp
on a.product_key = cp.product_key and a.customer_id = cp.customer_id
where cp.product_key is null
)

select distinct customer_id 
from customer_prod
except
select distinct customer_id
from t1


--method 2
--simple solution

/*
select * from customer_prod
select * from product_list
*/

select customer_id--, count(distinct product_key) as prod_count
from customer_prod
group by customer_id
having count(distinct product_key) = (select count(product_key) from product_list)