--reset the running total on 11th of every month
with t1 as
(
select Order_Date
		,Profit
		,case when datepart(d,Order_Date) = 11 then 1
				else 0 end as flag
from 
(
select Order_Date	
		,Profit
from Sample_Superstore
where year(Order_Date) = '2016'
and month(Order_Date) <= 5
--order by Order_Date	asc
)a

),
t2 as 
(
select t1.*
		,sum(flag) over(order by Order_Date asc) as part
from t1
--order by Order_Date	
)

select t2.*
		,sum(Profit) over(partition by part order by Order_Date asc) as sum_reset_at_11th
from t2