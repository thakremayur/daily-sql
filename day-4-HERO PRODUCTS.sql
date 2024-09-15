-- PROBLEM STATEMENT:
-- DAY 4

-- HERO PRODUCTS
-- FLIPKART AN ECOMMERCE COMPANY WANTS TO FIND OUT ITS TOP MOST SELLING
-- PRODUCT BY QUANTITY IN EACH CATEGORY. IN CASE OF A TIE WHEN QUANTITIES SOLD
-- ARE SAME FOR MORE THAN 1 PRODUCT, THEN WE NEED TO GIVE PREFERENCE TO THE
-- PRODUCT WITH HIGHER SALES VALUE.

-- DISPLAY CATEGORY AND PRODUCT IN OUTPUT WITH CATEGORY IN ASCENDING ORDER.

--  create tbl 
CREATE TABLE sales_orders (
    ORDER_ID INT,
    PRODUCT_ID VARCHAR(20),
    CATEGORY VARCHAR(20),
    UNIT_PRICE DECIMAL(10, 2),
    QUANTITY INT
);

INSERT INTO sales_orders (ORDER_ID, PRODUCT_ID, CATEGORY, UNIT_PRICE, QUANTITY) VALUES
(100, 'Chair-1221', 'Furniture', 1500.00, 1),
(101, 'Table-3421', 'Furniture', 2000.00, 3),
(102, 'Chair-1221', 'Furniture', 1500.00, 2),
(103, 'Table-9762', 'Furniture', 7000.00, 2),
(104, 'Shoes-1221', 'Footwear', 1700.00, 1),
(105, 'floaters-3421', 'Footwear', 2000.00, 1),
(106, 'floaters-3421', 'Footwear', 2000.00, 1),
(107, 'floaters-9875', 'Footwear', 1500.00, 2);
 
/* Expected output
+-----------+--------------+
| CATEGORY  | PRODUCT_ID   |
+-----------+--------------+
| Furniture | Table-3421   |
| Footwear  | floaters-3421|
+-----------+--------------+
*/

/*
CTE Definition (my_cte):
SELECT: Aggregates data by category and product_id.
SUM(quantity) AS total_qty: Calculates total quantity for each product within a category.
SUM(unit_price * quantity) AS total_rev: Calculates total revenue for each product within a category.
GROUP BY: Groups data by category and product_id.
*/
with my_cte as(
select
category,
product_id,
sum(quantity) as total_qty,
sum(unit_price*quantity) as total_rev
from sales_orders
group by category,product_id
)
select
category,
product_id
from (
	select *, rank() over(partition by category order by total_qty desc, total_rev desc) as rnk 
	from my_cte ) as subq
where rnk = 1
order by category

/*
Ranking and Filtering:
Assigns a rank to each product within its category based on total_qty (descending) and total_rev (descending).
WHERE rnk = 1: Filters to get the top-ranked product per category
*/