--Data Transformation SQL Interview Question

/*
Transform this table to show each employee's shift schedule in a comma-separated format for each date.
*/
use learn;


/*
CREATE TABLE Employee_Shifts (
    emp_id INT,
    shift_date DATE,
    shift_type VARCHAR(20),
    PRIMARY KEY (emp_id, shift_date)  -- Assuming one shift per employee per day
);


INSERT INTO Employee_Shifts (emp_id, shift_date, shift_type) VALUES
(101, '2099-01-01', 'Morning'),
(101, '2099-01-02', 'Night'),
(102, '2099-01-01', 'Evening'),
(103, '2099-01-01', 'Morning'),
(103, '2099-01-02', 'Morning'),
(103, '2099-01-03', 'Night');
*/

select * from employee_shifts;

with t1 as(
select *,
		concat(emp_id,' (',shift_type,')') as emp_shifts
from employee_shifts
)
select shift_date,
		string_agg(emp_shifts, ', ') within group(order by  shift_type desc, emp_id asc) as shifts
from t1
group by shift_date;