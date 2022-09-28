--Query to fetch the record of brand whose amounts is increasing every year?
--(amount increasing year by year)
--solution_1

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

with t1 as
(
select	brand
		,year as current_year
		,(year-1) as previous_year
		--,LAG(year,1,year-1) OVER(PARTITION BY brand ORDER BY year asc) as previous_year
		,amount
		,LAG(amount,1,0) OVER(PARTITION BY brand ORDER BY year asc) as amount_previous_yr
		,(amount - LAG(amount,1,0) OVER(PARTITION BY brand ORDER BY year asc)) as amount_change
from brand_amount
)

select * from brand_amount
where not exists (select brand from t1
						where amount_change < 0
								and brand_amount.brand = t1.brand)



