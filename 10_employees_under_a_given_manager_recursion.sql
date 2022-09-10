--find the hierarchy of employees under a given manager
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

select * from emp_details
--find the hierarchy of employees under a given manager

with cte as(
select name,designation,id,manager_id,1 as hier_level from emp_details
where name = 'asha'

union all

select ed.name,ed.designation,ed.id,ed.manager_id,(hier_level + 1) as hier_level
from cte
join emp_details ed
on cte.id = ed.manager_id
)
select * from cte