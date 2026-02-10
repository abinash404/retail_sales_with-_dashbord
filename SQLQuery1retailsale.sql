SELECT * FROM OnlineRetail;

SELECT * FROM OnlineRetail
WHERE Country='United Kingdom';


--Phase 1: Data Quality Check

--checking Negative quantities 

SELECT * FROM OnlineRetail
WHERE Country='United Kingdom' AND Quantity<0;


--Checking nulls in customerid
SELECT * FROM OnlineRetail
WHERE Country ='United Kingdom' AND CustomerID IS Null;

USE linkdinRetal

SELECT COUNT(*) AS nullCustomers
FROM OnlineRetail
WHERE  CustomerID IS Null;

--Validate data types
--quality should be a no
SELECT *
FROM OnlineRetail
WHERE TRY_CAST(Quantity AS INT) IS NULL
AND QUANTITY IS NOT NULL;

---checking date
SELECT *
FROM OnlineRetail
WHERE TRY_CAST(InvoiceDate AS DATETIME) IS NULL
AND InvoiceDate IS NOT NULL;

--checking all columns
SELECT *
FROM OnlineRetail
WHERE TRY_CAST(Quantity AS INT) IS NULL
OR TRY_CAST(InvoiceDate AS DATE) IS NULL
OR TRY_CAST(CustomerID AS INT) IS NULL
 OR TRY_CAST(InvoiceNo AS INT) IS NULL;


--cleaning data

--Step 1: Filter your dataset 

SELECT *
FROM OnlineRetail
WHERE Country = 'United Kingdom'
  AND InvoiceNo NOT LIKE 'C%';

-- step 2:Create calculated field 
SELECT * , (Quantity * UnitPrice) AS TotalPrice
From OnlineRetail


--Phase 3: Run Your Analysis
--Analysis 1: Top 10 Bestselling Products
SELECT TOP 10 Description ,SUM(Quantity) AS TotalSold
FROM OnlineRetail
GROUP BY Description 
ORDER BY TotalSold DESC

--Analysis 2: Top 10 Revenue Products
SELECT TOP 10 Description , ROUND(SUM (Quantity * UnitPrice),2) AS TotalPrice
FROM OnlineRetail
GROUP BY Description
ORDER BY TotalPrice DESC

---FOR UNITED KINGDOM
SELECT TOP 10 Description , ROUND(SUM (Quantity * UnitPrice),2) AS TotalPrice
FROM OnlineRetail
WHERE Country='United Kingdom' AND InvoiceNo NOT LIKE 'C%'
GROUP BY Description
ORDER BY TotalPrice DESC;

--Analysis 3: Sales by Hour
SELECT
    CAST(InvoiceDate AS TIME) AS OrderTime
FROM OnlineRetail;

--Extract hour from InvoiceDate
SELECT *, DATEPART(HOUR , InvoiceDate)AS OrderHour
FROM OnlineRetail

--Analysis 4: Sales by Day of Week
SELECT
    DATENAME(WEEKDAY, InvoiceDate) AS DayName,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM OnlineRetail
WHERE Country = 'United Kingdom'
  AND InvoiceNo NOT LIKE 'C%'
GROUP BY 
    DATENAME(WEEKDAY, InvoiceDate),
    DATEPART(WEEKDAY, InvoiceDate)
ORDER BY DATEPART(WEEKDAY, InvoiceDate);







--Group by hour, sum TotalSales , revenue(extra)
SELECT
    DATEPART(HOUR, InvoiceDate) AS Hour,
    SUM(Quantity) AS TotalSold,
    SUM(Quantity * UnitPrice) AS Revenue
FROM OnlineRetail
WHERE Country = 'United Kingdom'
  AND InvoiceNo NOT LIKE 'C%'
GROUP BY DATEPART(HOUR, InvoiceDate)
ORDER BY Hour;


--Analysis 4: Sales by Day of Week
USE linkdinRetal;
SELECT
    DATENAME(WEEKDAY, InvoiceDate) AS DayName,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM OnlineRetail
WHERE Country = 'United Kingdom'
  AND InvoiceNo NOT LIKE 'C%'
GROUP BY 
    DATENAME(WEEKDAY, InvoiceDate),
    DATEPART(WEEKDAY, InvoiceDate)
ORDER BY DATEPART(WEEKDAY, InvoiceDate);

Select * FROM OnlineRetail
--count invoice no
SELECT COUNT(InvoiceNo) FROM  OnlineRetail



--total price
SELECT SUM(UnitPrice) AS Total_Revenue FROM OnlineRetail;

--avarage order value
SELECT SUM (UnitPrice)/ COUNT( InvoiceNo) AS AvarageOrderValue
FROM OnlineRetail;

--total no of item sold
SELECT SUM(Quantity) AS TotalItemSold 
FROM OnlineRetail;

--total order 
SELECT COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM OnlineRetail;


--total sales country wise
SELECT SUM(UnitPrice) AS CountryWiseSales
FROM OnlineRetail
GROUP BY Country

--top 10 best customers
SELECT SUM(Quantity) AS Amount,CustomerID
FROM OnlineRetail
GROUP BY CustomerID
ORDER BY Amount DESC


--Daily traind for total order
SELECT
    DATENAME(WEEKDAY, InvoiceDate) AS DayName,
    COUNT(InvoiceNo) AS totalOrders
FROM OnlineRetail

GROUP BY 
    DATENAME(WEEKDAY, InvoiceDate),
    DATEPART(WEEKDAY, InvoiceDate)
ORDER BY DATEPART(WEEKDAY, InvoiceDate);






