/* 
	PROBLEM STATEMENT(2):
	PRODUCT CATEGORY
You are provided with a table named Products containing
information about various products, including their names and
prices. Write a SQL query to count number of products in each
category based on its price into three categories below. Display the
output in descending order of no of products.
1- "Low Price" for products with a price less than 100
2- "Medium Price" for products with a price between 100 and 500
(inclusive)
3- "High Price" for products with a price greater than 500.

*/
CREATE TABLE Products_ps2 (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(255),
    Price DECIMAL(10, 2)
);
INSERT INTO Products_ps2 (Product_ID, Product_Name, Price) VALUES
(1, 'Laptop', 800.00),
(2, 'Smartphone', 600.00),
(3, 'Headphones', 50.00),
(4, 'Tablet', 400.00),
(5, 'Keyboard', 30.00),
(6, 'Mouse', 15.00),
(7, 'Monitor', 350.00),
(8, 'Printer', 120.00),
(9, 'USB Drive', 10.00),
(10, 'External Hard Drive', 150.00),
(11, 'Wireless Router', 80.00),
(12, 'Bluetooth Speaker', 70.00),
(13, 'Webcam', 45.00),
(14, 'Microphone', 25.00),
(15, 'Gaming Mouse', 50.00);

/*
expected output:
--------------------------------------
| CATEGORY        | NO_OF_PRODUCTS  |
--------------------------------------
| Low Price       | 9              |
| Medium Price    | 4              |
| High Price      | 2              |
--------------------------------------
*/

select * from products_ps2;

with cte as(
select *,
case when price < 100 then 'Low Price'
	when price between 100 and 500 then 'Medium Price'
    else 'High Price' end as category
from products_ps2)
select category,count(*) as no_of_products
from cte 
group by category
order by no_of_products desc
