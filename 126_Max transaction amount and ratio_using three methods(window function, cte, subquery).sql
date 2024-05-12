--Display max transaction amount and ratio
--solve using 3 methods

use int_ques;

/*
Transaction table has four columns CustomerID, TransactionID, TransactionAmount, and TransactionDate.
User has to display all there fields along with maximum Transaction Amount for each CustomerID and
Ratio of Transaction Amount and maximum transaction amount for each transaction.
*/

/*
create table transaction_tab(
CustomerID int,
TransactionID int,
TransactionAmount int,
TransactionDate date
)

insert into transaction_tab(CustomerID,TransactionID,TransactionAmount,TransactionDate)
values(1001,2001,10100,'2024-04-25'),
(1001,2002,25000,'2024-04-25'),
(1001,2003,80000,'2024-04-25'),
(1001,2104,20000,'2024-04-25'),
(1002,3001,8000,'2024-04-25'),
(1002,3002,15000,'2024-04-25'),
(1002,3003,20000,'2024-04-25'),
(1004,4001,20000,'2024-04-25'),
(1004,4002,25000,'2024-04-25'),
(1004,4003,50000,'2024-04-25')
*/

--select * from transaction_tab;

--Method 1 
--Using Max as a window function
select CustomerID,
		TransactionID,
		TransactionAmount,
		max(TransactionAmount) over(partition by CustomerID) as Max_Customer_TxnAmount,
		cast(1.0*TransactionAmount/max(TransactionAmount) over(partition by CustomerID) as decimal(10,3)) as Ratio
from transaction_tab;

--Method 2
--using CTE
with max_txn_amount as
(
select CustomerID, max(TransactionAmount) as Max_Amount
from transaction_tab
group by CustomerID
)
select t1.*,
		t2.Max_Amount as Max_Customer_TxnAmount,
		cast(1.0*t1.TransactionAmount/t2.Max_Amount as decimal(10,2)) as Ratio
from transaction_tab t1 left join max_txn_amount t2
on t1.CustomerID = t2.CustomerID;

--Method 3
--Using sub query
select t1.*,
		t2.Max_Amount as Max_Customer_TxnAmount,
		cast(1.0*t1.TransactionAmount/t2.Max_Amount as decimal(10,2)) as Ratio
from transaction_tab t1
left join 
(
select CustomerID, max(TransactionAmount) as Max_Amount
from transaction_tab
group by CustomerID
) t2
on t1.CustomerID = t2.CustomerID;
