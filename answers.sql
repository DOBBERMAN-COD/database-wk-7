-- Question 1: Achieving 1NF (First Normal Form)

-- Query to transform the table into 1NF by splitting the Products column into separate rows:
SELECT OrderID, CustomerName,
TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product
FROM ProductDetail
CROSS JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
) AS numbers
WHERE numbers.n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1
ORDER BY OrderID, numbers.n;

-- Question 2: Achieving 2NF (Second Normal Form)

-- Create Orders table (OrderID -> CustomerName):
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create OrderItems table (OrderID, Product -> Quantity):
CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;

