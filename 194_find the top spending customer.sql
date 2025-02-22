/*
Question

You are given a customer_transactions table that records purchases made by customers. 
Write an SQL query to find the top spending customer for each month along with their total monthly spending. 
If multiple customers have the highest spending in a month, return all of them.
*/

use int_ques;

/*
CREATE TABLE customers_transaction (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO customers_transaction (transaction_id, customer_id, transaction_date, amount) VALUES
(501, 1, '2099-01-10', 500),
(502, 2, '2099-01-15', 1200),
(503, 1, '2099-01-20', 700),
(504, 3, '2099-02-05', 1300),
(505, 2, '2099-02-15', 800),
(506, 3, '2099-02-25', 900),
(507, 4, '2099-03-10', 650),
(508, 2, '2099-03-20', 1400),
(509, 4, '2099-04-05', 1100),
(510, 3, '2099-04-15', 750);
*/

--select * from customers_transaction;

with t1 as(
select customer_id,
		transaction_date,
		concat(year(transaction_date),'-',month(transaction_date)) as purchase_month,
		amount
from customers_transaction
), t2 as(
select purchase_month,customer_id,
		sum(amount) as monthly_spending
from t1
group by purchase_month, customer_id
), t3 as(
select *,
		rank() over(partition by purchase_month order by monthly_spending desc) as flag
from t2
)
select purchase_month, customer_id, monthly_spending
from t3
where flag = 1;
