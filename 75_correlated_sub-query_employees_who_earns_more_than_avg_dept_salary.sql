--Find all the employees who earn more than the average salary in their department?

--using correlated sub query

use int_ques;

select * from Employee;

select first_name,
		last_name,
		department,
		salary
from employee outerquery
where outerquery.salary > (
							select avg(salary)
							from employee innerquery
							where innerquery.department = outerquery.department
							group by department
							)

