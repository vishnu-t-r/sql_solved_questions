use int_ques;

/*
Question
Given a table named Customer_Transactions containing transaction records, 
Write a query to find customers who made more than 3 transactions within any 1-hour window.
*/

/*
CREATE TABLE Customer_Transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    transaction_time datetime NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Customer_Transactions (transaction_id, customer_id, transaction_time, amount) 
VALUES
(1, 101, '2024-10-01 05:30:00', 4000.00),
(2, 101, '2024-10-01 08:30:00', 15000.00),
(3, 101, '2024-10-01 08:45:00', 6000.00),
(4, 102, '2024-10-01 09:00:00', 7000.00),
(5, 101, '2024-10-01 09:15:00', 4500.00),
(6, 103, '2024-10-01 10:00:00', 11000.00),
(7, 101, '2024-10-01 09:45:00', 4800.00),
(8, 102, '2024-10-01 10:30:00', 20000.00),
(9, 101, '2024-10-01 09:50:00', 4900.00),
(10, 101, '2024-10-01 22:30:00', 5200.00);
*/

select * from Customer_Transactions
where customer_id = 101
order by transaction_id asc;

with frequent_txn_info as(
select  ct1.customer_id,
		ct1.transaction_id as transaction_1,
		ct2.transaction_id as transaction_2,
		ct1.transaction_time as transaction_ts1,
		ct2.transaction_time as transaction_ts2,
		datediff(minute,ct1.transaction_time,ct2.transaction_time) as interval
from Customer_Transactions ct1
cross apply
Customer_Transactions ct2
where ct1.customer_id = ct2.customer_id
and ct1.transaction_time <= ct2.transaction_time
and ct1.transaction_id <> ct2.transaction_id
--order by ct1.customer_id asc, ct1.transaction_id asc
),
frequent_txn as(
select customer_id,
		count(*) over(partition by customer_id,transaction_1) as freq_txn
from frequent_txn_info
where interval <= 60
--order by customer_id asc, transaction_1 asc
)
select distinct customer_id
from frequent_txn
where freq_txn >= 2;

