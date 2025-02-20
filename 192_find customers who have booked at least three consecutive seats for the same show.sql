
/*
Given a theatre SeatBookings table.
The theater management wants to identify instances where at least three consecutive seats 
were booked together by the same customer in a single show.

Write an SQL query to find customers who have booked at least three consecutive seats for the same show.
*/

use int_ques;

/*
CREATE TABLE SeatBookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    ShowID INT NOT NULL,
    CustomerID INT NOT NULL,
    SeatNumber INT NOT NULL,
    BookingDate DATE NOT NULL
);

INSERT INTO SeatBookings (ShowID, CustomerID, SeatNumber, BookingDate) VALUES
(1, 101, 5, '2099-07-01'),
(1, 101, 6, '2099-07-01'),
(1, 101, 7, '2099-07-01'),  -- Consecutive booking by 101
(1, 102, 10, '2099-07-01'),
(1, 102, 11, '2099-07-01'),
(1, 103, 15, '2099-07-01'),
(1, 103, 16, '2099-07-01'),
(1, 103, 17, '2099-07-01'),
(1, 103, 18, '2099-07-01');  -- Consecutive booking by 103
*/

--select * from seatbookings;

with t1 as(
select *,
		lead(seatnumber, 1, null)
		over(partition by showid, customerid, bookingdate order by seatnumber asc) as seatnumber1,
		lead(seatnumber, 2, null)
		over(partition by showid, customerid, bookingdate order by seatnumber asc) as seatnumber2
from seatbookings
)
select distinct customerid 
from t1
where (seatnumber2 - seatnumber1) = 1   
and (seatnumber1 - seatnumber) = 1;

