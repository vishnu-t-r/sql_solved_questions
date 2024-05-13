use int_ques;

/*
Sales table has three columns Customer_Name, Sales_Amount, and Year. 
Write a query to display the customer name, sales amount, year, and previous year sales
for which sales amount is greater than or equal to previous year sales.
*/

/*
create table sales(
Customer_Name varchar(20), 
Sales_Amount int, 
Year int)

insert into sales(Customer_Name, Sales_Amount, Year)
values('Rahul',90000,2022),
('Sanjay',80000,2022),
('Mohan',70000,2022),
('Rahul',90000,2023),
('Sanjay',85000,2023),
('Mohan',65000,2023),
('Rahul',80000,2024),
('Sanjay',80000,2024),
('Mohan',90000,2024)
*/

with pivot_result as(
select * from sales
pivot(
SUM(Sales_Amount)
for Year in ([2022],[2023],[2024]) 
) as pivot_tab
)
select pr.Customer_Name,
		case when [2023] >= [2022] then [2023]
				when [2024] >= [2023] then [2024] end as Sales,
		case when [2023] >= [2022] then '2023'
				when [2024] >= [2023] then '2024' end as Yr,
		case when [2023] >= [2022] then [2022]
				when [2024] >= [2023] then [2023] end as Prev_Yr_Sales
from pivot_result pr
