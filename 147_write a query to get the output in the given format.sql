use sql_challenge;

/*
Input :- Sales Table has three columns namely Id, Product and Sales
Question :- Write a SQL query to get the output as shown in the given formats
*/

/*
create table sales_tab(id int, product varchar(20), sales int);

insert into sales_tab
values(1001,'Keyboard',20),
(1002,'Keyboard',25),
(1003,'Laptop',30),
(1004,'Laptop',35),
(1005,'Laptop',40),
(1006,'Monitor',45),
(1007,'WebCam',50),
(1008,'WebCam',55)
*/

select * from sales_tab;

--format 1
select id,
		product,
		sales,
		first_value(sales) over(partition by product order by id asc) as sales_frst_value
from sales_tab;

--format 2
select id,
		product,
		sales,
		sum(sales) over(partition by product order by id asc) as sales_products
from sales_tab;