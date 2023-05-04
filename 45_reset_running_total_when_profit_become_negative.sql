--reset the running total when the running total profit become -ve

with t1 as
(
select *
		,case when total_profit >= 0 then total_profit
				when total_profit < 0 then 0
				end as nw_profit
from
(
select Order_Date	
		--,Profit
		,sum(Profit) total_profit
from Sample_Superstore
group by Order_Date
--order by Order_Date asc
)a
--order by Order_Date asc
),
t2 as
(
select * 
		,case when nw_profit = 0 then 1
			else 0 end as flag
from t1
--order by Order_Date asc
),
t3 as
(
select t2.*
		,sum(flag) over(order by Order_Date asc) as nw_partition
from t2
)

select t3.*
		,sum(nw_profit) over(partition by nw_partition order by Order_Date asc) as profit_reset
from t3
order by Order_Date asc