--find the employees who are earning a salary greaer than or less than the average dept salary ?
--without using join and window functions

select * from emp_salary
/*
create table emp_salary(
id int,
name varchar(50),
salary int,
departmentid int
)
*/
/*
insert into emp_salary(Id,Name,Salary,DepartmentId)
values
(1,'Joe',85000,1),
(2,'Henry',80000,2),
(3,'Sam',60000,2),
(4,'Max',90000,1),
(5,'Janet',69000,1),
(6,'Randy',85000,1),
(7,'Will',70000,1),
(8,'Chris',65000,3),
(9,'cathy',75000,3),
(10,'louis',80000,3)
*/

select Id
		,Name
		,salary
		,DepartmentId
		,(select avg(e2.salary) from emp_salary e2
			where e2.DepartmentId = e1.DepartmentId) as avg_dept_salary
		,case when (salary - (select avg(e2.salary) from emp_salary e2
			where e2.DepartmentId = e1.DepartmentId)) > 0 then 'higher'
			else 'lower' end as avg_dept_sal_ind
from emp_salary e1	