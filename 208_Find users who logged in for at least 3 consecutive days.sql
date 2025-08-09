use questions;

-- Find users who logged in for at least 3 consecutive days.

/*
CREATE TABLE user_logins (
    user_id INT,
    login_date DATE
);

INSERT INTO user_logins VALUES
(1, '2099-01-01'), (1, '2099-01-02'), (1, '2099-01-03'), -- 3 consecutive days
(1, '2099-01-05'), -- Not consecutive
(2, '2099-01-01'), (2, '2099-01-03'), -- Gap (not consecutive)
(3, '2099-01-01'), (3, '2099-01-02'), (3, '2099-01-03'), (3, '2099-01-04'); -- 4 consecutive days
*/

--select * from user_logins;	

--Logic 1

with t1 as(
select user_id, login_date,
		lead(login_date,1,null) over(partition by user_id order by login_date asc) as cons_login_date		
from user_logins
), t2 as(
select user_id, login_date, cons_login_date,
		datediff(day,login_date,cons_login_date) as date_flag
from t1
), t3 as(
select user_id, login_date, cons_login_date, date_flag, (sum(date_flag) over(partition by user_id)+1) as cons_days
from t2
where date_flag = 1
)
select distinct user_id 
from t3
where cons_days >= 3;

--Logic 2

with t1 as(
select *,
		dateadd(day,-row_number() over(partition by user_id order by login_date asc),login_date) as date_grp
from user_logins
), t2 as(
select user_id, date_grp, count(*) as cons_days
from t1
group by user_id, date_grp
having count(*) >= 3
)
select distinct user_id
from t2;
