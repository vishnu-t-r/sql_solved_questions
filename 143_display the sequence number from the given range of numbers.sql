use sql_challenge;

/*
'Sequence' Table has columns namely Start_Range and End_Range

Question :- Write a SQL query to print the Sequence Number from the given range of number.
*/

/*
create table sequence_tab(
start_range int,
end_range int)

insert into sequence_tab
values(1,4),(6,6),(8,9),(11,13),(15,15)
*/

--select * from sequence_tab;
with t1 as(
select max(end_range) as end_range from sequence_tab
), 
rcte as (
select min(start_range) as start_range from sequence_tab

union all

select (start_range + 1) as start_range
from rcte, t1
where start_range < end_range
),
t3 as(
select rcte.start_range as num,
		st.start_range,
		st.end_range
from rcte, sequence_tab st
)
select num from t3
--important is the where clause
where num >= start_range and num <= end_range

