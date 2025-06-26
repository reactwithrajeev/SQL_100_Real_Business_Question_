-- DAY 12 OF 100 : 
-- For the last 7 days (2025-06-14 to 2025-06-20), identify for each region:
-- The product with the highest sales growth rate compared to the previous 7 days (2025-06-07 to 2025-06-13).
-- For that product, show the total sales in both periods, the growth rate (as a percentagE).

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    region VARCHAR(50) NOT NULL,
    product VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    quantity INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO sales (sale_date, region, product, customer_id, quantity, amount) VALUES
('2025-06-10', 'North', 'Laptop', 101, 2, 2000.00),
('2025-06-10', 'East', 'Tablet', 102, 3, 900.00),
('2025-06-10', 'South', 'Phone', 103, 5, 2500.00),
('2025-06-11', 'North', 'Laptop', 104, 1, 1000.00),
('2025-06-11', 'West', 'Tablet', 105, 4, 1200.00),
('2025-06-11', 'East', 'Phone', 106, 2, 1000.00),
('2025-06-12', 'South', 'Laptop', 101, 3, 3000.00),
('2025-06-12', 'West', 'Tablet', 102, 1, 300.00),
('2025-06-12', 'North', 'Phone', 103, 2, 1000.00),
('2025-06-13', 'East', 'Laptop', 104, 2, 2000.00),
('2025-06-13', 'South', 'Tablet', 105, 3, 900.00),
('2025-06-13', 'West', 'Phone', 106, 4, 2000.00),
('2025-06-14', 'North', 'Laptop', 101, 2, 2000.00),
('2025-06-14', 'East', 'Tablet', 102, 2, 600.00),
('2025-06-14', 'South', 'Phone', 103, 3, 1500.00),
('2025-06-15', 'West', 'Laptop', 104, 1, 1000.00),
('2025-06-15', 'North', 'Tablet', 105, 4, 1200.00),
('2025-06-15', 'East', 'Phone', 106, 2, 1000.00),
('2025-06-16', 'South', 'Laptop', 101, 3, 3000.00),
('2025-06-16', 'West', 'Tablet', 102, 1, 300.00),
('2025-06-16', 'North', 'Phone', 103, 2, 1000.00),
('2025-06-17', 'East', 'Laptop', 104, 2, 2000.00),
('2025-06-17', 'South', 'Tablet', 105, 3, 900.00),
('2025-06-17', 'West', 'Phone', 106, 4, 2000.00),
('2025-06-18', 'North', 'Laptop', 101, 2, 2000.00),
('2025-06-18', 'East', 'Tablet', 102, 2, 600.00),
('2025-06-18', 'South', 'Phone', 103, 3, 1500.00),
('2025-06-19', 'West', 'Laptop', 104, 1, 1000.00),
('2025-06-19', 'North', 'Tablet', 105, 4, 1200.00),
('2025-06-19', 'East', 'Phone', 106, 2, 1000.00),
('2025-06-20', 'South', 'Laptop', 101, 3, 3000.00),
('2025-06-20', 'West', 'Tablet', 102, 1, 300.00),
('2025-06-20', 'North', 'Phone', 103, 2, 1000.00);

SELECT * FROM SALES;

WITH SALES_PERIOD AS (SELECT
REGION,
PRODUCT,
CUSTOMER_ID,
CASE 
	WHEN SALE_DATE BETWEEN '2025-06-07' AND '2025-06-13' THEN 'PREV'
	WHEN SALE_DATE BETWEEN '2025-06-14' AND '2025-06-20' THEN 'LAST'
	END AS PERIODS,
AMOUNT
FROM SALES
WHERE SALE_DATE BETWEEN '2025-06-07' AND '2025-06-20'),
PRODUCT_SALES AS (SELECT
REGION,
PRODUCT,
PERIODS,
SUM(AMOUNT) AS TOTAL_SALES
FROM SALES_PERIOD
GROUP BY REGION,PRODUCT,PERIODS),
SALE_GROWTH_PERC AS (SELECT
TS1.REGION,
TS1.PRODUCT,
COALESCE(TS1.TOTAL_SALES,0) AS PREV7_DAYS_SALES,
COALESCE(TS2.TOTAL_SALES,0) AS LAST7_DAYS_SALES,
ROUND(((TS2.TOTAL_SALES - TS1.TOTAL_SALES)*100)/TS1.TOTAL_SALES,2) AS GROWTH_PERC
FROM PRODUCT_SALES TS1
JOIN PRODUCT_SALES TS2 ON TS1.REGION = TS2.REGION AND TS1.PRODUCT=TS2.PRODUCT AND TS2.PERIODS = 'LAST'
WHERE TS1.PERIODS = 'PREV'),
MAX_GROWTH AS (SELECT
*,
RANK() OVER(PARTITION BY REGION ORDER BY GROWTH_PERC DESC ) AS GROWTH_RANK
FROM SALE_GROWTH_PERC)
SELECT
*
FROM MAX_GROWTH
WHERE GROWTH_RANK = 1;





	


