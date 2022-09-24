---FIND THE ARENT AGE WHEN THE CHILD WAS BORN

/*
create table tab_parent
(
parent varchar(255) not null,
child varchar(255) not null,
birthyear int 
)


insert into tab_parent(parent,child,birthyear)
values('alice','carol',1945)
,('bob','carol',1945)
,('carol','dave',1970)
,('carol','george',1972)
,('dave','mary',2000)
,('eve','mary',2000)
,('mary','frank',2020)

*/

--select * from tab_parent


with cte as
(
select parent,child,birthyear,0 as parent_age from tab_parent
where parent = 'carol'--alice

union all

select tp.parent,tp.child,tp.birthyear, (tp.birthyear - cte.birthyear) as parent_age
from cte
join
tab_parent tp
on cte.child = tp.parent
)
select * from cte