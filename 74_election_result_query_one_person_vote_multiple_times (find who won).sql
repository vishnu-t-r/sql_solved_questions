--select * from election;

--table

/*
create table election(
voters varchar(100),
candidate varchar(100)
)

insert into election(voters, candidate)
values('Celia Shepard','Austin Stanton'),
('Celia Shepard','Johnny Reeves'),
('Reggie Hernandez','Austin Stanton'),
('Pete Villa','Mai Patton'),
('Pete Villa','Kristie Harrell'),
('Pete Villa','Austin Stanton'),
('Tricia Mercer','Mai Patton'),
('Lemuel Farrell','Johnny Reeves'),
('Deborah Farley','Kristie Harrell'),
('Deborah Farley','Austin Stanton'),
('Janna Clay','Johnny Reeves'),
('Petra Fields','Austin Stanton'),
('Petra Fields','Johnny Reeves'),
('Petra Fields','Mai Patton'),
('Johanna Montes','Kristie Harrell'),
('Muriel Daniels','Johnny Reeves'),
('Muriel Daniels','Mai Patton'),
('Dominique Solis','Austin Stanton'),
('Sanford Mcclain','Kristie Harrell'),
('Sanford Mcclain','Austin Stanton')
*/

--find out who got the most votes?

--The election is conducted in a city and everyone can vote for one or more candidates, or choose not to
--vote at all. Each person has 1 vote so if they vote for multiple candidates, their vote gets equally split
--across these candidates. For example, if a person votes for 2 candidates, these candidates receive an
--equivalent of 0.5 vote each.
--Find out who got the most votes and won the election. Output the name of the candidate or multiple
--names in case of a tie. To avoid issues with a floating-point error you can round the number of votes
--received by a candidate to 3 decimal places.


with t1 as
(
select voters,
		candidate,
		(cast(1 as float)/count(*) over(partition by voters)) as vote_proportion
from election
)

select candidate, round(sum(vote_proportion),2) as total_votes
from t1
group by candidate
order by total_votes desc