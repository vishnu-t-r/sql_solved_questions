/*
CREATE TABLE student_all_any(
		stud_name varchar(255),
		stud_age int
		);

*/

/*
insert into student_all_any(stud_name, stud_age) 
values('raja',28),('papan',20),('chackochi',19),('tom',37),('jerry',45),
('scoobee',55),('oogy',32),('vava',24),
('sidhan',21),('lulu',27),('fernando',65);
*/

/*
CREATE TABLE lecturer_all_any(
		lect_name varchar(255),
		lect_age int
		);
*/

/*
INSERT INTO lecturer_all_any(lect_name, lect_age) 
values('hamil',35),('russel',51),('versta',49),('noris',48),('ocon',61),
('gasly',39),('tsuno',51),('vettel',33),
('alonso',31),('bottas',41);
*/

--? find the students/student who are older than any of the teacher(lecturer)
SELECT 
	*
FROM 
	student_all_any
WHERE 
	stud_age > ANY(
					SELECT 
						lect_age 
					FROM 
						lecturer_all_any
					)



--? find the students/student who are older than all of the teacher(lecturer)
SELECT 
	*
FROM 
	student_all_any
WHERE 
	stud_age > ALL(
					SELECT 
						lect_age 
					FROM 
						lecturer_all_any
					)
