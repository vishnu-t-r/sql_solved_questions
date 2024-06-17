use sql_challenge;

/*
find the total number of outputs for each joins
*/

--inner join
--left join
--right join
--full join
--cross join

/*
create table tbl1(id int);
create table tbl2(id int);

insert into tbl1
values(1),(1),(1),(null),(null),(2);

insert into tbl2
values(1),(2),(3),(null);
*/
select * from tbl1;
select * from tbl2;

--inner join
select * from tbl1
inner join tbl2 on tbl1.id = tbl2.id;

--left join
select * from tbl1
left join tbl2 on tbl1.id = tbl2.id;

--right join
select * from tbl1
right join tbl2 on tbl1.id = tbl2.id;

--cross join
select * from tbl1
cross join tbl2;

--full join
select * from tbl1
full join tbl2 on tbl1.id = tbl2.id;
