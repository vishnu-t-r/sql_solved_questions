--? question

--find the organizational structure based on the input id
--and find the hierarchy for that particular dept

/*
create table org(
id int,
dept_name varchar(max),
par_dept_id int
)

insert into org(id,dept_name,par_dept_id)
values(1,'ceo office', ''),
(2,'vp sales',1),
(3,'vp operations',1),
(4,'northeast sales',2),
(5,'northwest sales',2),
(6,'infrastructure ope',3),
(7,'management ope',3)



update org
set par_dept_id = null
	where id = 1
*/

--select * from org

with cte as
(
select id,dept_name,par_dept_id
from org
where id = 7

union all

select o.id,o.dept_name,o.par_dept_id
from cte c
join org o
on c.par_dept_id = o.id

)
select * from cte