--subquery in the select clause
--referencing columns from the outer query in the inner subquery
--find the employees who are earning a salary greaer than or less than the average dept salary ?

select * from [dbo].[emp_salary]


select e1.name,
		e1.salary,
		(select avg(e2.salary) from emp_salary e2
		where e2.departmentid = e1.departmentid) as dept_avg
from emp_salary e1