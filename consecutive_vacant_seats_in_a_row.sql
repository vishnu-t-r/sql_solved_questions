/*
insert into theatre(seat_id, occupied) values('A1',1),('A2',1),('A3',0),('A4',0),('A5',0),('A6',0),
('A7',1),('A8',1),('A9',0),('A10',0),('B1',0),('B2',0),('B3',0),('B4',1),('B5',1),('B6',1),
('B7',1),('B8',0),('B9',0),('B10',0),('C1',0),('C2',1),('C3',0),('C4',1),('C5',1),('C6',0),
('C7',1),('C8',0),('C9',0),('C10',1);
*/

--select * from theatre;
--? Find seat numbers where 4 consecutive seats are empty in the same row??

WITH t1 AS (
    SELECT *,
           CASE WHEN seat_id LIKE 'A%' THEN 'A' 
		   WHEN seat_id LIKE 'B%' THEN 'B' 
		   WHEN seat_id LIKE 'C%' THEN 'C' 
		   END AS row_id
      FROM theatre
			),
t2 AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY row_id order by row_id) AS id
      FROM t1
),

t3 AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY row_id ORDER BY id) as nw_row,
           id - ROW_NUMBER() OVER (PARTITION BY row_id ORDER BY id) AS diff
      FROM t2
     WHERE t2.occupied <> 1
),
t4 AS (
    SELECT seat_id,
           row_id,
           count( * ) OVER (PARTITION BY row_id,
           diff) AS no_of_consecutive_seat
      FROM t3
)
SELECT *
  FROM t4
 WHERE no_of_consecutive_seat >= 4;
    
