--New Products

use int_ques;

/*
You are given a table of product launches by company by year. 
Write a query to count the net difference between the number of products companies launched in 2024 with the 
number of products companies launched in the previous year. 
Output the name of the companies and a net difference of net products released for 2024 compared to the previous year.
*/

/*
create table car_launches(
year int,
company_name varchar(20), 
product_name varchar(20)
)
insert into car_launches(year, company_name, product_name)
values(2023,'Toyota','Avalon'),
(2023,'Toyota','Camry'),
(2024,'Toyota','Corolla'),
(2023,'Honda','Accord'),
(2023,'Honda','Passport'),
(2023,'Honda','CR-V'),
(2024,'Honda','Pilot'),
(2023,'Honda','Civic'),
(2024,'Chevrolet','Trailblazer'),
(2024,'Chevrolet','Trax'),
(2023,'Chevrolet','Traverse'),
(2024,'Chevrolet','Blazer'),
(2023,'Ford','Figo'),
(2024,'Ford','Aspire'),
(2023,'Ford','Endeavour'),
(2024,'Jeep','Wrangler'),
(2024,'Jeep','Cherokee'),
(2024,'Jeep','Compass'),
(2023,'Jeep','Renegade'),
(2023,'Jeep','Gladiator')
*/

--select * from car_launches;
with t1 as(
select company_name,
		count(case when year = 2024 then 1 else null end) as car_count_2024,
		count(case when year <> 2024 then 1 else null end) as car_count_2023,
		(count(case when year = 2024 then 1 else null end) 
		- count(case when year <> 2024 then 1 else null end)) as diff
from car_launches
group by company_name
)
select t1.company_name,
		concat_ws('  ',company_name,'launched',abs(diff),
		case when diff > 0 then 'more'
			when diff < 0 then 'less' end,'car in the current year') as result_message
from t1