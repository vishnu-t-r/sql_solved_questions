/*
CREATE TABLE user_registration(
id int not null primary key,
reg_date date,
reg_users int
)
*/

/*

insert into user_registration(id,reg_date,reg_users)
values(1,'01/25/2023',51),
(2,'01/26/2023',46),
(3,'01/27/2023',41),
(4,'01/28/2023',0),
(5,'01/29/2023',0),
(7,'01/30/2023',59),
(8,'01/31/2023',73),
(9,'02/01/2023',34),
(10,'02/02/2023',56),
(11,'02/03/2023',0),
(12,'02/04/2023',34),
(13,'02/05/2023',50),
(14,'02/06/2023',25)

*/

--select * from user_registration;



--find start date and end date of the continuous streak?
--duration of the continuous streak
--total number of users registred in that streak?
--find the streak in which the average number of users registered is highest?

--find the advertisment effectiveness of different ads
with t1 as
(
select 
	ur.*
	,ROW_NUMBER() OVER(ORDER BY ur.reg_date asc) as new_id
	,dateadd(day,-ROW_NUMBER() OVER(ORDER BY ur.reg_date asc),ur.reg_date) as window
from user_registration ur
where reg_users <> 0
),
t2 as
(
select *
	,sum(reg_users) over(partition by window) as total_users
	,last_value(reg_date) over(partition by window order by reg_date asc RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as end_date
	,first_value(reg_date) over(partition by window order by reg_date asc RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as start_date
from t1
),
t3 as
(
select distinct start_date,
		end_date,
		datediff(day,start_date,end_date) as duration,
		total_users,
		total_users/datediff(day,start_date,end_date) as avg_reg
from t2
)
select *
from t3
where avg_reg = (select max(avg_reg) from t3)
