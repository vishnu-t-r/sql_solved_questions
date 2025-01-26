use int_ques;

/*
Question-
Write an SQL query to find all flights where at least two passengers have confirmed reservations in adjacent seats. 
Adjacent seats are defined as having consecutive seat numbers (e.g., 12A and 12B). 
Display the FlightID and the names of the passengers with adjacent confirmed seats.
*/


/*
CREATE TABLE SeatReservations (
    ReservationID INT PRIMARY KEY,
    PassengerName VARCHAR(50),
    SeatNumber VARCHAR(5),
    BookingDate DATE,
    FlightID VARCHAR(10),
    Status VARCHAR(20)
);

INSERT INTO SeatReservations (ReservationID, PassengerName, SeatNumber, BookingDate, FlightID, Status)
VALUES 
(1, 'John Smith', '12A', '2024-01-01', 'F101', 'Confirmed'),
(2, 'Jane Doe', '12B', '2024-01-01', 'F101', 'Cancelled'),
(3, 'Alice Brown', '14A', '2024-01-02', 'F102', 'Confirmed'),
(4, 'Bob Johnson', '14B', '2024-01-02', 'F102', 'Confirmed'),
(5, 'Mary Taylor', '15A', '2024-01-03', 'F103', 'Confirmed'),
(6, 'John Smith', '12C', '2024-01-03', 'F101', 'Confirmed'),
(7, 'Tom Hardy', '10A', '2024-01-04', 'F104', 'Confirmed'),
(8, 'Emma Davis', '10B', '2024-01-04', 'F104', 'Confirmed'),
(9, 'Chris Evans', '10C', '2024-01-04', 'F104', 'Confirmed'),
(10, 'Sophia Lee', '14C', '2024-01-02', 'F102', 'Confirmed'),
(11, 'Emily Clark', '16A', '2024-01-05', 'F105', 'Cancelled'),
(12, 'Henry Adams', '14A', '2024-01-05', 'F102', 'Confirmed'),
(13, 'Olivia Green', '14B', '2024-01-05', 'F102', 'Confirmed'),
(14, 'David Brown', '13A', '2024-01-06', 'F106', 'Confirmed'),
(15, 'Linda Wilson', '13B', '2024-01-06', 'F106', 'Confirmed');
*/

select * from seatreservations
order by flightid asc, bookingdate asc;

with cte1 as(
select passengername,
		seatnumber,
		bookingdate,
		flightid,
		status,
		row_number() over(partition by flightid, bookingdate order by seatnumber asc) as flag_one
from seatreservations
--order by flightid asc, seatnumber asc;
), cte2 as(
select *,
	row_number() over(partition by flightid, bookingdate order by seatnumber asc) as flag_two	
from seatreservations
where status = 'Confirmed'
)
select one.flightid as Flight_ID,
		one.passengername as Passenger_One,
		two.passengername as Passenger_Two
from cte1 as one
inner join cte2 as two
on one.flightid = two.flightid
	and one.bookingdate = two.bookingdate
	and one.passengername <> two.passengername
where one.status = 'Confirmed'
and (flag_one-flag_two)= 1 ;