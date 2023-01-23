--delete duplicates from a table

--table
--emp_loyee

/*
create table emp_loyee(
id int,
firstname varchar(50),
lastname varchar(50),
phone int,
mail varchar(100)
)



insert into emp_loyee(id,firstname,lastname,phone,mail)
values(3,'natasha','lee',432765,'natasha@demo.com'),
values(1,'adam','oven',123456,'adam@demo.com'),
(2,'mark','wills',345678,'mark@demo.com'),
(5,'adam','oven',123456,'adam@demo.com'),
(4,'riley','jones',987543,'riley@demo.com'),
(6,'natasha','lee',432765,'natasha@demo.com')

*/

select * from emp_loyee

--method 1
--using an aggregate function


delete from emp_loyee
where id not in
(
select --firstname,lastname,phone,mail,
	max(id)  as unique_id
from emp_loyee
group by firstname,lastname,phone,mail
)

select * from emp_loyee


--method_2
--using row_number
--cte (just to show it can be used), not necessary
with employee_cte as
(
select *,
	row_number() over(partition by firstname,lastname,phone,mail order by id) as serial_num
from emp_loyee
)

delete from emp_loyee
where id in (select id from employee_cte
				where serial_num > 1)

select * from emp_loyee

