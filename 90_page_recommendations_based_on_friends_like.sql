--Recommended pages

use questions;

--Recommend pages for a person based on the pages liked by his friends
--dont recommend pages already liked by the person

--tables
	--friends
	--likes

/*
create table friends(
user_id1 varchar(20),
user_id2 varchar(20)
)
insert into friends(user_id1, user_id2)
values(1 ,2),
(1 ,3),
(1 ,4),
(2 ,3),
(2 ,4),
(2 ,5),
(6 ,1)
*/

/*
create table likes(
users_id varchar(20),
page_id varchar(20)
)

insert into likes(users_id,page_id)
values(1, 88),
(2, 23),
(3, 24),
(4, 56),
(5, 11),
(6, 33),
(2, 77),
(3, 77),
(6, 88)
*/

select * from friends;
select * from likes;


--Question?

--Write an SQL query to recommend pages to the user with user_id = 1 using the pages that your friends liked. 
--It should not recommend pages you already liked.

with t1 as
(
select distinct user_id1 as friend from 
friends
where user_id2 = 1
union
select distinct user_id2 as friend from 
friends
where user_id1 = 1
),
t2 as
(
select distinct page_id from likes
where users_id in (select friend from t1)
)

select t2.page_id from t2
left join 
(select page_id
from likes where users_id = 1) a
on t2.page_id = a.page_id
where a.page_id is null

--select * from likes