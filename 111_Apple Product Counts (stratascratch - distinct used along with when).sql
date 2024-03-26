--Apple Product Counts

/*
Find the number of Apple product users and the number of total users with a device and group the counts by language. 
Assume Apple products are only MacBook-Pro, iPhone 5s, and iPad-air. 
Output the language along with the total number of Apple users and users with any device. 
Order your results based on the number of total users in descending order.
*/

use int_ques;

--tables
select * from playbook_events
select * from playbook_users



--Method 1 (long query)

with t1 as
(
select pu.language,
        count(distinct pe.user_id) as n_total_users
from 
playbook_events pe left join playbook_users pu
on pe.user_id = pu.user_id
group by pu.language
--order by n_total_users desc
),
t2 as
(
select pu.language,
        count(distinct pe.user_id) as n_apple_users
from 
playbook_events pe left join playbook_users pu
on pe.user_id = pu.user_id
where pe.device in ('macbook pro', 'iphone 5s', 'ipad air')
group by pu.language
)

select t1.language,
        isnull(t2.n_apple_users,0),
        t1.n_total_users
from t1 left join t2 on t1.language = t2.language
order by t1.n_total_users desc


--Method 2 (short query)

select pu.language,
		count(distinct case when pe.device in ('macbook pro', 'iphone 5s', 'ipad air')
				then pe.user_id else null end) as n_apple_users,
        count(distinct pe.user_id) as n_total_users
from 
playbook_events pe left join playbook_users pu
on pe.user_id = pu.user_id
group by pu.language
order by n_total_users desc