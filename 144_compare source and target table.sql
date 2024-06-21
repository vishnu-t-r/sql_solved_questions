use sql_challenge;

/*
Question :- Obtain the output in the given format
*/

/*
create table source_tab(
id int,
letter varchar(5));

create table target_tab(
id int,
letter varchar(5));

insert into source_tab
values(1,'A'),(2,'C'),(3,'E'),(4,'G')

insert into target_tab
values(1,'A'),(3,'E'),(4,'X'),(5,'K')

*/

--select * from source_tab;
--select * from target_tab;

select s.id, 'Only in Source' as Comment
from source_tab s left join target_tab t
on s.id = t.id 
where t.id is null

union all

select t.id,'Only in Target' as Comment
from target_tab t left join source_tab s
on s.id = t.id
where s.id is null

union all

select s.id, 'Mismatch' as Comment
from source_tab s inner join target_tab t
on s.id = t.id and s.letter <> t.letter