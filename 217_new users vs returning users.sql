use questions;

--You have a User_Logins table with user_id and login_date.

-- The Question: For each day, calculate how many users were "New" (first time ever logging in) vs. "Returning" 
-- (logged in at least once on a previous day).

/*
CREATE TABLE user_logins (
    login_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    login_date DATE
);

INSERT INTO user_logins (user_id, login_date) VALUES
(1, '2099-01-01'), -- User 1 is New
(2, '2099-01-01'), -- User 2 is New
(1, '2099-01-02'), -- User 1 is Returning
(3, '2099-01-02'), -- User 3 is New
(2, '2099-01-03'), -- User 2 is Returning
(3, '2099-01-03'), -- User 3 is Returning
(4, '2099-01-03'); -- User 4 is New
*/

--select * from user_logins;

--solution 1

with base as(
select user_id, login_date,
min(login_date) over(partition by user_id) as first_login_date
from user_logins
)
select login_date, 
sum(case when login_date = first_login_date then 1 else 0 end) as new_users,
sum(case when login_date <> first_login_date then 1 else 0 end) as returning_users
from base
group by login_date;

--solution 2

with first_login as(
select user_id, min(login_date) as first_login_date from user_logins
group by user_id
), base as(
select u.*, f.first_login_date
from user_logins as u
left join first_login  as f
on u.user_id = f.user_id
)
select login_date,
		sum(case when login_date = first_login_date then 1 else 0 end) as new_users,
		sum(case when login_date <> first_login_date then 1 else 0 end) as returning_users
from base
group by login_date;
