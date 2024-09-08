use int_ques;


/*
Question:- You have two tables: order_details and customers.

Write a SQL query to find the top 3 customers who spent the most in their first month of making an order. 
The result should include the customer_id, customer_name, 
and the total amount spent by the customer in their first month.

*/

/*
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    signup_date DATE
);

CREATE TABLE order_details (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name, signup_date) VALUES
(1, 'Alice', '2099-01-15'),
(2, 'Bob', '2099-02-20'),
(3, 'Charlie', '2099-01-25'),
(4, 'Diana', '2099-03-10'),
(5, 'Eve', '2099-01-05');

INSERT INTO order_details (order_id, customer_id, order_date, order_amount) VALUES
(101, 1, '2099-01-20', 150.00),
(102, 1, '2099-01-25', 200.00),
(103, 1, '2099-02-05', 300.00),
(104, 2, '2099-02-22', 250.00),
(105, 2, '2099-02-25', 100.00),
(106, 2, '2099-03-01', 150.00),
(107, 3, '2099-01-30', 200.00),
(108, 3, '2099-02-10', 100.00),
(109, 4, '2099-03-15', 300.00),
(110, 4, '2099-03-18', 200.00),
(111, 4, '2099-04-01', 400.00),
(112, 5, '2099-01-10', 500.00),
(113, 5, '2099-01-15', 300.00),
(114, 5, '2099-02-01', 200.00);
*/

select * from order_details;

select * from customers;

--select *,datename(month,signup_date),datename(year,signup_date) from customers;


with first_order_date as(
select customer_id, concat(datename(month,first_order_date),'-', datename(year,first_order_date)) as month_year
from
(
select customer_id, min(order_date) as first_order_date
from order_details
group by customer_id)a
), max_amount_spend as(
select top 3 o.customer_id, sum(order_amount) as total_amount
from  order_details o
inner join first_order_date f
on o.customer_id = f.customer_id
and f.month_year = concat(datename(month,o.order_date),'-', datename(year,o.order_date))
group by o.customer_id
order by total_amount desc)

select m.*,c.customer_name
from max_amount_spend m
left join customers c
on m.customer_id = c.customer_id
