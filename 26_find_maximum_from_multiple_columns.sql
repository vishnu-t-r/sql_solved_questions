--question?

--find maximum from multiple columns?

--table
--sales

/*
create table sales(
category varchar(250),
[2015] int,
[2016] int,
[2017] int,
[2018] int,
[2019] int,
[2020] int,
[2021] int
)
*/


--alter table sales
--drop column [2021];

/*
insert into sales(category,[2015],[2016],[2017],[2018],[2019],[2020])
values('hot drinks',20000,null,28000,12000,40000,10000),
('cold drinks',18000,36000,10000,12000,8000,20000)
*/

--select * from sales

select * from (values (1),(2),(3)) as tbl(a);

select max(a) as maximum_a
from (values (1),(2),(3)) as tbl(a);


--query
select category,
	(select max(sales) from (values ([2015]),([2016]),([2017]),([2018]),([2019]),([2020])) as tbl(sales)) as max_sales
from sales

--select * from sales
