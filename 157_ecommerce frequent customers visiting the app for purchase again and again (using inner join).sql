use sql_challenge;


/*
Question :- Ecommerce company is trying to identify returning active users. 
A returning active user is a user that has made a second purchase within 7 days of any other of their purchases.
Write a SQL query to display the list of Userld of these returning active users.
*/

with active_customer as (
select t1.userId as user_1,
		t1.createdat as createdat_1,
		t2.userId as user_2,
		t2.createdat as createdat_2,
		datediff(day,t1.createdat,t2.createdat) as diff_date
from Transactions_Ecomm t1
inner join Transactions_Ecomm t2 
on t1.userId = t2.userId and abs(datediff(day,t1.createdat,t2.createdat)) <= 7 
--where abs(datediff(day,t1.createdat,t2.createdat)) <> 0
						
)
select distinct user_1
from active_customer
where abs(datediff(day,createdat_1,createdat_2)) <> 0

/*
select * from Transactions_Ecomm
--where userid in (110,129)
order by userid asc, createdat asc
*/

