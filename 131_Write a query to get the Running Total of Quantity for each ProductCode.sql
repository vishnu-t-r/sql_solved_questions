use sql_challenge;

--Question

/*
Write a query to get the Running Total of Quantity for each ProductCode.
*/


/*
create table product_sales(
product_name varchar(20),
product_code varchar(10),
quantity int,
sales_date date
)

insert into product_sales(product_name, product_code, quantity, sales_date)
values('Keyboard','K1001',20,'01-03-2099'),
('Keyboard','K1001',30,'02-03-2099'),
('Keyboard','K1001',10,'03-03-2099'),
('Keyboard','K1001',40,'04-03-2099'),
('Laptop','L1002',100,'01-03-2099'),
('Laptop','L1002',60,'02-03-2099'),
('Laptop','L1002',40,'03-03-2099'),
('Monitor','M5005',30,'	01-03-2099'),
('Monitor','M5005',20,'02-03-2099')
*/

select * from product_sales;

select *,
		sum(quantity) over(partition by product_code order by sales_date asc) running_total
from product_sales