/* 
	PROBLEM STATEMENT(55):
	LOWEST PRICE
You own a small online store, and want to analyze
customer ratings for the products that you're selling. After
doing a data pull, you have a list of products and a log of
purchases. Within the purchase log, each record includes
the number of stars (from 1 to 5) as a customer rating for
the product.
For each category, find the lowest price among all
products that received at least one 4-star or above rating
from customers.
If a product category did not have any products that
received at least one 4-star or above rating, the lowest
price is considered to be 0. The final output should be
sorted by product category in alphabetical order.
*/
CREATE TABLE Products (
    ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    CATEGORY VARCHAR(50),
    PRICE DECIMAL(10, 2)
);

CREATE TABLE Purchases (
    ID INT PRIMARY KEY,
    PRODUCT_ID INT,
    STARS INT,
    FOREIGN KEY (PRODUCT_ID) REFERENCES Products(ID)
);
INSERT INTO Products (ID, NAME, CATEGORY, PRICE) VALUES
(1, 'Cripps Pink', 'apple', 10),
(2, 'Navel Orange', 'orange', 12),
(3, 'Golden Delicious', 'apple', 6),
(4, 'Clementine', 'orange', 14),
(5, 'Pinot Noir', 'grape', 20),
(6, 'Bing Cherries', 'cherry', 36);

INSERT INTO Purchases (ID, PRODUCT_ID, STARS) VALUES
(1, 1, 2),
(2, 3, 3),
(3, 2, 2),
(4, 4, 4),
(5, 6, 5),
(6, 6, 4);

/*
EXPECTED OUTPUT:
-------------------------
| CATEGORY | PRICE      |
-------------------------
| apple    | 0          |
| cherry   | 36         |
| grape    | 0          |
| orange   | 14         |
-------------------------
*/

select * from products;
select * from purchases;

select 
category,
coalesce(min(case when pur.product_id is not null then price end), 0) as price
from products p left join purchases pur
on p.id = pur.product_id and stars in (4,5)
group by category
order by category

/*
Hint 1: Select the category and calculate the minimum price.
Hint 2: Include prices only for purchases with star ratings of 4 or 5.
Hint 3: Use COALESCE to return 0 if no valid prices are found.
Hint 4: Start from the products table.
Hint 5: Use a LEFT JOIN with the purchases table based on product_id.
Hint 6: Group the results by category.
Hint 7: Order the final results by category in ascending order.
*/