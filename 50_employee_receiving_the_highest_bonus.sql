 -- ?? Write a SQL query to find employee (first name, last name, department and bonus) with highest bonus.

 select * from bonus

 select * from employee

 with t1 as(
 select top 1 employee_ref_id,sum(bonus_amount) as total_bonus
 from bonus
 group by employee_ref_id
 order by total_bonus desc
 )
 select e.first_name, e.last_name,e.department,t1.total_bonus as bonus
 from t1 
 join employee e
 on t1.employee_ref_id = e.employee_id


