--Min Max from group and sequence

use int_ques;

/*
Given an input table with two columns Group and Sequence. 
Write a query to find the maximumn and minimum values of the continuous 'Sequence' in 
each 'Group'.
*/
/*
create table tab_sequence(
[group] varchar(20),
sequence int)

insert into tab_sequence([group],sequence)
values('A',1),('A',2),('A',3),
('A',5),('A',6),
('A',8),('A',9),
('B',11),
('C',1),('C',2),('C',3)
*/

--select * from tab_sequence;

with flag_query as(
select [group],	
		[sequence],
		row_number() over(partition by [group] order by [sequence] asc) as flag,
		[sequence] - row_number() over(partition by [group] order by [sequence] asc) as diff
from tab_sequence
)
select distinct [group], --diff,
		min([sequence]) over(partition by [group],diff) as min_seq,
		max([sequence]) over(partition by [group],diff) as max_seq
from flag_query
--group by [group], diff


 



