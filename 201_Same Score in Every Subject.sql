--Same Score in Every Subject?
--Write a SQL query to find students whose scores are the same in all subjects they appeared in.

use questions;

/*
CREATE TABLE student_scores (
    student_id INT,
    subject VARCHAR(50),
    score INT
);


INSERT INTO student_scores (student_id, subject, score) VALUES
(1, 'Math', 85),
(1, 'Science', 92),
(2, 'Math', 90),
(2, 'Science', 88),
(3, 'Math', 78),
(3, 'Science', 78);
*/

select * from student_scores;

--using min and max

select student_id
from student_scores
group by student_id
having min(score) = max(score);


--using count and having
select student_id,
		count(distinct score) as score_count
from student_scores
group by student_id
having count(distinct score) = 1;


--try using self join
select distinct s1.student_id 
from student_scores s1
inner join student_scores s2
on s1.student_id = s2.student_id
and s1.score = s2. score
and s1.subject <> s2.subject;