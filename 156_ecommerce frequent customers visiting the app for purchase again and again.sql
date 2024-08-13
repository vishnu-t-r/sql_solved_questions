use sql_challenge;

/*
Question :- Ecommerce company is trying to identify returning active users. 
A returning active user is a user that has made a second purchase within 7 days of any other of their purchases.
Write a SQL query to display the list of Userld of these returning active users.
*/

--Table Script :-

/*
Create Table Transactions_Ecomm (
Id int,
userId int,
Item Varchar(20),
CreatedAt Date,
Revenue int
)

Insert into Transactions_Ecomm Values (1,109,'milk','2099-03-03',123)
Insert into Transactions_Ecomm Values (2,103,'bread','2099-03-29',862)
Insert into Transactions_Ecomm Values (3,128,'bread','2099-03-04',112)
Insert into Transactions_Ecomm Values (4,128,'biscuit','2099-03-24',160)
Insert into Transactions_Ecomm Values (5,100,'banana','2099-03-18',599)
Insert into Transactions_Ecomm Values (6,103,'milk','2099-03-31',290)
Insert into Transactions_Ecomm Values (7,102,'bread','2099-03-25',325)
Insert into Transactions_Ecomm Values (8,109,'bread','2099-03-22',432)
Insert into Transactions_Ecomm Values (9,101,'milk','2099-03-01',449)
Insert into Transactions_Ecomm Values (10,100,'milk','2099-03-29',410)
Insert into Transactions_Ecomm Values (11,129,'milk','2099-03-02',771)
Insert into Transactions_Ecomm Values (12,104,'biscuit','2099-03-31',957)
Insert into Transactions_Ecomm Values (13,110,'bread','2099-03-13',210)
Insert into Transactions_Ecomm Values (14,128,'milk','2099-03-28',498)
Insert into Transactions_Ecomm Values (15,109,'bread','2099-03-02',362)
Insert into Transactions_Ecomm Values (16,110,'bread','2099-03-13',262)
Insert into Transactions_Ecomm Values (17,105,'bread','2099-03-21',562)
Insert into Transactions_Ecomm Values (18,101,'milk','2099-03-26',740)
Insert into Transactions_Ecomm Values (19,100,'banana','2099-03-13',175)
Insert into Transactions_Ecomm Values (20,105,'banana','2099-03-05',815)
Insert into Transactions_Ecomm Values (21,129,'milk','2099-03-02',489)
Insert into Transactions_Ecomm Values (22,105,'banana','2099-03-09',972)
Insert into Transactions_Ecomm Values (23,107,'bread','2099-03-01',701)
Insert into Transactions_Ecomm Values (24,100,'bread','2099-03-07',410)
Insert into Transactions_Ecomm Values (25,110,'bread','2099-03-27',225)

*/

--using window function
with next_purchase as(
select id,
		userid, item,
		createdat,
		revenue,
		lead(createdat, 1, null) over(partition by userid order by createdat asc) as next_purchase_date  
from Transactions_Ecomm
--order by userid asc, createdat asc
), frequent_customer as (
select *,
		datediff(day, createdat, next_purchase_date) as diff_flag
from next_purchase
where datediff(day, createdat, next_purchase_date) <= 7
)
select distinct userid  from frequent_customer
where diff_flag <> 0;


