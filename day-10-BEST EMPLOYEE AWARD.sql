/* 
	PROBLEM STATEMENT(12):
    DELIVEROO TOP CUSTOMER
You are provided with data from a food delivery
service called Deliveroo. Each order has details
about the delivery time, the rating given by the
customer, and the total cost of the order. Write an
SQL to find customer with highest total expenditure.
Display customer id and total expense by him/her.
*/
CREATE TABLE Orders (
    ORDER_ID INT PRIMARY KEY,
    CUSTOMER_ID INT,
    RESTAURANT_ID INT,
    DELIVERY_TIME INT,
    TOTAL_COST DECIMAL(10, 2)
);
INSERT INTO Orders (ORDER_ID, CUSTOMER_ID, RESTAURANT_ID, DELIVERY_TIME, TOTAL_COST) VALUES
(1, 101, 201, 30, 2550.00),
(2, 102, 202, 40, 3000.00),
(3, 101, 203, 25, 1575.00),
(4, 103, 201, 50, 2200.00),
(5, 104, 202, 45, 1850.00),
(6, 105, 204, 35, 2725.00),
(7, 106, 203, 20, 1600.00),
(8, 107, 202, 55, 1975.00),
(9, 108, 201, 60, 2000.00),
(10, 109, 204, 25, 2400.00);

/*
EXPECTED OUTPUT:
-------------------------------
| CUSTOMER_ID | TOTAL_EXPENSE |
|-------------|---------------|
| 101         | 4125          |
-------------------------------
*/

-- solution
select * from Orders;

select
customer_id,
sum(total_cost) as total_expense
from orders
group by customer_id
order by total_expense desc
limit 1
