--Question?

--Find the records from the employee table for which employee names are starting with vowels(aeiou)?

--Table name
--employee

select * from employee
where emp_NAME LIKE '[aeiou]%'
order by emp_NAME ASC



