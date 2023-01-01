/*
Using SQL, find the customer(s) with the highest order price for orders placed within 10 years of the first order 
(earliest order_date) in the database.
*/
/*Company X has a record of its customers and their orders. 
Find the customer(s) with the highest order price for orders placed within 10 years of the 
first order (earliest order_date) in the database. Print the customer name and order price.
*/
--TABLES
--CUSTOMERS
--ORDERS

--TABLE CREATED AND DATA INSERTED
/*
CREATE TABLE CUSTOMERS(
ID INT NOT NULL,
NAME VARCHAR(255),
ORDER_ID INT NOT NULL
)

CREATE TABLE ORDERS(
ID INT NOT NULL,
PRICE INT,
ORDER_DATE DATE
)
*/
/*
INSERT INTO CUSTOMERS(ID,NAME,ORDER_ID)
VALUES(111,'Rubi',2222),
(112,'Gretchen',3223),
(113,'Faith',4224),
(114,'Yoselin',5225),
(115,'Preston',6226),
(116,'Rachael',7227),
(117,'Quincy',8228),
(118,'Brennen',9229),
(119,'Caitlyn',10230),
(120,'Rory',11231),
(121,'Gunn',12232)
*/
/*
INSERT INTO ORDERS(ID,PRICE,ORDER_DATE)
VALUES(4224,100,'01-01-2000'),
(5225,300,'01-01-2007'),
(6226,500,'01-01-2009'),
(7227,50,'01-01-2010'),
(11231,500,'01-01-2012'),
(12232,700,'01-01-2014')
*/


SELECT B.NAME,C.PRICE
FROM
(
SELECT *
FROM CUSTOMERS
) B
JOIN 
(
SELECT TOP 1 * FROM
(
SELECT *,(SELECT DATEADD(YEAR,10,MIN(ORDER_DATE))
FROM ORDERS) AS TEN_YEAR
FROM ORDERS) A
WHERE ORDER_DATE < TEN_YEAR
ORDER BY PRICE DESC
) C
ON B.ORDER_ID = C.ID
;
