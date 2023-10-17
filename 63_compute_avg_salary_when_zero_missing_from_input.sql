
--? Question
--Employee 'A' is asked to compute the average salary of all employees from the 'employee_salary' table 
--he created but realized that the zero key in his keyboard is not working after the result showed a very less average. 
--He wants to finding out the actual average and 
--difference between miscalculated average and actual average.


use int_ques;

/*
create table employee_salary(
emp_id int not null,
name varchar(50),
salary int
)

insert into employee_salary(emp_id, name, salary)
values(110, 'sam', 156),
(111, 'tina', 18),
(112, 'toto', 4),
(113, 'jack', 234),
(114, 'lewis', 32),
(115, 'george', 2),
(116, 'alex', 23),
(117, 'sheldon', 34),
(118, 'tom', 3),
(119, 'tony', 32)

*/

--select * from employee_salary

--salary is a 5 digit integer

with t1 as
(
select *
		,CONVERT(varchar(50),salary) as salary_str
		,len(CONVERT(varchar(50),salary)) as length_salary
		,5-len(CONVERT(varchar(50),salary)) as zeros_append
		,replicate('0',(5-len(CONVERT(varchar(50),salary)))) as zero_string
		,concat(CONVERT(varchar(50),salary),replicate('0',(5-len(CONVERT(varchar(50),salary))))) as actual_salary_str
from employee_salary
),
t2 as
(
select emp_id,name,convert(int,actual_salary_str) as actual_salary
from t1
)
select avg(actual_salary) as avg_salary
from t2

