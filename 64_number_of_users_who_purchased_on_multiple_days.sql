--Given a transaction table that consists of transaction_id, user_id, transaction_date, product_id, and quantity. 
--We need to query the number of users who purchased products on multiple days
--(Note that a given user can purchase multiple products on a single day).

use int_ques;
/*
create table transactions(
transaction_id int not null, 
user_id varchar(25),
transaction_date date, 
product_id varchar(25),
quantity int
)

insert into transactions(transaction_id, user_id, transaction_date, product_id, quantity)
values(1,'U1','2020-12-16','P1',2),
(2,'U2','2020-12-16','P2',1),
(3,'U1','2020-12-16','P3',1),
(4,'U4','2020-12-16','P4',4),
(5,'U2','2020-12-17','P5',3),
(6,'U2','2020-12-17','P6',2),
(7,'U4','2020-12-18','P7',1),
(8,'U3','2020-12-19','P8',2),
(9,'U3','2020-12-19','P9',8)
*/

select * from transactions

--method 1
select user_id,count(1) as num_transactions
from(
select distinct user_id,transaction_date
from transactions
)a
group by user_id
having count(1) > 1


--method 2

select count(1) as user_count
from (
select user_id
from transactions
group by user_id
having count(distinct transaction_date) > 1
) a
