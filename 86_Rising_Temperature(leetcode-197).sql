use leetcode;

--Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
--leetcode 197

/*
create table weather(
id int,
record_date date,
temperature int
)

insert into weather(id, record_date, temperature)
values(1,'2015-01-01',10),
(2,'2015-01-02',25),
(3,'2015-01-03',20),
(4,'2015-01-04',30),
(5,'2015-01-05',3),
(6,'2015-01-06',-7),
(7,'2015-01-07',-2),
(8,'2015-01-09',10)
*/


select * from weather


--method 1

with t1 as
(
select id, record_date, temperature,
		lag(temperature) over(order by record_date asc) previous_day_temp
from weather
)
select id, record_date, temperature, previous_day_temp,
		case when temperature > previous_day_temp then 'high'
			else 'low' end as flag
from t1



--new test case

truncate table weather;

/*
| id | recordDate | temperature |
| -- | ---------- | ----------- |
| 1  | 2000-12-14 | 3           |
| 2  | 2000-12-16 | 5           |
*/

/*
insert into weather(id, record_date, temperature)
values(1,'2000-12-14',3),
(2,'2000-12-14',5)
*/


select * from weather


--method 2 
--better approach

select id
from
(
select w1.*,
		w2.temperature as new_temp, 
		w2.record_date as new_date,
		datediff(day,w2.record_date,w1.record_date) as date_diff
from weather as w1, weather as w2
where w1.temperature > w2.temperature
and datediff(day,w2.record_date,w1.record_date) = 1
) a






