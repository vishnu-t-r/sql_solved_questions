use sql_challenge;

/*
The Spending table keeps the logs of the spendings history of users that make purchases from an 
online shopping website which has a desktop and a mobile application.
Write an SQL query to find the total number of users and 
the total amount spent using mobile only, 
desktop only and both mobile and desktop together for each date.
*/

/*
create table spending 
(
User_id int,
Spend_date date,
Platform varchar(10),
Amount int
);

Insert into spending values(1,'2099-07-01','Mobile',100);
Insert into spending values(1,'2099-07-01','Desktop',100);
Insert into spending values(2,'2099-07-01','Mobile',100);
Insert into spending values(2,'2099-07-02','Mobile',100);
Insert into spending values(3,'2099-07-01','Desktop',100);
Insert into spending values(3,'2099-07-02','Desktop',100);
*/

--select * from spending;


--method 1 > using window functions

with combination_cte as(
select *,
		count(1) over(partition by user_id,spend_date) as test_count
from spending
),
both_cte as
(
select spend_date, 
		sum(amount) as Total_amount,
		count(distinct user_id) as Total_users
from combination_cte
where test_count = 2
group by spend_date
),
mobile_deskto_users as
(
select spend_date,
		platform,
		sum(amount) as Total_amount,
		count(distinct user_id) as Total_users
from combination_cte
where test_count = 1
group by spend_date,
		platform
)
select spend_date, 'both' as [platform], Total_amount, Total_users from both_cte
union all
select * from mobile_deskto_users
order by spend_date asc;