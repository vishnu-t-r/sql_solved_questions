use int_ques;

/*
Question:

Perform a comprehensive analysis of product reviews to generate the following insights:

  > The average review rating for each product.
  > The total number of reviews for each product.
  > Number of 5-star reviews for each product.
  > A ranking of products based on their average rating in descending order.
		1.If two products have the same average rating, rank them by number of 5-star reviews in descending order.
		2.If there is still a tie, rank them by the total number of reviews in descending order.

*/

/*
CREATE TABLE ProductReviews (
    ProductID INT,
    ReviewID INT PRIMARY KEY,
    ReviewRating INT CHECK (ReviewRating BETWEEN 1 AND 5)
);

-- Insert sample data for the ProductReviews table
INSERT INTO ProductReviews (ProductID, ReviewID, ReviewRating)
VALUES
    (101, 1, 5),
    (101, 2, 4),
    (101, 3, 5),
    (102, 4, 5),
    (102, 5, 5),
    (102, 6, 4),
    (103, 7, 3),
    (103, 8, 4),
    (103, 9, 5),
    (103, 10, 5),
    (104, 11, 2),
    (104, 12, 3),
    (104, 13, 3),
    (105, 14, 5),
    (105, 15, 5),
    (105, 16, 4),
    (105, 17, 5),
    (105, 18, 5);
*/

--select * from ProductReviews;


select productid,
		avg(reviewrating) as avg_rating,
		count(reviewid) as review_count,
		sum(case when reviewrating = 5 then 1 else 0 end) as five_star_review

from productreviews
group by productid