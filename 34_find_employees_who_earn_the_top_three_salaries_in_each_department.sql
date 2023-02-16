--Write an SQL query to find employees who earn the top three salaries in each of the department. 
--Your SQL query should return the following rows.
	--1. Department Name
	--2. Employee Name
	--3. Salary
	--4. Rank
--sort the result in descending order of salary for each department
--if two salary are equal, the sort result based on the employee name
/*
select * from emp_salary
select * from dept
*/

select DepartmentId
		,Name as EmployeeName
		,Salary
		,dns_rnk as Top3_Rank
from
(
select *
		,rank() over(partition by DepartmentId order by Salary desc) as rnk
		,dense_rank() over(partition by DepartmentId order by Salary desc) as dns_rnk
from emp_salary
) A
where dns_rnk <= 3