/*
Find the monthly retention rate of users for each account separately for Dec 2020 and Jan 2021. 
Retention rate is the percentage of active users an account retains over a given period of time. 
In this case, assume the user is retained if he/she stays with the app in any future months. 
For example, if a user was active in Dec 2020 and has activity in any future month, consider them retained for Dec. 
You can assume all accounts are present in Dec 2020 and Jan 2021. 
Your output should have the account ID and the Jan 2021 retention rate divided by Dec 2020 retention rate.
*/
use int_ques;

/*
create table sf_events(
date date,
account_id varchar(20),
user_id varchar(20)
)


insert into sf_events(date,account_id,user_id)
values('2021-01-01','A1','U1'),
('2021-01-01','A1','U2'),
('2021-01-06','A1','U3'),
('2021-01-02','A1','U1'),
('2020-12-24','A1','U2'),
('2020-12-08','A1','U1'),
('2020-12-09','A1','U1'),
('2021-01-10','A2','U4'),
('2021-01-11','A2','U4'),
('2021-01-12','A2','U4'),
('2021-01-15','A2','U5'),
('2020-12-17','A2','U4'),
('2020-12-25','A3','U6'),
('2020-12-25','A3','U6'),
('2020-12-25','A3','U6'),
('2020-12-06','A3','U7'),
('2020-12-06','A3','U6'),
('2021-01-14','A3','U6'),
('2021-02-07','A1','U1'),
('2021-02-10','A1','U2'),
('2021-02-01','A2','U4'),
('2021-02-01','A2','U5'),
('2020-12-05','A1','U8')
*/

--Soluton 1

--distinct accounts
with accounts as
(select distinct account_id
from sf_events),
--active users in dec2020
active_users_dec as
(select account_id, user_id
from sf_events
where year(date) = 2020 and month(date) = 12
group by account_id, user_id
),
--retained users from dec2020
retained_users_dec as
(select account_id, user_id
from sf_events
where date >= '2021-01-01'
group by account_id, user_id),
--percentage retained users from dec2020
dec_retained_percent as
(select active_users_dec.account_id, --count(active_users_dec.user_id) as new_users,
--count(retained_users_dec.user_id) as retained_user,
count(retained_users_dec.user_id)/count(active_users_dec.user_id) as retained_percent_dec
from active_users_dec left join retained_users_dec
on active_users_dec.account_id = retained_users_dec.account_id
group by active_users_dec.account_id
),
------------------jan2021
--active users in jan2021
active_users_jan as
(select account_id, user_id
from sf_events
where year(date) = 2021 and month(date) = 01
group by account_id, user_id
),
--retained users from jan2021
retained_users_jan as
(select account_id, user_id
from sf_events
where date > '2021-01-31'
group by account_id, user_id),
--percentage retained users from jan2021
jan_retained_percent as
(select active_users_jan.account_id, --count(active_users_jan.user_id) as new_users,
--count(retained_users_jan.user_id) as retained_user,
count(retained_users_jan.user_id)/count(active_users_jan.user_id) as retained_percent_jan
from active_users_jan left join retained_users_jan
on active_users_jan.account_id = retained_users_jan.account_id
group by active_users_jan.account_id
),
retained_percent as
(select jan_retained_percent.account_id,
        jan_retained_percent.retained_percent_jan,
        dec_retained_percent.retained_percent_dec,
     (retained_percent_jan/retained_percent_dec) as retention
from jan_retained_percent left join dec_retained_percent on jan_retained_percent.account_id = dec_retained_percent.account_id)
select * from retained_percent


--Solution 2
	--this is recommended solution by stratascratch, but wrong
	--https://platform.stratascratch.com/coding/2053-retention-rate/official-solution?code_type=5
	--read the explaination (wrong explaination in platform)

select t1.account_id,t1.jan,
t2.dec,
t1.jan/t2.dec retention from
(select  account_id, count( user_id)jan from sf_events
where user_id in(
Select user_id from sf_events where year(date)='2021'and month(date)='1'
)
group by  account_id)t1
left join(
select  account_id, count( user_id)dec from sf_events
where user_id in(
Select user_id from sf_events where year(date)='2020'and month(date)='12'
)
group by  account_id
)t2  ON t1.account_id = t2.account_id
