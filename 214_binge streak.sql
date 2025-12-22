use db_questions;

/*
--The 3 day binge streak

--ddl -> create table
create table watch_history(
watch_id int,
user_id int,
watch_date date );

--dml -> populate with streak data
INSERT INTO watch_history (watch_id, user_id, watch_date) VALUES
(1, 501, '2025-12-01'), -- User 501: Day 1
(2, 501, '2025-12-02'), -- User 501: Day 2
(3, 501, '2025-12-03'), -- User 501: Day 3 (STREAK!)
(4, 502, '2025-12-01'), -- User 502: Day 1
(5, 502, '2025-12-03'), -- User 502: Day 3 (Broken streak)
(6, 503, '2025-12-10'), -- User 503: Day 10
(7, 503, '2025-12-11'), -- User 503: Day 11
(8, 503, '2025-12-12'); -- User 503: Day 12 (STREAK!)
*/
--solution 1
--find user_id and watch_date combinations
with daily_watch as(
select distinct user_id, watch_date
from watch_history
), continuitycheck as(
select user_id, watch_date, lag(watch_date,1) 
					over(partition by user_id order by watch_date asc) as previous_1,
		lag(watch_date,2) 
					over(partition by user_id order by watch_date asc) as previous_2
from daily_watch
)
select distinct user_id
from continuitycheck
where watch_date = DATEADD(day,1,previous_1)
	and watch_date = dateadd(day,2,previous_2)

--solution 2
with daily_watch as(
select distinct user_id, watch_date 
from watch_history),
streak_count as(
select user_id, watch_date,
		row_number() over(partition by user_id order by watch_date) as id,
		dateadd(day,
		- row_number() over(partition by user_id order by watch_date),watch_date) 
		as streak_group
from daily_watch
), streak as(
select user_id, count(*) as streak_length
from streak_count
group by user_id, streak_group
)
select distinct user_id
from streak
where streak_length >= 3;