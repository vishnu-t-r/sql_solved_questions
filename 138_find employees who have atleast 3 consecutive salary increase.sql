use sql_challenge;

/*
Question :-
Consider two database tables: "employees" and "salary_logs". Write an SQL query to find the
employees who have had at least three consecutive salary increases. Display the employee ID, employee
name, department, and the periods during which the consecutive salary increases occurred.

*/
/*

create table employees(emp_id int,emp_name varchar(20),department varchar(20));

create table salary_logs(log_id int,emp_id int,salary int);

insert into employees values(1,'John','HR'),(2,'Alice','Engineering'),(3,'Bob','HR'),(4,'Mary','Engineering');

insert into salary_logs 
values(1,1,3000),(2,2,3500),
(3,1,3200),(4,1,3500),
(5,2,3800),(6,3,3000),
(7,4,4000),(8,3,3200),
(9,4,4200),(10,3,3500);

*/

--select * from employees;


--select * from salary_logs
--order by emp_id, log_id ;

--method 1

with t1 as(
select log_id,
		emp_id,
		salary,
		lead(salary) over(partition by emp_id order by log_id asc) as flg,
		lead(salary) over(partition by emp_id order by log_id asc) - salary as diff
from salary_logs
),
t2 as(
select log_id,
		emp_id,
		salary,
		flg,
		diff,
		case when diff > 0 or diff is null then 1
			else -1 end as nw_flg
from t1
), t3 as
(
select *,
		sum(nw_flg) over(partition by emp_id) as period
from t2
)
select t3.emp_id, period,
		e.emp_name, e.department
from t3 left join employees e on
t3.emp_id = e.emp_id
group by t3.emp_id, period, e.emp_name, e.department

--method 2

WITH consecutive_logs AS (
    SELECT
        emp_id,
        log_id,
        salary,
        ROW_NUMBER() OVER (PARTITION BY emp_id, salary ORDER BY log_id) AS grp
    FROM
        salary_logs
)
SELECT
    e.emp_id,
    e.emp_name,
    e.department,
    COUNT(*) AS period
FROM
    employees e
JOIN
    consecutive_logs c ON e.emp_id = c.emp_id
GROUP BY
    e.emp_id,
    e.emp_name,
    e.department,
    c.grp
HAVING
    COUNT(*) >= 3;