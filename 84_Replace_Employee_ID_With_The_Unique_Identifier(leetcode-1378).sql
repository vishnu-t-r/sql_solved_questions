use leetcode;


--Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

--leetcode 1378
--Replace Employee ID With The Unique Identifier


/*
create table employees(id int, name varchar(40))

insert into employees(id, name)
values(1, 'alice'),
(7, 'bob'),
(11, 'meir'),
(90,'winston'),
(3,'jonathan')

create table employeeuni(id int, unique_id int)

insert into employeeuni(id, unique_id)
values(3,101),
(11,102),
(90,103),
(10,104)
*/


select * from employees
select * from employeeuni


select e1.unique_id, e2.name
from employeeUNI e1
full outer join employees e2
on e1.id = e2.id