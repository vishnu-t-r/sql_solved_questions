use sql_challenge;

/*
Write SQL to find all couples of trade for same stock that happened in the
range of 10 seconds and having price difference by more than 10 %. Output result should also list the
percentage of price difference between the 2 trade
*/

/*
create table trade_tbl(
Trade_Id varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price int)

insert into trade_tbl(Trade_Id, Trade_Timestamp, Trade_Stock, Quantity, Price)
values('TRADE1','10:01:05.0000000','Apple',100,20),
('TRADE2','10:01:06.0000000','Apple',20,15),
('TRADE3','10:01:08.0000000','Apple',150,30),
('TRADE4','10:01:09.0000000','Apple',300,32),
('TRADE5','10:10:00.0000000','Apple',-100,19),
('TRADE6','10:10:01.0000000','Apple',-300,19)
*/

--select * from trade_tbl;
with t1 as
(
select t1.trade_id as trade_1,
		t1.price as price_1,
		t2.trade_id as trade_2,
		t2.price as price_2,
		datediff(second,t1.trade_timestamp,t2.trade_timestamp) as diff_sec
from trade_tbl t1 cross join trade_tbl t2
where t1.trade_id <> t2.trade_id
and abs(datediff(second,t1.trade_timestamp,t2.trade_timestamp)) <= 10
and t1.trade_id < t2.trade_id
),
t2 as(
select trade_1,
		price_1,
		trade_2,
		price_2,
		diff_sec,
		(1.0*(price_2-price_1)/price_1)*100 as price_diff
from t1
--order by trade_1 asc
)
select trade_1,
		trade_2,
		abs(cast(price_diff as int)) as price_diff
		from t2
where abs(price_diff) >= 10

