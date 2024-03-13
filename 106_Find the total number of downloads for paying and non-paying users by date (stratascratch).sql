--Premium vs Freemium

/*
Find the total number of downloads for paying and non-paying users by date. 
Include only records where non-paying customers have more downloads than paying customers. 
The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.
*/

--tables

	--ms_user_dimension
	--ms_acc_dimension
	--ms_download_facts

use int_ques;

--export from csv
/*
select * from ms_user_dimension
select * from ms_acc_dimension
select * from ms_download_facts
*/

with t1 as(
select date, ms_download_facts.user_id, downloads, ms_acc_dimension.acc_id, paying_customer
from ms_download_facts left join 
ms_user_dimension on ms_download_facts.user_id = ms_user_dimension.user_id
left join ms_acc_dimension 
on ms_acc_dimension.acc_id = ms_user_dimension.acc_id
)
select date,sum(iif(paying_customer = 'no',downloads, 0)) as non_paying,
          sum(iif(paying_customer = 'yes',downloads, 0))  as paying
from t1
--where paying_customer = 'no'
group by date
having sum(iif(paying_customer = 'no',downloads, 0)) > sum(iif(paying_customer = 'yes',downloads, 0))
order by date asc