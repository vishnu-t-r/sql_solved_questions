use learn;

-- Question 1
-- How do you identify users who have logged into a platform for 3 consecutive days?

/*
CREATE TABLE user_logins (
    user_id INT,
    login_date DATE
);

-- DML
INSERT INTO user_logins (user_id, login_date) VALUES
(1, '2099-02-01'), (1, '2099-02-02'), (1, '2099-02-03'),
(2, '2099-02-01'), (2, '2099-02-03'), (3, '2099-02-05');
*/

with distinct_users as(
select distinct user_id, login_date from user_logins
), login as(
select user_id, login_date, lead(login_date, 2) over(partition by user_id order by login_date asc) as third_login_date 
from distinct_users)
select distinct user_id from login
where datediff(day, login_date, third_login_date) = 2;



