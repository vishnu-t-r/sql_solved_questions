--Project Planning

/*
You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.

If the End_Date of the tasks are consecutive, then they are part of the same project. 
The manager is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete 
the project in ascending order. 
If there is more than one project that have the same number of completion days, 
then order by the start date of the project.
*/

use int_ques;

--select * from tasks;

--method 1

with t1 as(
select start_date 
from tasks
where start_date not in (select end_date from tasks)
), t2 as
(
select end_date
from tasks
where end_date not in (select start_date from tasks)
),t3 as
(
select *,
		row_number() over(partition by start_date order by end_date asc) as rw_num
from t1,t2
where t1.start_date < t2.end_date
--order by start_date asc
)
select *
from t3
where rw_num = 1;



--method 2
with t1 as
(
select start_date,row_number() over(order by start_date asc) as rw_num
from tasks
where start_date not in (select end_date from tasks)
), t2 as
(
select end_date,row_number() over(order by end_date asc) as rw_num
from tasks
where end_date not in (select start_date from tasks)
)
select t1.start_date, t2.end_date
from t1 left join t2 on t1.rw_num = t2.rw_num
order by datediff(day,t1.start_date,t2.end_date) desc, t1.start_date asc;
