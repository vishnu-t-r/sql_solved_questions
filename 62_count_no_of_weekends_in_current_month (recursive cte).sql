--COUNT THE NUMBER OF WEEKEND IN THE CURRENT MONTH?

--implemented using recursive cte
--combination of recursive cte and cte
--along with date functions

--select value
--from GENERATE_SERIES(1,10)

/*
ALTER DATABASE master
SET COMPATIBILITY_LEVEL = 160
*/

/*
declare @num int = 365;

--select @num;

with t1 as
(
select @num as input, 1 as n
union all
select (input-1) as input, n+1 as n
from t1
where input > 1)
select * from t1
option (maxrecursion 400)
*/


with t1 as
(
select getdate() as tday,
eomonth(getdate()) as endofmonth,
0 as monthenddate,
dateadd(day,-(day(eomonth(getdate()))-1),eomonth(getdate())) as startofmonth,
dateadd(day,-(day(eomonth(getdate()))-1),eomonth(getdate())) as calendardate

union all

select tday,
		endofmonth,
		(1+monthenddate) as monthenddate,
		startofmonth,
		dateadd(day,1,calendardate) as calendardate
from t1
where calendardate < endofmonth
),
t2 as
(
select t1.*,
		datename(weekday,t1.calendardate) as week_day
from t1
)
select count(*) as monthly_weekendcount
from t2
where week_day = 'Friday'



