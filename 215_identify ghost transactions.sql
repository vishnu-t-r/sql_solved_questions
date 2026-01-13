use questions;

/*

This is the specific condition that makes the question "Senior Level." 
We only consider it a "Ghost Duplicate" if it happens within a 60-second window of the previous transaction.

1. If it's under 60 seconds: We assume it's a system error (a "Ghost") and we discard it.

2. If it's over 60 seconds: We assume the user intentionally bought the same item again or made a second payment (a "Legit Repeat")
and we keep it.
*/

/*
-- Create the Transactions table
CREATE TABLE StoreTransactions (
    txn_id INT PRIMARY KEY,
    user_id INT,
    txn_time DATETIME2,
    amount DECIMAL(10, 2)
);

-- Insert sample records
INSERT INTO StoreTransactions (txn_id, user_id, txn_time, amount) VALUES
(501, 10, '2099-01-12 10:00:00', 25.00),
(502, 10, '2099-01-12 10:00:02', 25.00), -- GHOST: Same user/amt, 2s later
(503, 11, '2099-01-12 10:05:00', 50.00),
(504, 10, '2099-01-12 11:00:00', 25.00), -- LEGIT: Same user/amt, 1hr later
(505, 12, '2099-01-12 10:10:00', 15.00),
(506, 12, '2099-01-12 10:10:01', 15.00); -- GHOST: Same user/amt, 1s later

*/
with threshold as(
select txn_id,
		user_id,
		txn_time,
		amount,
		-- get the timestamp of the previous identical transaction
		lag(txn_time) over(partition by user_id, amount
		order by txn_time) as prev_txn_time
from StoreTransactions
)
select txn_id,
		user_id,
		txn_time,
		amount
from threshold
where prev_txn_time is null
or datediff(second, prev_txn_time, txn_time) > 60;

