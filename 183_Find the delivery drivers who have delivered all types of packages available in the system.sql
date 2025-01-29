use int_ques;
/*
Question
Find the delivery drivers who have delivered all types of packages available in the system.
*/

/*
CREATE TABLE Deliveries (
    DeliveryID INT PRIMARY KEY,
    DriverID INT NOT NULL,
    PackageType VARCHAR(50) NOT NULL,
    DeliveryDate DATE NOT NULL
);

INSERT INTO Deliveries (DeliveryID, DriverID, PackageType, DeliveryDate)
VALUES
    (1, 501, 'Electronics', '2024-11-05'),
    (2, 502, 'Furniture', '2024-11-07'),
    (3, 501, 'Groceries', '2024-11-10'),
    (4, 503, 'Electronics', '2024-11-12'),
    (5, 501, 'Furniture', '2024-11-15'),
    (6, 502, 'Groceries', '2024-11-18'),
    (7, 503, 'Groceries', '2024-11-20'),
    (8, 504, 'Electronics', '2024-11-22'),
    (9, 501, 'Clothing', '2024-11-23'),
    (10, 503, 'Clothing', '2024-11-24'),
    (11, 502, 'Electronics', '2024-11-25'),
    (12, 504, 'Furniture', '2024-11-26'),
    (13, 501, 'Food & Drinks', '2024-11-28'),
    (14, 503, 'Furniture', '2024-11-29'),
    (15, 502, 'Food & Drinks', '2024-11-30');
*/

select * from deliveries
order by driverid asc;

select driverid
from deliveries
group by driverid
having count(distinct packagetype) =
(select count(distinct packagetype) as package_count
from deliveries);






