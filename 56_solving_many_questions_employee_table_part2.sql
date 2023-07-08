--select * from [dbo].[Employee]

-- 6> Write a SQL query to fetch records of employee whose salary lies between 100000and 300000
select * from employee
where salary between 100000 and 300000

--7> Write a SQL query to find the dept wise average salary.
select department,avg(salary) as avg_salary
from employee
group by department

--8> Write a SQL query to get records of employe who have joined in Feb 2020
select * from employee
where year(joining_date) = 2020 and month(joining_date) = 2

--9> Write a SQL query to show the last record from a table. (based on employee_id)
-- do not use top clause

--use sub query in where clause

select * from employee
where employee_id = (select max(employee_id) from employee)


--10> Write a SQL query to fetch the department that provides maximum average salary 
   --and employees belonging to that dept


select * from employee
where department = (
select top 1 department--,avg(salary) as avg_salary
from employee
group by department
order by avg(salary) desc
)



select * from employee