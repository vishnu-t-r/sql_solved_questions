--calculate ytd and mtd totals

use [AdventureWorks_db];

--select * from [Sales].[SalesOrderHeader]

select SalesOrderID,
	OrderDate,
	TotalDue,
	sum(TotalDue) over(partition by year(OrderDate)
						order by OrderDate rows between unbounded preceding and current row) as YTD_sales,
	sum(TotalDue) over(partition by year(OrderDate), month(OrderDate)
						order by OrderDate rows between unbounded preceding and current row) as MTD_sales
from [Sales].[SalesOrderHeader]


