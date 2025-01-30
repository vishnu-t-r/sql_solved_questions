use int_ques;

/*
Task: Write an SQL query to calculate the average subscription duration 
and the average amount paid per subscription for each customer. 
Additionally, identify customers who have a longest subscription gap between two consecutive subscriptions. 
The result should include:

	>customer_id
	>average_subscription_duration (in days)
	>average_amount_paid (average amount paid per subscription)
	>longest_gap_between_subscriptions (the longest gap in days between two consecutive subscriptions for each customer)

Requirements:
1.Calculate the average subscription duration as the difference between the start_date and end_date for each subscription.
2.Calculate the average amount paid as the average of the amount_paid column for each customer.
3.For each customer, find the longest gap between two consecutive subscriptions by 
	calculating the difference between the start_date of a current subscription 
	and the end_date of the previous subscription.
4.Only include customers who have at least two subscriptions.
5.Return the results ordered by longest_gap_between_subscriptions in descending order.

*/

/*
CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_id INT,
    start_date DATE,
    end_date DATE,
    amount_paid DECIMAL(10, 2)
);


INSERT INTO Subscriptions (subscription_id, customer_id, start_date, end_date, amount_paid) VALUES
(1, 101, '2023-01-01', '2023-03-01', 50.00),
(2, 101, '2023-04-01', '2023-06-01', 55.00),
(3, 101, '2023-08-01', '2023-10-01', 60.00),
(4, 102, '2023-01-15', '2023-04-15', 45.00),
(5, 102, '2023-05-01', '2023-08-01', 50.00),
(6, 102, '2023-09-01', '2023-12-01', 55.00),
(7, 103, '2023-02-01', '2023-04-01', 60.00),
(8, 103, '2023-05-01', '2023-07-01', 65.00),
(9, 103, '2023-08-01', '2023-10-01', 70.00),
(10, 104, '2023-03-01', '2023-05-01', 40.00),
(11, 104, '2023-06-01', '2023-08-01', 45.00),
(12, 104, '2023-09-01', '2023-11-01', 50.00);
*/

--select * from Subscriptions;

with t1 as(
select *,
		datediff(day,start_date,end_date) as duration,
		lag(end_date,1,null) over(partition by customer_id order by end_date asc) as pre_subs_end_date
from subscriptions
), t2 as(
select *,
		datediff(day,pre_subs_end_date,start_date) as subscription_gap
from t1
)
select customer_id, 
		avg(duration) as average_subscription_duration,
		avg(amount_paid) as average_amount_paid,
		max(subscription_gap) as longest_gap_between_subscriptions
from t2
group by customer_id
having count(subscription_id) > 2
order by longest_gap_between_subscriptions desc;