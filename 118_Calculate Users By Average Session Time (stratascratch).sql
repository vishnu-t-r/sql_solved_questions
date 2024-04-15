--Users By Average Session Time
	--Calculate each user's average session time?

use int_ques;

/*
Calculate each user's average session time. 
A session is defined as the time difference between a page_load and page_exit. 
For simplicity, assume a user has only 1 session per day 
and if there are multiple of the same events on that day, 
consider only the latest page_load and earliest page_exit, 
with an obvious restriction that load time event should happen before exit time event . 
Output the user_id and their average session time.
*/

/*
create table users_web_log(
user_id int,
timestamp datetime,
action varchar(25)
)

insert into users_web_log(user_id,timestamp,action)
values(0	,'2023-04-25 13:30:15','page_load'),
(0	,'2023-04-25 13:30:18','page_load'),
(0	,'2023-04-25 13:30:40','scroll_down'),
(0	,'2023-04-25 13:30:45','scroll_up'),
(0	,'2023-04-25 13:31:10','scroll_down'),
(0	,'2023-04-25 13:31:25','scroll_down'),
(0	,'2023-04-25 13:31:40','page_exit'),
(1	,'2023-04-25 13:40:00','page_load'),
(1	,'2023-04-25 13:40:10','scroll_down'),
(1	,'2023-04-25 13:40:15','scroll_down'),
(1	,'2023-04-25 13:40:20','scroll_down'),
(1	,'2023-04-25 13:40:25','scroll_down'),
(1	,'2023-04-25 13:40:30','scroll_down'),
(1	,'2023-04-25 13:40:35','page_exit'),
(2	,'2023-04-25 13:41:21','page_load'),
(2	,'2023-04-25 13:41:30','scroll_down'),
(2	,'2023-04-25 13:41:35','scroll_down'),
(2	,'2023-04-25 13:41:40','scroll_up'),
(1	,'2023-04-26 11:15:00','page_load'),
(1	,'2023-04-26 11:15:10','scroll_down'),
(1	,'2023-04-26 11:15:20','scroll_down'),
(1	,'2023-04-26 11:15:25','scroll_up'),
(1	,'2023-04-26 11:15:35','page_exit'),
(0	,'2023-04-28 14:30:15','page_load'),
(0	,'2023-04-28 14:30:10','page_load'),
(0	,'2023-04-28 13:30:40','scroll_down'),
(0	,'2023-04-28 15:31:40','page_exit')
*/

--select * from users_web_log
--order by user_id asc, timestamp asc;

with t1 as(
select *,
		row_number() over(partition by user_id,action,cast(timestamp as date) order by timestamp desc) as flag
from users_web_log
where action in ('page_load','page_exit')
),t2 as(
select user_id,cast(timestamp as date) as date_dd, max(case when action = 'page_load' then timestamp end) as login_time,
		max(case when action = 'page_exit' then timestamp end) as logout_time	
from t1
where flag = 1
group by user_id, cast(timestamp as date)
), t3 as(
select user_id,date_dd,
		datediff(second,login_time,logout_time) as session_time
from t2
where login_time is not null and logout_time is not null
)
select user_id,
		avg(cast(session_time as float)) as session_time
from t3
group by user_id
