use leetcode;

--Write a solution to find the IDs of the users who visited without making any transactions 
--and the number of times they made these types of visits.

--leetcode 1581
--Customer Who Visited but Did Not Make Any Transactions


/*
create table visits(
visit_id int,
customer_id int
)

insert into visits(visit_id, customer_id)
values(1,23),(2,9),
(4,30),(5,54),
(6,96),(7,54),
(8,54)

create table transactions(
transaction_id int,
visit_id int,
amount int
)

insert into transactions(transaction_id, visit_id, amount)
values(2,5,310),
(3,5,300),
(9,5,200),
(12,1,910),
(13,2,970)

*/