/*
You are working as a data analyst for an e-commerce company.

The business team wants to understand customer loyalty behavior.

Specifically, they are curious: Do customers stick to the first product they ever purchased?

Task: Find all customers who never ordered the same product again after their very first purchase.

Important Clarifications (this is where candidates get trapped):

	A customer may have multiple orders
	The first product is based on the earliest order_date
	If the same product appears again later, that customer should be excluded
	Even one repeat disqualifies the customer
	If they only ordered once → they should be included 
*/

USE int_ques;

/*
CREATE TABLE ecomm_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    product_id INT
);

INSERT INTO ecomm_orders (order_id, customer_id, order_date, product_id) VALUES
-- Customer 1 (repeats first product → exclude)
(1, 101, '2026-01-01', 10),
(2, 101, '2026-01-05', 20),
(3, 101, '2026-01-10', 10),

-- Customer 2 (never repeats → include)
(4, 102, '2026-01-02', 30),
(5, 102, '2026-01-06', 40),

-- Customer 3 (only one order → include)
(6, 103, '2026-01-03', 50),

-- Customer 4 (repeats immediately → exclude)
(7, 104, '2026-01-04', 60),
(8, 104, '2026-01-05', 60),

-- Customer 5 (multiple orders but no repeat → include)
(9, 105, '2026-01-01', 70),
(10, 105, '2026-01-02', 80),
(11, 105, '2026-01-03', 90);
*/

/*
-- this query will be first solution for most
WITH base AS(
SELECT *, 
		FIRST_VALUE(product_id) 
		OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS first_product_purchased,
		ROW_NUMBER() 
		OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS order_flag
FROM ecomm_orders
)
SELECT * 
FROM base
WHERE order_flag <> 1
AND product_id <> first_product_purchased
*/

-- Solution 1
WITH one_order AS
(
SELECT customer_id FROM ecomm_orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1
),
--SELECT * FROM one_order
multi_orders AS(
SELECT *,
		ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS order_num
FROM ecomm_orders
WHERE customer_id NOT IN (SELECT customer_id 
							FROM one_order)
),
mo_customer AS(
SELECT customer_id
FROM multi_orders AS t1
WHERE order_num = 1
AND NOT product_id = ANY (SELECT product_id 
							FROM multi_orders AS t2
							WHERE order_num <> 1
							AND t2.customer_id = t1.customer_id)
)
SELECT * FROM one_order
UNION ALL
SELECT * FROM mo_customer
ORDER BY customer_id ASC;

-- Solution 2
WITH ranked_orders AS(
SELECT *,
		FIRST_VALUE(product_id) OVER(PARTITION BY customer_id ORDER BY order_date) AS first_product
FROM ecomm_orders
)
SELECT customer_id
FROM ranked_orders
GROUP BY customer_id, product_id
HAVING COUNT(CASE WHEN product_id = first_product THEN 1 END) = 1;

