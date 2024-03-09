--Marketing Campaign Success [Advanced]

use int_ques;

/*
You have a table of in-app purchases by user. 
Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions 
for more in-app purchases. 
Find the number of users that made additional in-app purchases due to the success of the marketing campaign.


The marketing campaign doesn't start until one day after the initial in-app purchase 
so users that only made one or multiple purchases on the first day do not count, 
nor do we count users that over time purchase only the products they purchased on the first day.
*/


/*
create table marketing_campaign(
user_id int,
created_at datetime,
product_id int,
quantity int,
price int)

insert into marketing_campaign(user_id, created_at, product_id, quantity, price)
values(10,'2019-01-01',	101	,3,	55),
(10,'2019-01-02',	119	,5,	29),
(10,'2019-03-31',	111	,2,	149),
(11	,'2019-01-02',	105	,3	,234),
(11	,'2019-03-31',	120	,3	,99),
(12	,'2019-01-02',	112	,2	,200),
(12	,'2019-03-31',	110	,2	,299),
(13	,'2019-01-05',	113	,1	,67),
(13	,'2019-03-31',	118	,3	,35),
(14	,'2019-01-06',	109	,5	,199),
(14	,'2019-01-06',	107	,2	,27),
(14	,'2019-03-31',	112	,3	,200),
(15	,'2019-01-08',	105	,4	,234),
(15	,'2019-01-09',	110	,4	,299),
(25	,'2019-01-22',	114	,2	,248),
(25	,'2019-01-22',	115	,2	,72),
(25	,'2019-01-24',	114	,5	,248),
(26	,'2019-01-25',	115,	1,	72)
*/


/*
select * from marketing_campaign
order by user_id asc, created_at asc
*/
with t1 as
(
select user_id,
		created_at,
		product_id,
		rank() over(partition by user_id order by created_at asc) as date_rank,
		rank() over(partition by user_id, product_id order by created_at) as product_rank
from marketing_campaign
)

select count(distinct user_id) as cnt
from t1
where product_rank < 2 and date_rank <> 1
