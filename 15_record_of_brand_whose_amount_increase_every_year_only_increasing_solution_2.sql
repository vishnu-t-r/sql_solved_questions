--Query to fetch the record of brand whose amounts is increasing every year?
--(amount increasing year by year)
--solution_2 different approach

--table -> brand_amount

/*
create table brand_amount(
year int,
brand varchar(255),
amount int
)

insert into brand_amount(year,brand,amount)
values(2018,'apple',45000),
(2019,'apple',35000),
(2020,'apple',75000),
(2018,'samsung',15000),
(2019,'samsung',20000),
(2020,'samsung',25000),
(2018,'nokia',21000),
(2019,'nokia',17000),
(2020,'nokia',14000)

*/


--select * from brand_amount
begin

with t1 as
(
select *
		,case when amount > lag(amount,1,0) over(partition by brand order by year asc)
					then 1 else 0 end as flag
from brand_amount
)

----correct only using 'in/not in'
/* 
select * from brand_amount
where brand not in (
					select brand
					from t1
					where flag = 0
					)
*/
--alternate approach using 'exist/not exists'
select * from brand_amount
where not exists (
					select brand
					from t1
					where flag = 0
					and t1.brand = brand_amount.brand
					)
end

--'begin' & 'end' not necessary
--added here just for testing begin and end



