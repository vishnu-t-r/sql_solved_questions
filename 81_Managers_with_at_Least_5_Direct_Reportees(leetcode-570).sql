--LEETCODE 570

--Write a solution to find managers with at least five direct reports.
--Return the result table in any order.


use leetcode;

/*
create table employee(
id int, 
name varchar(50), 
department varchar(20), 
managerid int)

insert into employee(id, name, department, managerid)
values(101,'John','A', null),
(102,' Dan','A', 101),
(103,'James','A', 101),
(104,'Amy','A', 101),
(105,'Anne','A', 101),
(106,'Ron','B', 101)
*/


select b.name
from
(
select managerid, count(*) as num
from employee
group by managerid
) a 
join employee b on a.managerid = b.id
where a.num >= 5
