use int_ques;

/*
Write a SQL query to display total number of matches played, matches won,
matches tied and matches lost for each team
*/

/*
create table match_result(
Team_1 varchar(20),
Team_2 varchar(20),
Result_won varchar(20)
)

insert into match_result(team_1, team_2, Result_won)
values('India','Australia','India'),
('India','England','England'),
('SouthAfrica','India','India'),
('Australia','England',NULL),
('England','SouthAfrica','SouthAfrica'),
('Australia','India','Australia')
*/

--select * from match_result;	

--Method 1

with t1 as(
select team_1,
		team_2,
		result_won,
		case when team_1 = result_won then 1 end as team_1_won,
		case when team_2 = result_won then 1 end as team_2_won,
		case when result_won is null then 1 end as tied_match
from match_result
),
team_1_result as(
select team_1, sum(team_1_won) as won_match, sum(team_2_won) as lost_match,
			sum(tied_match) as tied
from t1
group by team_1
),
team_2_result as(
select team_2, sum(team_2_won) as won_match, sum(team_1_won) as lost_match,
			sum(tied_match) as tied
from t1
group by team_2),
t3 as(
select * from team_1_result
union all
select * from team_2_result
),result as(
select team_1 as team, sum(won_match) as won_match,
						sum(lost_match) as lost_match,
						sum(tied) as tied
from t3
group by team_1
)
select *,
		isnull(won_match,0) + isnull(lost_match,0) + isnull(tied,0) as match_played
from result


--Method 2


with t1 as(
select team_1 as team, result_won as result
from match_result
union all
select team_2 as team, result_won as result
from match_result
)
select team,
		count(1) as match_count,
		sum(case when team = result then 1 end) as match_won,
		sum(case when result is null then 1 end) as tied_match,
		sum(case when team != result then 1 end) as lost_match		
from t1
group by team