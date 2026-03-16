/*

Business Scenario - Rolling Order Spike Detection

A food delivery platform similar to Swiggy or Zomato wants to detect unusual spikes in restaurant orders.

The analytics team wants to monitor this daily, rather than comparing just two fixed weeks.
For each restaurant and each day, they want to analyze:

	> Orders placed in the last 7 days (including the current day)
	> Orders placed in the previous 7 days before that

orders_last_7_days (Total number of orders placed in the last 7 days including the current date)
orders_previous_7_days (Total number of orders placed in the 7 days before the last 7-day window)

Requirement -> orders_last_7_days >= 2 * orders_previous_7_days

Use Case:

	> This helps the company identify restaurants that suddenly go viral or trend on the platform.
	
Use Case:

	> Growth Monitoring
	> Early Detection of Operational Risk
*/

use learn;

/*

CREATE TABLE restaurant_orders (
    order_id INT PRIMARY KEY,
    restaurant_id INT,
    customer_id INT,
    order_date DATE
);

INSERT INTO restaurant_orders (order_id, restaurant_id, customer_id, order_date) VALUES
-- Restaurant 101 (spike in last 7 days)
(1,101,201,'2026-03-03'),
(2,101,202,'2026-03-04'),
(3,101,203,'2026-03-05'),

(4,101,205,'2026-03-10'),
(5,101,206,'2026-03-11'),
(6,101,207,'2026-03-12'),
(7,101,208,'2026-03-13'),
(8,101,209,'2026-03-14'),
(9,101,210,'2026-03-15'),
(10,101,221,'2026-03-16'),

-- Restaurant 102 (stable orders)
(11,102,211,'2026-03-04'),
(12,102,212,'2026-03-05'),
(13,102,213,'2026-03-06'),
(14,102,214,'2026-03-07'),
(15,102,215,'2026-03-08'),

(16,102,216,'2026-03-12'),
(17,102,217,'2026-03-14'),

-- Restaurant 103 (declining orders)
(18,103,218,'2026-03-03'),
(19,103,219,'2026-03-04'),
(20,103,220,'2026-03-05'),
(21,103,221,'2026-03-06'),

(22,103,222,'2026-03-12'),
(23,103,223,'2026-03-13');

*/

SELECT * FROM restaurant_orders;

WITH data_7_days AS(
SELECT *, 
		CAST(GETDATE() AS DATE) AS date_today,
		DATEADD(day,-7,CAST(GETDATE() AS DATE)) AS date_7_days_ago
FROM restaurant_orders
WHERE 1 = 1
-- restaurant_id = 101
AND order_date > DATEADD(day,-7,CAST(GETDATE() AS DATE))
), 
data_previous_7_14_days AS(
SELECT *,
		DATEADD(day,-7,CAST(GETDATE() AS DATE)) AS date_7_days_ago,
		DATEADD(day,-14,CAST(GETDATE() AS DATE)) AS date_14_days_ago
FROM restaurant_orders
WHERE 1 = 1
--restaurant_id = 101
AND order_date <= DATEADD(day,-7,CAST(GETDATE() AS DATE)) 
AND order_date > DATEADD(day,-14,CAST(GETDATE() AS DATE))
),
orders_7_days AS(
SELECT  restaurant_id,
		COUNT(DISTINCT order_id) AS order_count
FROM data_7_days
GROUP BY restaurant_id
),
orders_previous_7_14_days AS(
SELECT  restaurant_id,
		COUNT(DISTINCT order_id) AS order_count
FROM data_previous_7_14_days
GROUP BY restaurant_id
), 
base AS(
SELECT A.restaurant_id,
		A.order_count AS orders_last_7_days,
		B.order_count AS orders_previous_7_days
FROM orders_7_days AS A
LEFT JOIN orders_previous_7_14_days AS B
ON A.restaurant_id = B.restaurant_id
)
-- orders_last_7_days >= 2 * orders_previous_7_days
SELECT * FROM base
WHERE orders_last_7_days >= 2 * orders_previous_7_days;







-- SELECT CAST(GETDATE() AS DATE) AS _col_current_date;
