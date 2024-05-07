--Symmetric pairs

use int_ques;

/*
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. 
List the rows such that X1 ≤ Y1.
*/

/*
create table pairs(
x int,
y int)

insert into pairs(x,y)
values(20,20),(20,20),
(20,21),(23,22),(25,21),
(22,23),(21,27),
(21,20)
*/

select * from pairs;

select distinct p1.x as x1,p1.y as y1
		--p2.x as x2, p2.y as y2
from pairs p1
inner join pairs p2
on p1.x = p2.y and p2.x = p1.y
where p1.x <= p1.y
order by x1 asc;
--X1 = Y2 and X2 = Y1

