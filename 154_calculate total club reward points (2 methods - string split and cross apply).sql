use sql_challenge;

/*
Question:- Club Table has three columns namely Club_ID, Member_id and EDU.
Same member can be a part of different club. The EDU column has different rewards. The points
for these awards are as follows :-
MM - 0.5, CI - 0.5, CO- 0.5, CD - I, CL-I, CM - I
Write a SQL query to find the total points scored by each club.
*/

/*
create table club(
club_id int,
member_id int,
rewards varchar(20));

insert into club
values(1001,210, null),(1001,211,'MM:CI'),(1002,215,'CD:CI:CM'),
(1002,216,'CL:CM'),(1002,217,'MM:CM'),(1003,255,null),
(1001,216,'CO:CD:CL:MM'),(1002,210,null)
*/

--select * from club;

--MM - 0.5, CI - 0.5, CO - 0.5, CD - 1, CL - 1, CM - 1

with cte as(
select club_id, member_id, value as reward
from 
	(select club_id,member_id,isnull(rewards,'A') as rewards from club) b
cross apply string_split(rewards,':')
),
point_cte as(
select club_id,
		member_id,
		reward,
		case reward 
			when 'MM' then 0.5
			when 'CI' then 0.5
			when 'CO' then 0.5
			when 'CD' then 1
			when 'CL' then 1
			when 'CM' then 1
			else 0
			end as points
from cte)
select club_id, sum(points) as total_points
from point_cte
group by club_id;
