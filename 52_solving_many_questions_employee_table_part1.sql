--employee
select * from employee
-- 1> Write a SQL query to find the nth highest salary from employee table. 
-- Example: finding 3rd highest salary from employee table

select salary, ROW_NUMBER() over(order by salary desc)
,rank() over (order by salary desc)
,dense_rank() over(order by salary desc) from employee 
-- 2> Write a SQL query to find top n records?
-- Example: finding top 5 records from employee table based on salary
select top 5 * from employee order by salary desc


-- 3> Write a SQL query to find the count of employees working in department 'Admin'
select count(*) from employee
where department = 'Admin'

-- 4> Write a SQL query to fetch department wise count employees sorted by department count in desc order.
select department,count(1) as empl_count
from employee
group by department 
order by empl_count desc

-- 5> Write a SQL query to find only odd rows from employee table
select * from employee
where employee_id%2 <> 0