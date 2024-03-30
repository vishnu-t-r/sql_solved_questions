use int_ques;

--Question (coding challenge)
/*
Julia asked her students to create some coding challenges. 
Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
Sort your results by the total number of challenges in descending order. 

If more than one student created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, 
then exclude those students (hacker_id) from the result.	
*/

/*
create table hackers(
hacker_id int,
name varchar(20)
)

create table challenges(
challenge_id int,
hacker_id int
)
*/


/*
insert into hackers(hacker_id, name)
values(12299,'rose'),
(34856,'angela'),(79345,'frank'),
(80491,'patrick'),(81041,'lisa'),(70978,'john')


insert into challenges(challenge_id, hacker_id)
values(63963,81041),
(63117,79345),
(28225,34856),
(21989,12299),
(4653,12299),
(70070,79345),
(36905,34856),
(61136,80491),
(17234,12299),
(80308,79345),
(40510,34856),
(79820,80491),
(22720,12299),
(21394,12299),
(36261,34856),
(15334,12299),
(71435,79345),
(23157,34856),
(54102,34856),
(69065,80491),
(63953,70978),
(63127,70978),
(28105,70978),
(11129,70978)

*/


--select * from hackers;
--select * from challenges;

with t1 as(
select hacker_id,
			count(challenge_id) as n,
			count(1) over(partition by count(challenge_id)) as nw_window,
			rank() over(order by count(challenge_id) desc) as n_rank
from challenges
group by hacker_id
)

select t1.hacker_id, h.name, n
from t1 left join hackers h
on t1.hacker_id = h.hacker_id
where nw_window = 1 or n_rank = 1;



