/* 
	PROBLEM STATEMENT(26):
	DYNAMIC PRICING
You are given a products table where a new row is
inserted every time the price of a product changes.
Additionally, there is a transaction table containing
details such as order_date and product_id for each
order.
Write an SQL query to calculate the total sales value for
each product, considering the cost of the product at the
time of the order date, display the output in ascending
order of the product_id.
*/

-- Create the products table
CREATE TABLE products_26 (
    PRODUCT_ID INT,
    PRICE_DATE DATE,
    PRICE DECIMAL(10, 2),
    PRIMARY KEY (PRODUCT_ID, PRICE_DATE)
);

-- Insert data into the products table
INSERT INTO products_26 (PRODUCT_ID, PRICE_DATE, PRICE) VALUES
(100, '2024-01-01', 150.00),
(100, '2024-01-21', 170.00),
(100, '2024-02-01', 190.00),
(101, '2024-01-01', 1000.00),
(101, '2024-01-27', 1200.00),
(101, '2024-02-05', 1250.00);

-- Create the orders table
CREATE TABLE orders_26 (
    ORDER_ID INT,
    ORDER_DATE DATE,
    PRODUCT_ID INT,
    PRIMARY KEY (ORDER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES products_26(PRODUCT_ID)
);

-- Insert data into the orders table
INSERT INTO orders_26 (ORDER_ID, ORDER_DATE, PRODUCT_ID) VALUES
(1, '2024-01-05', 100),
(2, '2024-01-21', 100),
(3, '2024-02-20', 100),
(4, '2024-01-07', 101),
(5, '2024-02-04', 101),
(6, '2024-02-05', 101);

/*
expected output:
+-------------+-------------+
| PRODUCT_ID  | TOTAL_SALES |
+-------------+-------------+
|     100     |     510     |
|     101     |    3450     |
+-------------+-------------+
*/

select * from products_26;
select * from orders_26;

select 
o.PRODUCT_ID,
SUM(p.PRICE) AS TOTAL_SALES
from products_26 p join orders_26 o
on p.product_id = o.product_id and price_date <= order_date
where price_date = (select max(price_date) from products_26 where PRODUCT_ID = o.PRODUCT_ID AND o.ORDER_DATE >= PRICE_DATE)
GROUP BY o.PRODUCT_ID
