use learn;

/*
Write a SQL query to:

	1. Identify customers who churned at least once.
	2. Among them, find customers who came back and placed another order after churn.
	3. For each such customer, return:
			> customer_id
			> first_churn_date
			> recovery_order_date
			> Number of days between churn and recovery
	Note: customer is considered churned if they have no orders for 90 consecutive days.
*/

/*
CREATE TABLE customer_orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT NOT NULL,
    order_date    DATE NOT NULL,
    amount        DECIMAL(10,2) NOT NULL
);
*/

/*
INSERT INTO customer_orders (order_id, customer_id, order_date, amount) VALUES
-- Customer 1: Churns once and recovers
(1, 101, '2023-01-01', 200.00),
(2, 101, '2023-01-15', 150.00),
(3, 101, '2023-02-01', 300.00),
(4, 101, '2023-06-10', 400.00),  -- Gap > 90 days → churn happened
(5, 101, '2023-06-25', 250.00),

-- Customer 2: Never churns
(6, 102, '2023-01-05', 100.00),
(7, 102, '2023-02-10', 200.00),
(8, 102, '2023-03-15', 300.00),
(9, 102, '2023-04-20', 150.00),

-- Customer 3: Churns but NEVER returns
(10, 103, '2023-01-01', 500.00),
(11, 103, '2023-01-10', 600.00),
(12, 103, '2023-05-20', 700.00),  -- Gap > 90 days → churn + recovery
(13, 103, '2023-12-01', 800.00),  -- Another large gap

-- Customer 4: Multiple churn cycles
(14, 104, '2023-01-01', 120.00),
(15, 104, '2023-04-05', 220.00),  -- Gap > 90 days → churn 1
(16, 104, '2023-08-10', 320.00),  -- Gap > 90 days → churn 2
(17, 104, '2023-08-20', 150.00),

-- Customer 5: Exactly 90-day gap (edge case)
(18, 105, '2023-01-01', 180.00),
(19, 105, '2023-04-01', 280.00);  -- Exactly 90 days difference
*/
with base as(
select customer_id, 
		order_date, 
		lag(order_date) over(partition by customer_id order by order_date asc) as previous_order_date
from 
customer_orders
), 
churned_customers as(
select customer_id, 
		order_date, 
		previous_order_date 
from 
base
where datediff(day,previous_order_date,order_date) > 90)
,first_customer_churn as(
select customer_id, 
		order_date, 
		previous_order_date, 
		row_number() over(partition by customer_id order by previous_order_date asc) as flag
from churned_customers)
select customer_id,
		previous_order_date as first_churn_date,
		order_date as recovery_date,
		datediff(day,previous_order_date,order_date) as num_day_churn_recovery
from first_customer_churn
where flag = 1