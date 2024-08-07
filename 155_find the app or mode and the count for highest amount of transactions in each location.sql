use sql_challenge;

/*
Question :- ABC Bank is trying to find their customers transaction mode. Customers
are using different apps such as Gpay, PhonePe, Paytm etc along with offline transactions. 
Bank wants to know which mode/app is used for highest amount transaction in each location.

1) Write a SQL query to find the app/mode and the count for highest amount of transactions in each location

2) Write a SQL query to find the app/mode which has been used maximum for a given location
*/

/*
Create Table Customer(
Customer_id  int,
Cus_name  Varchar(30),
Age  int,
Gender  Varchar(10),
App  Varchar(30) )

Insert into Customer Values(1,'Amelia',23,'Female','gpay')
Insert into Customer Values(2,'William',16,'Male','phonepay')
Insert into Customer Values(3,'James',18,'Male','paytm')
Insert into Customer Values(4,'David',24,'Male','paytm')
Insert into Customer Values(5,'Ava',21,'Female','gpay')
Insert into Customer Values(6,'Sophia',31,'Female','paytm')
Insert into Customer Values(7,'Oliver',23,'Male','gpay')
Insert into Customer Values(8,'Harry',29,'Male',NULL)
Insert into Customer Values(9,'Issac',16,'Male','gpay')
Insert into Customer Values(10,'Jack',22,'Male','phonepay')

Create Table Transaction_Tbls (
Loc_name Varchar(30),
Loc_id int,
Cus_id int,
Amount_paid Bigint,
Trans_id int)

Insert into Transaction_Tbls Values ('Florida',100,1,78899,1000)
Insert into Transaction_Tbls Values ('Florida',100,2,55678,1001)
Insert into Transaction_Tbls Values ('Florida',100,3,27788,1002)
Insert into Transaction_Tbls Values ('Florida',100,4,65886,1003)
Insert into Transaction_Tbls Values ('Alaska',101,5,57757,1004)
Insert into Transaction_Tbls Values ('Alaska',101,6,34676,1005)
Insert into Transaction_Tbls Values ('Alaska',101,7,66837,1006)
Insert into Transaction_Tbls Values ('Alaska',101,8,77633,1007)
Insert into Transaction_Tbls Values ('Texas',102,9,98766,1008)
Insert into Transaction_Tbls Values ('Texas',102,10,45335,1009)
*/

--select * from customer;
--select * from transaction_tbls;

--Question 1

with txn as (
select *,
	dense_rank() over(partition by loc_name order by amount_paid desc) as rnk
from transaction_tbls
)
select coalesce(app, 'cash') as mode, count(*) as num_transaction 
from txn inner join customer c
on txn.cus_id = c.customer_id
where rnk = 1
group by app




--Question 2

with txn_customer as
(
select loc_name,
		customer_id,
		app
from transaction_tbls txn left join customer c
on txn.cus_id = c.customer_id 
), 
loc_mode as(
select loc_name, coalesce(app,'cash') as mode, count(*) as n
from txn_customer
group by loc_name, app
), 
rnk_cte as (
select *,
		dense_rank() over(partition by loc_name order by n desc) as rnk
from loc_mode )
select loc_name,
		mode,
		n
from rnk_cte where rnk = 1

