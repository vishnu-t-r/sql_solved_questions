
/*
An e-commerce company tracks customer interactions with products in the ProductViews table. 
The task is to identify customers who have viewed the same product for more than 3 consecutive days.

Write an SQL query to identify customers who have viewed the same product for more than 3 consecutive days.
*/

use int_ques;

/*
CREATE TABLE ProductViews (
    ViewID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    ViewDate DATE NOT NULL
);

INSERT INTO ProductViews (CustomerID, ProductID, ViewDate) VALUES
(101, 5001, '2099-02-10'),
(101, 5001, '2099-02-11'),
(101, 5001, '2099-02-12'),
(101, 5001, '2099-02-13'),
(101, 5001, '2099-02-15'),
(102, 6002, '2099-02-08'),
(102, 6002, '2099-02-09'),
(102, 6002, '2099-02-10'),
(102, 6002, '2099-02-11'),
(103, 7003, '2099-02-15'),
(103, 7003, '2099-02-17'),
(104, 8004, '2099-03-01'),
(104, 8004, '2099-03-02'),
(104, 8004, '2099-03-03'),
(104, 8004, '2099-03-04'),
(104, 8004, '2099-03-06');
*/
SELECT * FROM ProductViews;

with t1 as(
select viewid,
		customerid,
		productid,
		viewdate,
		lag(viewdate, 1, null) over(partition by customerid, productid order by viewdate asc) as previousday1,
		lag(viewdate, 2, null) over(partition by customerid, productid order by viewdate asc) as previousday2,
		lag(viewdate, 3, null) over(partition by customerid, productid order by viewdate asc) as previousday3
from productviews
)
select distinct customerid, productid 
from t1
where datediff(day,previousday1,viewdate) = 1
and datediff(day,previousday2,previousday1) = 1
and datediff(day,previousday3,previousday2) = 1;