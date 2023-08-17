--You are given a table, Projects, containing three columns: 
--Task_ID, Start_Date and End_Date. 
--It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.

--If the End_Date of the tasks are consecutive, then they are part of the same project. 
--Samantha is interested in finding the total number of different projects completed.
--Write a query to output the start and end dates of projects listed by the number of days it took to complete 
--the project in ascending order. If there is more than one project that have the same number of completion days, 
--then order by the start date of the project.

/*
create table tasks
(
task_id int,
start_date datetime2,
end_date datetime2
)


insert into tasks(task_id,start_date,end_date)
values(2,'2015-10-02','2015-10-03'),
(3,'2015-10-03','2015-10-04'),
(4,'2015-10-13','2015-10-14'),
(5,'2015-10-14','2015-10-15'),
(6,'2015-10-28','2015-10-29'),
(7,'2015-10-30','2015-10-31')
*/

--select * from tasks
with t1 as
(
select end_date,row_number() over(order by end_date asc) as rw_num
from tasks
where end_date not in (select start_date from tasks)
),
t2 as
(
select start_date,row_number() over(order by start_date asc) as rw_num
from tasks
where start_date not in (select end_date from tasks)
)
select t2.start_date,t1.end_date
from t1 
left join t2
on t1.rw_num = t2.rw_num
order by datediff(day,t2.start_date,t1.end_date) asc, t2.start_date
