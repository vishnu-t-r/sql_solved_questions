--self join

--Table
--employee (db - questions)

/*
create table employee(
Id int,
FullName varchar(100),
Salary int,
ManagerId int
)

insert into employee(Id,FullName,Salary,ManagerId)
values(1,'John',10000,3),
(2,'Jane',12000,3),
(3,'Tom',15000,4),
(4,'Anne',20000,null),
(5,'Jeremy',9000,1)

*/

--SELF JOIN
--a self join links a table to itself
--To use a self join, the table must contain a column (call it X) ....
--that acts as the primary key and a different column (call it Y) ....
--that stores values that can be matched up with the values in Column X.

--Question?
--Show the name of the manager for each employee in the same row?
--Result set should contain four columns, namely:
	--1)emp_id (Employee Id)
	--2)emp_name (Employee Name)
	--3)manager_id (Manager Id)
	--4)manager_name (Manager Name)

--select * from employee

select employee.Id as emp_id
		,employee.FullName as emp_name
		,employee.ManagerId as manager_id
		,manager.FullName as manager_name
from
employee employee
join employee manager
on employee.managerId = manager.Id


