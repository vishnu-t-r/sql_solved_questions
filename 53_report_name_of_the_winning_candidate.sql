--write a sql query to report the name of the winning candidate (candidate with largest number of votes)
--exactly one candidate wins the election

--candidate table
--vote table

/*
create table candidate(id int,name varchar(10));
insert into candidate values(1,'A');
insert into candidate values(2,'B');
insert into candidate values(3,'C');
insert into candidate values(4,'D');
insert into candidate values(5,'E');
select * from candidate;

create table vote(id int,candidateId int);
insert into vote values(1,2);
insert into vote values(2,4);
insert into vote values(3,3);
insert into vote values(4,2);
insert into vote values(5,5);
select * from vote;
*/

select * from candidate
select * from vote

select top 1 c.name
from candidate c
left join
(select candidateId,count(1) as n
from vote
group by candidateId) v
on c.id = v.candidateId
order by v.n desc