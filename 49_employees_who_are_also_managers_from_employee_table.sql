--? Write a SQL query to find all the employees from employee table who are also managers 

select * from employee

select a.first_name,
		a.last_name
from employee a
join employee b
on
a.employee_id = b.manager_id;