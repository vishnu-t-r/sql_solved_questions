--Election Results

use int_ques;

/*
The election is conducted in a city and everyone can vote for one or more candidates, 
or choose not to vote at all. Each person has 1 vote so if they vote for multiple candidates, 
their vote gets equally split across these candidates. 

For example, if a person votes for 2 candidates, these candidates receive an equivalent of 0.5 vote each.
Find out who got the most votes and won the election. 

Output the name of the candidate or multiple names in case of a tie. 
To avoid issues with a floating-point error you can round the number of votes received by a candidate to 
3 decimal places.
*/

select * from election_result
order by voter asc;

with vote_split as(
select voter,
		candidate,
		cast(1.0/sum(1) over(partition by voter) as decimal(10,3)) as num_votes
from election_result
)
select candidate, sum(num_votes) as votes
from vote_split
where candidate is not null
group by candidate
order by votes desc;