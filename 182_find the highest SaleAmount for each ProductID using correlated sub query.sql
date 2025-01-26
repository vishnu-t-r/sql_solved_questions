use int_ques;

/*
Question

Write a SQL query to find the highest SaleAmount for each ProductID across all stores 
and the corresponding StoreID and SaleDate. 
Use a correlated subquery to achieve this.

Conditions:
If two or more rows have the same maximum SaleAmount for a ProductID, return the one with the earliest SaleDate.
*/

/*
CREATE TABLE Product_Sales (
    ProductID VARCHAR(10),
    StoreID VARCHAR(10),
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2),
    PRIMARY KEY (ProductID, StoreID, SaleDate)
);

INSERT INTO Product_Sales (ProductID, StoreID, SaleDate, SaleAmount)
VALUES
    ('P001', 'S001', '2024-10-01', 500.00),
    ('P002', 'S002', '2024-10-05', 300.00),
    ('P001', 'S003', '2024-10-07', 700.00),
    ('P003', 'S001', '2024-10-08', 450.00),
    ('P001', 'S001', '2024-10-10', 600.00),
    ('P002', 'S002', '2024-10-15', 400.00),
    ('P003', 'S003', '2024-10-20', 500.00),
    ('P001', 'S002', '2024-10-12', 650.00),
	('P003', 'S003', '2024-10-21', 500.00);
*/

select * from product_sales;

/*
select *,
		(select max(saleamount) from product_sales as p2
		where p1.productid = p2.productid
		--group by productid
		) as max_sales
from product_sales as p1;
*/


select productid,
		max(storeid) as store_id,
		min(saledate) as saledate,
		max(saleamount) as max_saleamount
from product_sales as p1
where p1.saleamount = (select max(saleamount) from product_sales as p2
						where p2.productid = p1.productid)
group by productid;







