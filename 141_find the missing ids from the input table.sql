use sql_challenge;

/*
Question
Write a SQL to find the missing ID From the input Table.
Id should have been continuous values starting from 1 to 20.
*/

/*
create table id_tab(
id int)

insert into id_tab
values(1),(4),(7),(9),(12),(14),(16),(17),(20)
*/
--select * from id_tab;

--method 1

with rcte as
(select  1 as id

union all

select (id+1) as id
from rcte
where rcte.id < 20
)
select rcte.id from rcte
left join id_tab
on rcte.id = id_tab.id
where id_tab.id is null;


--method 2

with t1 as(
select max(id) as max_id from id_tab
),
rcte as(
select min(id) as id from id_tab

union all

select (id+1) as id from rcte inner join t1 on rcte.id < t1.max_id
)
select rcte.id from rcte
left join id_tab
on rcte.id = id_tab.id
where id_tab.id is null;