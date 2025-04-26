--Generate a report that shows all dates between 2099-01-01 and 2099-01-06,
--even if there's no sale on that day. Missing days should show Amount = 0.

use questions;

/*
CREATE TABLE Sales_Info (
    SaleDate DATE PRIMARY KEY,
    Amount INT
);

INSERT INTO Sales_Info (SaleDate, Amount) VALUES
('2099-01-01', 100),
('2099-01-03', 200),
('2099-01-06', 150);
*/

--select * from sales_info;

with dateseries as(
select saledate
from sales_info
where saledate = '2099-01-01'
union all
select dateadd(day,1,saledate) as saledate
from dateseries
where saledate < '2099-01-06'
)
select ds.*,
		coalesce(si.amount,0) as amount
from dateseries ds
left join sales_info si
on ds.saledate = si.saledate;