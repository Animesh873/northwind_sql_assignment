/* IMPORTANT INSTRUCTIONS FOR LEARNERS
1) DO NOT CHANGE THE ORDER OF COLUMNS.
2) YOUR QUERY SHOULD DISPLAY COLUMNS IN THE SAME ORDER AS MENTIONED IN ALL QUESTIONS.
3) YOU CAN FIND THE ORDER OF COLUMNS IN QUESTION TEMPLATE SECTION OF EACH QUESTION.
4) USE ALIASING AS MENTIONED IN QUESTION TEMPLATE FOR ALL COLUMNS
5) DO NOT CHANGE COLUMN NAMES*/
                   
-- Question 1 (Marks: 2)
-- Objective: Retrieve data using basic SELECT statements
-- List the names of all customers in the database.
-- Question Template: Display CustomerName Column

select CustomerName
from customers;

-- Question 2 (Marks: 2)
-- Objective: Apply filtering using the WHERE clause
-- Retrieve the names and prices of all products that cost less than $15.
-- Question Template: Display ProductName Column

select ProductName
from products
where price < 15;

-- Question 3 (Marks: 2)
-- Objective: Use SELECT to extract multiple fields
-- Display all employees first and last names.
-- Question Template: Display FirstName, LastName Columns

select FirstName, LastName
from employees;

-- Question 4 (Marks: 2)
-- Objective: Filter data using a function on date values
-- List all orders placed in the year 1997.
-- Question Template: Display OrderID, OrderDate Columns

select OrderID, OrderDate
from orders
where YEAR(OrderDate) = 1997;

-- Question 5 (Marks: 2)
-- Objective: Apply numeric filters
-- List all products that have a price greater than $50.
-- Question Template: Display ProductName, Price Column

select ProductName, Price
from products
where Price > 50;

-- Question 6 (Marks: 3)
-- Objective: Perform multi-table JOIN operations
-- Show the names of customers and the names of the employees who handled their orders.
-- Question Template: Display CustomerName, FirstName, LastName Columns

select Customers.CustomerName, Employees.FirstName, Employees.LastName
from orders
JOIN Customers on orders.CustomerID = Customers.CustomerID
JOIN Employees on orders.EmployeeID = employees.EmployeeID;


-- Question 7 (Marks: 3)
-- Objective: Use GROUP BY for aggregation
-- List each country along with the number of customers from that country.
-- Question Template: Display Country, CustomerCount Columns

Select Country, Count(*) as CustomerCount
from customers
Group by country;

-- Question 8 (Marks: 3)
-- Objective: Group data by a foreign key relationship and apply aggregation
-- Find the average price of products grouped by category.
-- Question Template: Display CategoryName, AvgPrice Columns

SELECT c.CategoryName, AVG(p.Price) AS AvgPrice
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;

-- Question 9 (Marks: 3)
-- Objective: Use aggregation to count records per group
-- Show the number of orders handled by each employee.
-- Question Template: Display EmployeeID, OrderCount Columns

select EmployeeID, Count(OrderID) as Ordercount
from orders
group by EmployeeID;

-- Question 10 (Marks: 3)
-- Objective: Filter results using values from a joined table
-- List the names of products supplied by "Exotic Liquids".
-- Question Template: Display ProductName Column

SELECT p.ProductName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Exotic Liquid';

-- Question 11 (Marks: 5)
-- Objective: Rank records using aggregation and sort
-- List the top 3 most ordered products (by quantity).
-- Question Template: Display ProductID, TotalOrdered Columns

SELECT ProductID, SUM(Quantity) AS TotalOrdered
FROM orderdetails
GROUP BY ProductID
ORDER BY TotalOrdered DESC LIMIT 3;


-- Question 12 (Marks: 5)
-- Objective: Use GROUP BY and HAVING to filter on aggregates
-- Find customers who have placed orders worth more than $10,000 in total.
-- Question Template: Display CustomerName, TotalSpent Columns

select c.CustomerName, Sum(od.Quantity * p.Price) as TotalSpent
from customers c
Join orders o on c.CustomerID = o.CustomerID
Join orderdetails od on o.OrderID = od.OrderID
Join products p on od.ProductID = p.ProductID
Group by c.CustomerID, c.CustomerName
having TotalSpent > 10000;


-- Question 13 (Marks: 5)
-- Objective: Aggregate and filter at the order level
-- Display order IDs and total order value for orders that exceed $2,000 in value.
-- Question Template: Display OrderID, OrderValue Columns

select od.OrderID, Sum(od.Quantity*p.price) as OrderValue
from orderdetails od
Join products p on od.ProductID= p.ProductID
group by od.OrderID
having OrderValue>2000;

-- Question 14 (Marks: 5)
-- Objective: Use subqueries in HAVING clause
-- Find the name(s) of the customer(s) who placed the largest single order (by value).
-- Question Template: Display CustomerName, OrderID, TotalValue Column

SELECT c.CustomerName, o.OrderID, SUM(od.Quantity*p.Price) as TotalValue
    FROM Orders o
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY o.OrderID, c.CustomerName
having TotalValue = (SELECT MAX(order_Total) from (select o2.OrderId, Sum(od2.Quantity*p2.Price) as order_Total
            FROM Orders o2
            JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
            JOIN Products p2 ON od2.ProductID = p2.ProductID
            GROUP BY o2.OrderID) as sub);

-- Question 15 (Marks: 5)
-- Objective: Identify records using NOT IN with subquery
-- Get a list of products that have never been ordered.
-- Question Template: Display ProductName Columns

SELECT ProductName
FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM OrderDetails);
