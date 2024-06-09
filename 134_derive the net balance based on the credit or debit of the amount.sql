use sql_challenge;

--Question Statements :- Write SQL to derive the Net_Balance column based on
--Credit/Debit of the Amount

/*
create table transactions(
TranDate datetime,
TranID varchar(20), 
TranType varchar(20),
Amount int)

insert into transactions(TranDate, TranID, TranType, Amount)
values('2099-05-12 05:29:44.120','A10001','Credit',50000),
('2099-05-13 10:30:20.100','B10001','Debit',10000),
('2099-05-13 11:27:50.130','B10002','Credit',20000),
('2099-05-14 08:35:30.123','C10001','Debit',5000),
('2099-05-14 09:43:51.100','C10002','Debit',5000),
('2099-05-15 05:51:11.117','D10001','Credit',30000)
*/


--select * from transactions;

select [TranDate], 
		[TranID], 
		[TranType], 
		[Amount],
		sum(case when TranType = 'Credit' then Amount
				when TranType = 'Debit' then -Amount end) over(order by TranDate asc) as Net_Balance
from transactions




