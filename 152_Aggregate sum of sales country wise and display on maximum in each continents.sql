use sql_challenge;

--Question
/*
SalesInfo Table has 4 columns namely Id, Continents, Country and Sales.
Write a SQL query to get the aggregate sum of sales countrywise and display only those which are
maximum in each continents.
*/

/*
create table salesinfo(
Id int primary key identity(1,1),
Continents varchar(20), 
Country varchar(20),
Sales int );

insert into salesinfo
values('Asia','India',50000),
('Asia','India',70000),
('Asia','India',60000),
('Asia','Japan',10000),
('Asia','Japan',20000),
('Asia','Japan',40000),
('Asia','Thailand',20000),
('Asia','Thailand',30000),
('Asia','Thailand',40000),
('Europe','Denmark',40000),
('Europe','Denmark',60000),
('Europe','Denmark',10000),
('Europe','France',60000),
('Europe','France',30000),
('Europe','France',40000)
*/

--select * from salesinfo;

with t1 as(
select continents, country, sum(sales) as total_sales
from salesinfo
group by continents, country
), 
rnk_sales as(
select *,
		dense_rank() over(partition by continents order by total_sales desc) as rnk
from t1
)
select * from rnk_sales
where rnk = 1;




