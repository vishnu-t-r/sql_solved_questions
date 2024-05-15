use int_ques;

/*
Emp_Details Table has four columns EmpID, Gender, EmaillD and DeptID. 
Write a SQL query to derive another column called Email_List to display all
Emailid concatenated with semicolon associated with a each DEPT_ID order by emailid in asc order
*/

/*
create table emp_details(
EMPID int,
Gender varchar(2),
EmailID	varchar(20),
DeptID int)


insert into emp_details(EMPID, Gender, EmailID, DeptID)
values(1001,'M','john@mailg.com',104),
(1002,'M','george@mailg.com',103),
(1003,'F','riya@mailg.com',102),
(1004,'F','lewis@mailg.com',104),
(1005,'M','sid@yahu.com',101),
(1006,'M','max@yahu.com',100),
(1007,'F','susie@yahu.com',102),
(1008,'M','sachin@yahu.com',102),
(1009,'F','eliza@yahu.com',100)
*/

--STRING_AGG function syntax
/*
STRING_AGG ( expression, separator ) [ <order_clause> ]

<order_clause> ::=   
    WITHIN GROUP ( ORDER BY <order_by_expression_list> [ ASC | DESC ] )
*/

select * from emp_details;


select deptid, 
		string_agg(emailid, ';') as email_list
from emp_details
group by deptid


select deptid, 
		string_agg(emailid, ';') within group(order by emailid asc) as email_list
from emp_details
group by deptid





