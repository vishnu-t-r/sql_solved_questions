use int_ques;

/*
Question:

> Calculate the average review rating and total number of reviews for each product.
> Calculate the total sales amount for each product from the sales data.
> Identify the top 3 performing products based on:
	1.Total sales amount (highest first).
	2.Average rating (highest first).
	3.Total reviews (highest first) in case of a tie.
> Include only products with an average rating of 4 or higher in the final results.
> Provide the following details for each product:
	1.ProductID
	2.AverageRating
	3.TotalReviews
	4.TotalSalesAmount
	5.Rank
*/

/*
CREATE TABLE Product_Reviews (
    ProductID INT,
    ReviewID INT PRIMARY KEY,
    ReviewRating INT CHECK (ReviewRating BETWEEN 1 AND 5),
    SaleAmount DECIMAL(10, 2)
);


-- Insert sample data for the ProductReviews table
INSERT INTO Product_Reviews (ProductID, ReviewID, ReviewRating, SaleAmount)
VALUES
    (101, 1, 5, 100.00),
    (101, 2, 4, 200.00),
    (101, 3, 5, 150.00),
    (102, 4, 5, 250.00),
    (102, 5, 5, 300.00),
    (102, 6, 4, 180.00),
    (103, 7, 3, 120.00),
    (103, 8, 4, 130.00),
    (103, 9, 5, 220.00),
    (103, 10, 5, 210.00),
    (104, 11, 2, 100.00),
    (104, 12, 3, 120.00),
    (104, 13, 3, 150.00),
    (105, 14, 5, 500.00),
    (105, 15, 5, 400.00),
    (105, 16, 4, 300.00),
    (105, 17, 5, 450.00),
    (105, 18, 5, 350.00);
*/

--select * from product_reviews;

with t1 as(
select productid, avg(reviewrating) as avg_review,
		count(reviewid) as review_count,
		sum(saleamount) as total_sales
from product_reviews
group by productid
)
select productid,
		avg_review,
		review_count,
		total_sales,
		rank() over(order by total_sales desc, avg_review desc, review_count desc) as product_rank
from t1
where avg_review >= 4;