--Monthly Percentage Revenue Difference

use int_ques;

/*
Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 
The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, 
and sorted from the beginning of the year to the end of the year.

The percentage change column will be populated from the 2nd month forward and can be calculated as 
((this month's revenue - last month's revenue) / last month's revenue)*100.
*/

--select top 10 * from sales_transactions;

with t1 as(
select convert(varchar(7),created_at, 120) as yymm, 
    sum(value) as value_current,
    lag(sum(value)) 
		over(order by convert(varchar(7),created_at, 120) asc ) as previous_month 
from sales_transactions
group by convert(varchar(7),created_at, 120)
)
select yymm as month,
    round(cast(((1.0*value_current-previous_month)/previous_month)*100 as float),2) as percentage_diff_round,
	convert(decimal(10,2),((1.0*value_current-previous_month)/previous_month)*100) as percentage_diff_convert
from t1


