--Question 1: Each team play with every other team only once?
--Question 2: Each team plays with every other team twice?

use questions;

/*
create table team_table
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into team_table values ('IND', 'India');
insert into team_table values ('AUS', 'Australia');
insert into team_table values ('ENG', 'England');
insert into team_table values ('NZ', 'New Zealand');
insert into team_table values ('SA', 'South Africa');
*/

--?Question1: Each team play with every other team only once?

select * from team_table;

/*
select t1.team_code, t2.team_code
from team_table t1
cross join team_table t2
*/

with team as
(
select team_code, row_number() over(order by team_code asc) as id
from team_table 
)
select t1.team_code, t2.team_code
from team t1
join team t2 on t1.id > t2.id

--Question2: Each team plays with every other team twice?

with team as
(
select team_code, row_number() over(order by team_code asc) as id
from team_table 
)
select t1.team_code, t2.team_code
from team t1
join team t2 on t1.id <> t2.id
