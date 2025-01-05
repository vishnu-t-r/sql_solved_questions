use int_ques;

/*
Question - Find Customers with Consecutive Purchases

Write a query to identify customers who have made consecutive purchases on back-to-back days 
and where each purchase amount was above a specific threshold (e.g., $100). 
The goal is to find customers who have a pattern of frequent and significant purchases.
*/

/*
CREATE TABLE purchases_info (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    purchase_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO purchases_info (purchase_id, customer_id, purchase_date, amount) VALUES
(1, 101, '2024-11-01', 150),
(2, 101, '2024-11-02', 200),
(3, 101, '2024-11-05', 90),
(4, 101, '2024-11-06', 120),
(5, 102, '2024-11-01', 110),
(6, 102, '2024-11-02', 130),
(7, 102, '2024-11-03', 140),
(8, 103, '2024-11-01', 50),
(9, 103, '2024-11-04', 110),
(10, 104, '2024-11-02', 150),
(11, 104, '2024-11-03', 200),
(12, 104, '2024-12-01', 100),
(13, 104, '2024-12-02', 110);
*/

--result should contain customer_id, purchase_start_date, purchase_end_date, total_amount

select * from purchases_info
order by customer_id asc, purchase_date asc

with lead_purchase as(
select purchase_id,
		customer_id,
		purchase_date,
		amount,
		lead(purchase_date,1,null) over(partition by customer_id order by purchase_date asc) as lead_purchase_date,
		lead(amount,1,null) over(partition by customer_id order by purchase_date asc) as lead_purchase_amount,
		datediff(day,purchase_date,lead(purchase_date,1,null) over(partition by customer_id order by purchase_date asc)) as diff_date
from purchases_info
where amount > 100
), base_data as(
select distinct customer_id,
		min(purchase_date) over(partition by customer_id) as purchase_start_date,
		first_value(amount) over(partition by customer_id order by purchase_date asc) as purchase_amount,
		max(lead_purchase_date) over(partition by customer_id) as purchase_end_date,
		sum(lead_purchase_amount) over(partition by customer_id) as lead_purchase_amount
from lead_purchase
where diff_date = 1
)
select customer_id,
		purchase_start_date,
		purchase_end_date,
		(purchase_amount + lead_purchase_amount) as total_purchase_amount
from base_data;