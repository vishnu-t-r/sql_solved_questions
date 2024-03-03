--Popularity Percentage

/*
Find the popularity percentage for each user on Meta/Facebook. 
The popularity percentage is defined as the total number of friends the user has 
divided by the total number of users on the platform, 
then converted into a percentage by multiplying by 100.
*/

/*
Output each user along with their popularity percentage. Order records in ascending order by user id
*/
use int_ques;

/*
create table facebook_friends(
user1 int,
user2 int
)

insert into facebook_friends(user1, user2)
values(2,1),
(1,3),
(4,1),
(1,5),
(1,6),
(2,6),
(7,2),
(8,3),
(3,9)
*/

--select * from facebook_friends

with t1 as
(
select user1 as users, count(distinct user2) as friend_count
from facebook_friends
group by user1

union all

select user2 as users, count(distinct user1) as friend_count
from facebook_friends
group by user2
)
select users, sum(friend_count) as total_friends , (select count(distinct users) from t1) as total_users,
		round( cast(sum(friend_count) as float)/(select count(distinct users) from t1)*100,2) as percent_popularity
from t1
group by users
order by users asc


