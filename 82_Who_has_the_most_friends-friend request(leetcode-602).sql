use leetcode;

--QUESTION

--Write a solution to find the people who have the most friends and the most friends number.

/*
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
*/

/*
create table requestaccepted(
requester_id int,
accepter_id int,
accept_date date
)

insert into requestaccepted(requester_id, accepter_id, accept_date)
values(1,2,'2016-06-03'),
(1,3,'2016-06-08'),
(2,3,'2016-06-08'),
(3,4,'2016-06-09')
*/

--select * from requestaccepted;

select top 1 id, sum(friend_count) as friend_count
from(

select distinct requester_id as id, count(accepter_id) as friend_count
from requestaccepted 
group by requester_id
union all
select distinct accepter_id as id, count(requester_id) as friend_count
from requestaccepted
group by accepter_id

) a
group by id
order by friend_count desc

--method 2

with t1 as
(
select requester_id as id
from requestaccepted 

union all

select accepter_id as id
from requestaccepted
)
select top 1 id, count(*) as friend_count
from t1
group by id
order by friend_count desc