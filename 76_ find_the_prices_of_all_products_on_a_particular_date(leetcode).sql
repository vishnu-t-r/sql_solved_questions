use int_ques;

-- products

/*
create table products(
product_id int,
new_price int,
change_date date
)

insert into products(product_id, new_price, change_date)
values(1,20,'2019-08-14'),
(2 ,50 ,'2019-08-14'),
(1 ,30,'2019-08-15'),
(1 ,35 ,'2019-08-16'),
(2  ,65,'2019-08-17'),
(3  ,20,'2019-08-18')
*/

--Question

--Write a solution to find the prices of all products on 2019-08-16. 
--Assume the price of all products before any change is 10.


select * from products


select distinct product_id, first_value(new_price) over(partition by product_id order by change_date asc ) as price
from products
where change_date <= '2019-08-16'
union all
select distinct product_id, 10 as price
from products
group by product_id
having min(change_date) > '2019-08-16'
