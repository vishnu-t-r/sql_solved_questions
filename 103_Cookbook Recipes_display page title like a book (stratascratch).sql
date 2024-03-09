--Cookbook Recipes

--You are given the table with titles of recipes from a cookbook and their page numbers. 
--You are asked to represent how the recipes will be distributed in the book.
--Produce a table consisting of three columns: left_page_number, left_title and right_title. 
--The k-th row (counting from 0), should contain the number and the title of the page with the number 
--2*k in the first and second columns respectively, and the title of the page with the number (2*k)+1 in the third column.
--Each page contains at most 1 recipe. 
--If the page does not contain a recipe, the appropriate cell should remain empty (NULL value). 
--Page 0 (the internal side of the front cover) is guaranteed to be empty.

use int_ques;

/*
create table cookbook_titles(
page_number int,
title varchar(max)
)

insert into cookbook_titles(page_number, title)
values(1,'Scrambled eggs'),
(2,'Fondue'),
(3,'Sandwich'),
(4,'Tomato soup'),
(6,'Liver'),
(11,'Fried duck'),
(12,'Boiled duck'),
(15,'Baked chicken')
*/


with t1 as
(
select n from (values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n)
),
t2 as
(SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as page_num
from t1 ones,t1 tens
),
left_page as
(select (page_num-1) as left_page_num
from t2
where page_num <= (select max(page_number) from cookbook_titles)
and (page_num-1)%2 = 0
)
select left_page_num, 
        ct_left.title as left_page_title,
        ct_right.title as right_page_title
from left_page left join cookbook_titles as ct_left 
on left_page.left_page_num = ct_left.page_number
left join  cookbook_titles as ct_right
on (left_page.left_page_num+1) = ct_right.page_number