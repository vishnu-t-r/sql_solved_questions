/*
You are given a table of daily transactions for multiple users.

The task:

For each user:

 1. Calculate a running total of transaction amounts ordered by date
 2. Reset the running total to 0 whenever it exceeds 1000
 3. After reset, the next transaction should start a new running total sequence

Return: user_id, txn_date, amount, running_total_after_reset
*/
USE int_ques;

/*
CREATE TABLE transactions_rt (
    user_id INT,
    txn_date DATE,
    amount INT
);

INSERT INTO transactions_rt VALUES
(101, '2026-01-01', 400),
(101, '2026-01-02', 500),
(101, '2026-01-03', 300), -- reset here (400+500+300 = 1200)
(101, '2026-01-04', 200),
(101, '2026-01-05', 900), -- reset again

(102, '2026-01-01', 700),
(102, '2026-01-02', 400), -- reset here
(102, '2026-01-03', 200);
*/

/*
WITH rng_total AS(
SELECT * ,
		SUM(amount) OVER(PARTITION BY user_id ORDER BY txn_date) AS running_total
FROM transactions_rt
), t2 AS(
SELECT *,
	CASE WHEN running_total > 1000 THEN 1 ELSE 0 END AS flag
FROM rng_total
)
SELECT *,
	SUM(
FROM t2
*/


with t1 as(
select *,
		row_number() over(partition by user_id order by txn_date) as row_num
	--sum(amount) over(partition by user_id order by txn_date) as running_total
from transactions_rt
--where user_id = 101
), t2 as(
select *
from t1
where row_num = 1		

union all

select t1.user_id,
		t1.txn_date,
		CASE WHEN (t2.amount + t1.amount) < 1000 THEN (t2.amount + t1.amount)
		ELSE t1.amount END as amount,
		t1.row_num
from t2 join
t1 on t2.user_id = t1.user_id
and t2.row_num+1 = t1.row_num
--and t2.txn_date <= '2026-01-05'
)
select * from t2
order by user_id, txn_date
--OPTION (MAXRECURSION 0);