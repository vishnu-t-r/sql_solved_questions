--find the hierarchy of managers for a given employee

/*
CREATE TABLE emp_details(
id int not null identity(1,1),--auto_increment
name varchar(255),
manager_id int,
designation varchar(255)
)

insert into emp_details(name,manager_id,designation)
values('shripadh',NULL,'ceo')
,('satya',5,'software engineer')
,('jia',5,'data analyst')
,('david',5,'data scientist')
,('michael',7,'manager')
,('aravind',7,'architect')
,('asha',1,'cto')
,('mariyam',1,'manager')
,('reshma',8,'business anayst')
,('akshay',8,'java developer')

*/

--select * from emp_details;

with cte as
(
select id,name,manager_id from emp_details
where name = 'jia'

union all

select ed.id,ed.name,ed.manager_id from 
cte
join
emp_details ed
on cte.manager_id = ed.id

)

select cte.*,emp.name as manager_name from cte
join
emp_details emp on cte.manager_id = emp.id