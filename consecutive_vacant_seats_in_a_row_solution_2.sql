/*
insert into theatre(seat_id, occupied) values('A1',1),('A2',1),('A3',0),('A4',0),('A5',0),('A6',0),
('A7',1),('A8',1),('A9',0),('A10',0),('B1',0),('B2',0),('B3',0),('B4',1),('B5',1),('B6',1),
('B7',1),('B8',0),('B9',0),('B10',0),('C1',0),('C2',1),('C3',0),('C4',1),('C5',1),('C6',0),
('C7',1),('C8',0),('C9',0),('C10',1);
*/

--select * from theatre;
--? Find seat numbers where 4 consecutive seats are empty in the same row??

with t1 as 
	(select *,
			ROW_NUMBER() OVER(PARTITION BY SUBSTRING(seat_id,1,1) ORDER BY SUBSTRING(seat_id,1,1)) as row_id
		from theatre
		),
t2 as
	(
		select *,
			lead(occupied,1) over(partition by SUBSTRING(seat_id,1,1)  order by row_id) as s1,
			lead(occupied,2) over(partition by SUBSTRING(seat_id,1,1) order by row_id) as s2,
			lead(occupied,3) over(partition by SUBSTRING(seat_id,1,1) order by row_id) as s3,
			lead(seat_id,3) over(partition by SUBSTRING(seat_id,1,1) order by row_id) as fourth_seat
		from t1
	),


t3 as(
		select *,occupied+s1+s2+s3 as score  from t2
	)

select seat_id,fourth_seat from t3 where score = 0;
