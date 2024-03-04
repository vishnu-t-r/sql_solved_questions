--Counting Instances in Text

use int_ques;

/*
Find the number of times the words 'bull' and 'bear' occur in the contents. 
We're counting the number of times the words occur so words like 'bullish' should not be included in our count.
Output the word 'bull' and 'bear' along with the corresponding number of occurrences.
*/

/*
create table google_file_store(
filename varchar(20),
contents varchar(max)
)

insert into google_file_store(filename, contents)
values('draft1.txt','The stock exchange predicts a bull market which would make many investors happy.'),
('draft2.txt','The stock exchange predicts a bull market which would make many investors happy, but analysts warn of possibility of too much optimism and that in fact we are awaiting a bear market.'),
('final.txt','The stock exchange predicts a bull market which would make many investors happy, but analysts warn of possibility of too much optimism and that in fact we are awaiting a bear market. As always predicting the future market is an uncertain game and all investors should follow their instincts and best practices.')
*/


select value, count(*) as word_count
from google_file_store
cross apply string_split(contents,' ')
where value in ('bull','bear')
group by value;
