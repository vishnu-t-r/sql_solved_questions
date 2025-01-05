use int_ques;

/*
Question
Given a purchases table with the following columns: purchase_id, user_id, product_id, purchase_date, and amount, 
write a SQL query to find the top 2 products that generate the most revenue per unique user in the previous year.
*/

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    purchase_date DATE,
    amount DECIMAL(10, 2)
);

-- Sample data for last year purchases
INSERT INTO purchases (purchase_id, user_id, product_id, purchase_date, amount) VALUES
(1, 101, 201, '2023-12-10', 150.00),
(2, 102, 201, '2023-12-15', 200.00),
(3, 103, 202, '2023-12-20', 300.00),
(4, 101, 203, '2024-01-05', 120.00),
(5, 104, 202, '2024-01-12', 400.00),
(6, 105, 201, '2024-02-10', 250.00),
(7, 106, 203, '2024-03-11', 180.00),
(8, 102, 203, '2024-04-14', 150.00),
(9, 107, 202, '2024-04-20', 275.00),
(10, 108, 201, '2024-05-22', 220.00),
(11, 101, 202, '2024-06-05', 190.00),
(12, 109, 202, '2024-06-10', 350.00),
(13, 110, 203, '2024-07-01', 300.00),
(14, 102, 203, '2024-08-20', 130.00),
(15, 104, 201, '2024-09-25', 275.00);

select top 2 product_id, sum(amount) as total_amount,
			count(distinct user_id) as unique_users,
			sum(amount)/count(distinct user_id) as revenue_per_unique_user
from purchases
where purchase_date >= dateadd(year,-1,GETDATE())
group by product_id
order by revenue_per_unique_user desc


