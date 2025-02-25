/*
Question
Write a query to find customers who had overlapping bookings at different hotels 
(i.e., bookings with overlapping dates but at different hotels).
*/

use int_ques;

/*
CREATE TABLE HotelBookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    HotelID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    BookingStatus VARCHAR(20)
);

INSERT INTO HotelBookings (BookingID, CustomerID, HotelID, CheckInDate, CheckOutDate, BookingStatus) VALUES
(1, 301, 501, '2025-02-10', '2025-02-15', 'Completed'),
(2, 301, 502, '2025-02-12', '2025-02-18', 'Completed'),
(3, 302, 501, '2025-02-20', '2025-02-25', 'Cancelled'),
(4, 303, 503, '2025-02-05', '2025-02-10', 'Completed'),
(5, 301, 504, '2025-03-01', '2025-03-05', 'Confirmed'),
(6, 303, 505, '2025-02-08', '2025-02-12', 'Completed');
*/


--select * from hotelbookings;

select distinct b1.customerid 
from hotelbookings b1
--self join with the same table
inner join hotelbookings b2
--checking only for the same customer
on b1.customerid = b2.customerid
--not to compare same booking
and b1.bookingid <> b2.bookingid
--booking must be in different hotels
and b1.hotelid <> b2.hotelid
--booking status should be completed or confirmed
and b1.bookingstatus in ('Completed','Confirmed')
and b2.bookingstatus in ('Completed','Confirmed')
--date condition to check overlapping bookings
and b1.checkindate <= b2.checkoutdate
and b2.checkindate <= b1.checkoutdate;


