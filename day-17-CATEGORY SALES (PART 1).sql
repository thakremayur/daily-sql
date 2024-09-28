/* 
	PROBLEM STATEMENT(61):
	CATEGORY SALES (PART 1)
Write an SQL query to retrieve the total sales
amount for each product category in the month of
February 2022, only including sales made on
weekdays (Monday to Friday). Display the output in
ascending order of total sales.
*/
CREATE TABLE Orders_ps_61 (
    ID INT PRIMARY KEY,
    PRODUCT_ID INT,
    CATEGORY VARCHAR(50),
    AMOUNT DECIMAL(10, 2),
    ORDER_DATE DATE
);
INSERT INTO Orders_ps_61 (ID, PRODUCT_ID, CATEGORY, AMOUNT, ORDER_DATE) VALUES
(1, 101, 'Electronics', 1500, '2022-02-05'),
(2, 102, 'Electronics', 2000, '2022-02-10'),
(3, 103, 'Clothing', 500, '2022-02-15'),
(4, 104, 'Clothing', 800, '2022-02-20'),
(5, 105, 'Books', 300, '2022-02-25'),
(6, 106, 'Electronics', 1800, '2022-03-08'),
(7, 107, 'Clothing', 600, '2022-03-15'),
(8, 108, 'Books', 400, '2022-03-20'),
(9, 109, 'Electronics', 2200, '2022-04-05'),
(10, 110, 'Clothing', 700, '2022-04-10'),
(11, 111, 'Books', 500, '2022-04-15'),
(12, 112, 'Electronics', 2500, '2022-05-05'),
(13, 113, 'Clothing', 900, '2022-05-10'),
(14, 114, 'Books', 600, '2022-05-15');

/*
EXPECTED OUTPUT:
-----------------------------
| CATEGORY    | TOTAL_SALES |
-----------------------------
| Books       | 300         |
| Clothing    | 500         |
| Electronics | 3500        |
-----------------------------
*/

select * from Orders_ps_61;

select 
category,
sum(amount) as total_sales
from Orders_ps_61
where order_date like '2022-02%' and dayofweek(order_date) between 2 and 6
group by category
order by total_sales