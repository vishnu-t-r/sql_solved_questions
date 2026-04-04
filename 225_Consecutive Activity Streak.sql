/*

You are working as a Data Analyst for a digital platform (e.g., a fitness or learning app).

The product team wants to identify highly engaged users — specifically, users who are active for at least 3 consecutive days.

	> A consecutive streak means a user has activity on continuous calendar days with no gaps
	> If even one day is missing, the streak breaks


Write an SQL query to: Find all users who have at least one streak of 3 or more consecutive days of activity?

*/


USE learn;

/*
CREATE TABLE user_activity (
    user_id INT,
    activity_date DATE
);

INSERT INTO user_activity (user_id, activity_date) VALUES
(1, '2026-01-01'),
(1, '2026-01-02'),
(1, '2026-01-04'),

(2, '2026-01-01'),
(2, '2026-01-03'),

(3, '2026-01-01'),
(3, '2026-01-02'),
(3, '2026-01-03'),

(4, '2026-01-05'),
(4, '2026-01-06'),
(4, '2026-01-07'),
(4, '2026-01-10'),

(5, '2026-02-01');

*/

WITH base AS(
SELECT * ,
	ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY activity_date ASC) AS row_id
FROM user_activity
),
group_user AS(
SELECT user_id,
	activity_date,
	row_id,
	DATEADD(day,-row_id,activity_date) AS window
FROM base
), 
streak AS(
SELECT user_id, 
		window,
		COUNT(*) AS streak_count
FROM group_user
GROUP BY user_id, window
)
SELECT DISTINCT user_id
FROM streak
WHERE streak_count >= 3;


