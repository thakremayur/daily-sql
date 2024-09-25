/* 
	PROBLEM STATEMENT(4):
	PREMIUM CUSTOMERS
An e-commerce company want to start special
reward program for their premium customers. The
customers who have placed a greater number of
orders than the average number of orders placed by
customers are considered as premium customers.
Write an SQL to find the list of premium customers
along with the number of orders placed by each of
them, display the results in highest to lowest no of
orders.
*/
CREATE TABLE SalesData (
    ORDER_ID INT PRIMARY KEY,
    ORDER_DATE DATE,
    CUSTOMER_NAME VARCHAR(50),
    SALES DECIMAL(10, 2)
);
INSERT INTO SalesData (ORDER_ID, ORDER_DATE, CUSTOMER_NAME, SALES) VALUES
(1, '2023-01-01', 'Alexa', 2000),
(2, '2023-01-02', 'Alexa', 300),
(3, '2023-01-03', 'Alexa', 1100),
(4, '2023-01-03', 'Alexa', 1350),
(5, '2023-01-01', 'Ramesh', 3500),
(6, '2023-01-02', 'Ramesh', 1600),
(7, '2023-01-03', 'Ramesh', 1100),
(8, '2023-01-03', 'Neha', 1200),
(9, '2023-01-03', 'Subhash', 1000),
(10, '2023-01-03', 'Subhash', 1050);

/*
EXPECTED OUTPUT:
CUSTOMER_NAME  NO_OF_ORDERS
--------------- -------------
Alexa           4
Ramesh          3
*/
select * from SalesData;

select
customer_name,
count(*) as no_of_orders
from salesdata
group by customer_name
having count(*) > (select count(ORDER_ID)/(count(distinct customer_name)) from salesdata)
order by no_of_orders desc

