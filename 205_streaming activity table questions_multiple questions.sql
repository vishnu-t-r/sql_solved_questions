--Solve the questions based on Streaming activity table

--Watch Time per User
--1.Calculate the total watch time for each user.

--Most Watched Movie
--2.Which movie has been watched by the highest number of unique users?

--Average Watch Duration by Genre
--3.What is the average watch_duration_min for each genre?

--Repeated Viewers
--4.Which users have watched more than one movie?

--Most Consistently Watched Movie
--5.Which movie was watched on the most different days?

use questions;

CREATE TABLE streaming_activity (
    activity_id INT PRIMARY KEY,
    user_id INT,
    movie_title VARCHAR(100),
    genre VARCHAR(50),
    watch_date DATE,
    watch_duration_min INT
);

INSERT INTO streaming_activity (activity_id, user_id, movie_title, genre, watch_date, watch_duration_min) VALUES
(1, 201, 'The Silent Storm', 'Drama',    '2099-03-01', 120),
(2, 202, 'Space Legacy',     'Sci-Fi',   '2099-03-01', 95),
(3, 203, 'Laugh Out Loud',   'Comedy',   '2099-03-02', 60),
(4, 201, 'The Final Stand',  'Action',   '2099-03-02', 110),
(5, 204, 'Laugh Out Loud',   'Comedy',   '2099-03-03', 65),
(6, 202, 'The Silent Storm', 'Drama',    '2099-03-03', 125);

--Watch Time per User
--1.Calculate the total watch time for each user.

select user_id,
		sum(watch_duration_min) as total_watch_time
from streaming_activity
group by user_id;

--Most Watched Movie
--2.Which movie has been watched by the highest number of unique users?

select * from streaming_activity;

with t1 as(
select movie_title, count(distinct user_id) as unique_users
from streaming_activity
group by movie_title
), t2 as(
select *,
		dense_rank() over(order by unique_users desc) as flag
from t1
)
select * from t2
where flag = 1;


--Average Watch Duration by Genre
--3.What is the average watch_duration_min for each genre?

select genre,
		avg(watch_duration_min) as avg_watch_duration_min
from streaming_activity
group by genre

--Repeated Viewers
--4.Which users have watched more than one movie?

select user_id,
		count(distinct movie_title) as movie_count
from streaming_activity
group by user_id
having count(distinct movie_title) > 1;

--Most Consistently Watched Movie
--5.Which movie was watched on the most different days?

with t1 as(
select movie_title, count(distinct watch_date) as watch_date_count 
from streaming_activity
group by movie_title
), t2 as(
select *,
	dense_rank() over(order by watch_date_count desc) as flag
from t1
)
select * from t2
where flag = 1;