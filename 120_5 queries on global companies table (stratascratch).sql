use int_ques;

--select * from global_companies;

--Question 1
/*
Find the 3 most profitable companies in the entire world.
Output the result along with the corresponding company name.
Sort the result based on profits in descending order.
*/
select top 3 company, profits
from global_companies
order by profits desc;

--Question 2
/*
Find the 3 most profitable companies in every sector.
*/

select * from(
select company,
		sector,
		profits,
		rank() over(partition by sector order by profits desc) as rnk
from global_companies
) a
where rnk <= 3
order by sector asc, profits desc



--Question 3
/*
Determine the count of companies within each country that rank among 
the top three in market value within their respective industries.
*/

select country, count(*) as company_count
from (
select company,
		marketvalue,
		industry,
		country,
		rank() over(partition by industry order by marketvalue desc) as rnk
from global_companies) a
where rnk <= 3
group by country
order by company_count desc


--Question 4
/*
Identify the industries with the highest average profit generated, 
rank the top three based on profitability.
*/

select * from
(
select top 3 industry, avg(profits) as average_profit,
		sum(profits) as total_profits
from global_companies
group by industry
order by average_profit desc
) a
order by total_profits desc



--Question 5
/*
Identify the country with the highest cumulative market value (greater than 500) based on companies 
originating from that specific country.
*/

select country, sum(marketvalue) as total_marketvalue
from global_companies
group by country
having sum(marketvalue) > 500
order by total_marketvalue desc