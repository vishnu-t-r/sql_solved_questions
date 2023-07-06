
--what will be the result of the following query ?
--result should have columns:
	--'emp_name','dept_name','result_column'
--input table ('employee') in the description
	
select emp_name, 
		dept_name, 
		(select 
			avg(e1.salary) 
		 from employee e1 
		 where 
		 e1.dept_name = e2.dept_name
		 ) as result_column
from employee e2