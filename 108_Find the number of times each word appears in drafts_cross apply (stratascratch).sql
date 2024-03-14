--Find the number of times each word appears in drafts

/*
Find the number of times each word appears in drafts.
Output the word along with the corresponding number of occurrences.
*/

use int_ques;

/*
create table google_file_store(
filename varchar(20),
contents varchar(max)
)

insert into google_file_store(filename, contents)
values('draft1.txt','The stock exchange predicts a bull market which would make many investors happy.'),
('draft2.txt','The stock exchange predicts a bull market which would make many investors happy, 
		but analysts warn of possibility of too much optimism and that in fact we are awaiting a bear market.'),
('final.txt','The stock exchange predicts a bull market which would make many investors happy, 
but analysts warn of possibility of too much optimism and that in fact we are awaiting a bear market. 
As always predicting the future market is an uncertain game and all investors should follow their instincts and best practices.')
*/

with t1 as(
select value as words
from google_file_store
cross apply string_split(replace(replace(contents,',',''),'.',''),' ')
where filename like '%draft%'
)
select words as value, count(*) as No_Of_Occurrences
from t1
group by words