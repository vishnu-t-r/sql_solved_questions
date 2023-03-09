--find n consecutive days
	--case 1 including weekends?
	--case 2 excluding weekends?

--select * from consecutive_days
/*
create table consecutive_day
(
date_column varchar(100)
)
*/
/*
insert into consecutive_day
select convert(varchar,concat("year","month","day"))
from consecutive_days
*/

--drop table consecutive_day
/*
delete from consecutive_day
where substring(date_column,7,4) = '2022'
*/


--ALTER TABLE consecutive_day ALTER COLUMN date_column date

--CASE1
--Including weekends
--select * from consecutive_day
/*
with tab1 as
(
select date_column
		,lead(date_column,1,dateadd(day,1,date_column))
			over(order by date_column asc)as following_day
		,dateadd(day,1,date_column) as next_day
		--,row_number() over(order by date_column asc) as rownumber
from consecutive_day
),
tab2 as
(
select --rownumber
		date_column
		,following_day
		,next_day
		,datediff(day,next_day,following_day) as diff
		,lag(datediff(day,next_day,following_day),1,0)
		over(order by date_column asc)   as diff_lag
from tab1
),
tab3 as
(
select *
		,sum(diff_lag) over(order by date_column) as run_sum
from tab2
),
tab4 as
(
select *
		,count(1) over(partition by run_sum) as continuous_days
from tab3
)

select distinct start_date_cont
				,continuous_days
from
(select *
		,first_value(date_column) over(partition by run_sum order by date_column asc) as start_date_cont
from tab4
)a
where continuous_days <> 0
*/


--select * from consecutive_day

--Including weekends
--implemented with case statement
with tbl1 as
(
select *
		,lag(date_column,1,dateadd(day,-1,date_column)) over(order by date_column asc) as lag_day
		,dateadd(day,-1,date_column) as next_day
		,case when lag(date_column,1,dateadd(day,-1,date_column)) over(order by date_column asc) = dateadd(day,-1,date_column)
				then 0
				else 1 end as flag
from consecutive_day
),
tbl2 as
(
select *
		,sum(flag) over(order by date_column) as batch
from tbl1
),
tbl3 as
(
select *
		,count(*) over(partition by batch) as conc_days
from tbl2
)
select * from tbl3
where flag = 1 and conc_days <> 1

--case 2 
--excluding weekends
select * 
		,DATENAME(WEEKDAY,date_column) as day_of_week
from consecutive_day
