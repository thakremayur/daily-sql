/* 
	PROBLEM STATEMENT(73):
	CATEGORY PRODUCT COUNT
You are provided with a table that lists various
product categories, each containing a commaseparated list of products. Your task is to write a
SQL query to count the number of products in each
category. Sort the result by product count.

*/
CREATE TABLE Categories (
    CATEGORY VARCHAR(50) PRIMARY KEY,
    PRODUCTS VARCHAR(255)
);
INSERT INTO Categories (CATEGORY, PRODUCTS) VALUES
('Electronics', 'TV, Radio, Laptop'),
('Furniture', 'Chair'),
('Clothing', 'Shirt, Pants, Jacket, Shoes'),
('Groceries', 'Rice, Sugar');

/*
EXPECTED OUTPUT:
---------------------------------
| CATEGORY    | CNT             |
---------------------------------
| Furniture   | 1               |
| Groceries   | 2               |
| Electronics | 3               |
| Clothing    | 4               |
---------------------------------
*/
select * from categories;

select 
category,
length(products) - length(replace(products, ',','')) + 1 as cnt
from categories
order by cnt

/*
Explaination:
length(products): Calculates the total length of the string in the PRODUCTS column.
replace(products, ',', ''): Removes all commas from the PRODUCTS string.
length(replace(products, ',', '')): Calculates the length of the string without commas.
length(products) - length(replace(products, ',' , '')): This calculates the number of commas in the original string by 
subtracting the length of the string without commas from the length of the original string.
+ 1: Since the number of products is one more than the number of commas (e.g., "A, B, C" has 2 commas but 3 products), 
we add 1 to the result.
*/