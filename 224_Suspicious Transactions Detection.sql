-- FinTech Case Study: Suspicious Transactions Detection

-- Business Problem - Banks and payment systems need to detect fraudulent behavior.

-- Requirement - If a user makes more than 3 transactions within 1 minute, flag it as suspicious.

use learn;

/*
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    transaction_time DATETIME
);


INSERT INTO transactions(transaction_id, user_id, amount, transaction_time) VALUES
(1, 101, 500.00, '2026-01-01 10:00:00'),
(2, 101, 200.00, '2026-01-01 10:00:20'),
(3, 101, 300.00, '2026-01-01 10:00:40'),
(4, 101, 150.00, '2026-01-01 10:00:50'), -- 🚨 suspicious (4 within 1 min)

(5, 102, 100.00, '2026-01-01 11:00:00'),
(6, 102, 200.00, '2026-01-01 11:05:00'),

(7, 103, 400.00, '2026-01-01 12:00:00'),
(8, 103, 500.00, '2026-01-01 12:00:30'),
(9, 103, 600.00, '2026-01-01 12:01:10'); -- ❌ not suspicious
*/

-- method 1
WITH transaction_base AS(
SELECT transaction_id,
		user_id,
		amount,
		transaction_time,
		-- 3rd prior transaction
		lag(transaction_time,3) 
		over(partition by user_id order by transaction_time asc) as previous_txn_3 
FROM transactions
),
Suspicious_Transactions AS(
SELECT transaction_id,
		user_id,
		amount,
		transaction_time,
		previous_txn_3,
		DATEDIFF(second,previous_txn_3,transaction_time) AS time_diff_one_to_four,
		CASE WHEN 
		DATEDIFF(second,previous_txn_3,transaction_time) <= 60 THEN 1
		ELSE 0 END AS suspicious_flag
FROM transaction_base
)
SELECT * 
FROM Suspicious_Transactions
WHERE suspicious_flag = 1;


