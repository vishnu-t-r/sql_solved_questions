--find most recently hired employees from the employee table,
--who are only part of the departments in dept table


use int_ques;

/*
create table dept(
deptid int,
deptname varchar(20))

insert into dept(deptid, deptname)
values(1,'Account'),
(2,'Admin')

*/

select * from dept

select * from [dbo].[Employee]


select E.*,D.*
from dept D
cross apply 
( select top 2 * 
from employee 
where employee.department = D.deptname
order by joining_date desc) E