-- PROBLEM STATEMENT:
-- DAY 2

-- TRENDING PRODUCTS
-- Amazon wants to find out the trending products for
-- each month. Trending products are those for which
-- any given month sales are more than the sum of
-- previous 2 months sales for that product.
-- Please note that for first 2 months of operations this
-- metrics does not make sense. So output should
-- start from 3rd month only. Assume that each
-- product has at least 1 sale each month, display
-- order month and product id. Sort by order month.

-- create tbl for sales_data 
CREATE TABLE sales_data (
    ORDER_MONTH INT,
    PRODUCT_ID VARCHAR(10),
    SALES INT
);

INSERT INTO sales_data (ORDER_MONTH, PRODUCT_ID, SALES) VALUES
(202301, 'p1', 100),
(202301, 'p2', 500),
(202302, 'p1', 700),
(202302, 'p2', 300),
(202303, 'p1', 900),
(202303, 'p2', 700),
(202304, 'p1', 2000),
(202304, 'p2', 1100),
(202305, 'p1', 1500),
(202305, 'p2', 1300),
(202306, 'p1', 1700),
(202306, 'p2', 1200),
(202307, 'p1', 1900),
(202307, 'p2', 1400),
(202308, 'p1', 2100),
(202308, 'p2', 1600),
(202309, 'p1', 2300),
(202309, 'p2', 1800),
(202310, 'p1', 5000),
(202310, 'p2', 2000);

-- Expected output
-- +-------------+-------------+
-- | ORDER_MONTH | PRODUCT_ID  |
-- +-------------+-------------+
-- |    202303   |     p1      |
-- |    202304   |     p2      |
-- |    202304   |     p1      |
-- |    202310   |     p1      |
-- +-------------+-------------+
 
with my_cte as(
select 
*,
lag(sales,1) over(partition by product_id order by order_month)  +
lag(sales,2) over(partition by product_id order by order_month) as total_sum
from sales_data
)
-- Explaination  for CTE
-- LAG(sales, 1): Returns the sales value from the previous month for the same product.
-- LAG(sales, 2): Returns the sales value from two months prior for the same product.
-- total_sum: The sum of sales values from the previous two months (if available). 
-- If there aren't enough previous months, total_sum may be NULL.

select
order_month,
product_id
from my_cte 
where sales > total_sum
order by order_month

 
 