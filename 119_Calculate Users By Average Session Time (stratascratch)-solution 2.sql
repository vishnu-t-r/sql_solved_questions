--Solution 2
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

--select top 10 * from users_web_log

/*
select user_id, timestamp, action, max(timestamp) over(partition by user_id, action,timestamp) as test
from users_web_log
where action in ('page_load','page_exit')
*/
with page_load as(
select user_id, --timestamp, 
		day(timestamp) as [day], max(timestamp) as latest_page_load
from users_web_log
where action = 'page_load'
group by user_id, day(timestamp)
--order by user_id
), page_exit as
(
select user_id, --timestamp, 
		day(timestamp) as [day], min(timestamp) as earliest_page_exit
from users_web_log
where action = 'page_exit'
group by user_id, day(timestamp)
--order by user_id
)
select pl.user_id, --pl.day,
		avg(cast(datediff(second, latest_page_load, earliest_page_exit) as decimal(10,2))) as avg_duration
		--datediff(second, latest_page_load, earliest_page_exit)
from page_load pl inner join page_exit pe
on pl.user_id = pe.user_id and pl.day = pe.day
group by pl.user_id