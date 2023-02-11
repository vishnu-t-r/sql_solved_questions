--select * from salary
--select * from emp_dept

--write a query to display the comparison result (higher/lower/same) of the average salary of 
--employees in a department to the company’s average salary.


--output table should contain 
	--1.month
	--2.department
	--3.avg dept salary
	--4.company avg monthly salary
	--5.comparison (higher/lower/same) (avg dept salary compared to company avg salary)
with table_1 as
(
select s.id
		,s.employee_id as employee_id
		,s.amount
		,s.pay_date
		,ed.employee_id as dept_employee_id
		,ed.department_id as dept_id
		,datepart(month,pay_date) as month
from salary s
join emp_dept ed
on s.employee_id = ed.employee_id
),
table_2 as
(
select distinct dept_id
		,month
		,avg(amount) over(partition by dept_id,month) as dept_avg
		,avg(amount) over(partition by month) as company_avg
from table_1
)

select *
		,case when dept_avg > company_avg then 'higher'
				when dept_avg < company_avg then 'lower'
				when dept_avg = company_avg then 'same'
				end as comparison
from table_2


/*
create table salary(
id int,
employee_id int,
amount int,
pay_date datetime
)
*/
/*
insert into salary(id,employee_id,amount,pay_date)
values(1,1,9000,'2017-03-31'),
(2,2,6000,'2017-03-31'),
(3,3,10000,'2017-03-31'),
(4,1,7000,'2017-02-28'),
(5,2,6000,'2017-02-28'),
(6,3,8000,'2017-02-28')
*/
/*
create table emp_dept(
employee_id int,
department_id int
)

insert into emp_dept(employee_id,department_id)
values(1,1),
(2,2),
(3,2)
*/