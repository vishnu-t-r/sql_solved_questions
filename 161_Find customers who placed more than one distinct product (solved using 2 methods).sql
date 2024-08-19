use sql_challenge;
/*
Write a SQL query to find customers who have placed orders for more than one distinct product.
*/

/*
CREATE TABLE orders_tab (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE
);


INSERT INTO orders_tab (order_id, customer_id, product_id, quantity, order_date)
VALUES(1, 101, 201, 2, '2024-08-01'),
(2, 101, 202, 1, '2024-08-05'),
(3, 102, 203, 1, '2024-08-03'),
(4, 103, 201, 1, '2024-08-02'),
(5, 103, 201, 1, '2024-08-06');
*/

select * from orders_tab;


select customer_id
from
(
select customer_id,
		count(distinct product_id) as products
from orders_tab
group by customer_id ) result
where products > 1


select customer_id
from orders_tab
group by customer_id
having count(distinct product_id) > 1