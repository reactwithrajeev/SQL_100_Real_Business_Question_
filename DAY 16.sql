-- DAY 16 of 100 : Sales Rep Performance & Customer Segmentation:
-- For each sales representative, identify their top customer (by total sales amount) in the last 7 days. 
-- For each sales rep and their top customer, show:
-- Total sales amount
-- Total quantity sold
-- Number of distinct products bought by the customer
-- The sales rep's rank by total sales among all reps

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    region VARCHAR(50) NOT NULL,
    product VARCHAR(50) NOT NULL,
    customer_id INT NOT NULL,
    quantity INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    sales_rep VARCHAR(50) NOT NULL
);

INSERT INTO sales (sale_date, region, product, customer_id, quantity, amount, sales_rep) VALUES
('2025-07-01', 'North', 'Laptop', 201, 1, 1200.00, 'Alice'),
('2025-07-01', 'East', 'Tablet', 202, 2, 800.00, 'Bob'),
('2025-07-01', 'West', 'Phone', 203, 3, 1800.00, 'Carol'),
('2025-07-02', 'North', 'Laptop', 204, 2, 2400.00, 'Alice'),
('2025-07-02', 'East', 'Tablet', 205, 1, 400.00, 'Bob'),
('2025-07-02', 'West', 'Phone', 206, 1, 600.00, 'Carol'),
('2025-07-03', 'North', 'Tablet', 207, 1, 400.00, 'Alice'),
('2025-07-03', 'East', 'Phone', 208, 2, 1200.00, 'Bob'),
('2025-07-03', 'West', 'Laptop', 209, 1, 1200.00, 'Carol'),
('2025-07-04', 'North', 'Phone', 210, 2, 1200.00, 'Alice'),
('2025-07-04', 'East', 'Laptop', 211, 1, 1200.00, 'Bob'),
('2025-07-04', 'West', 'Tablet', 212, 2, 800.00, 'Carol'),
('2025-07-05', 'North', 'Laptop', 213, 1, 1200.00, 'Alice'),
('2025-07-05', 'East', 'Tablet', 214, 2, 800.00, 'Bob'),
('2025-07-05', 'West', 'Phone', 215, 1, 600.00, 'Carol'),
('2025-07-06', 'North', 'Tablet', 216, 1, 400.00, 'Alice'),
('2025-07-06', 'East', 'Phone', 217, 3, 1800.00, 'Bob'),
('2025-07-06', 'West', 'Laptop', 218, 2, 2400.00, 'Carol'),
('2025-07-07', 'North', 'Phone', 219, 1, 600.00, 'Alice'),
('2025-07-07', 'East', 'Laptop', 220, 2, 2400.00, 'Bob'),
('2025-07-07', 'West', 'Tablet', 221, 1, 400.00, 'Carol');

SELECT * FROM SALES;

WITH LAST_7_DAYS AS (SELECT * 
FROM SALES 
WHERE SALE_DATE BETWEEN '2025-07-01' AND '2025-07-07'),
REP_CUST_SALES AS (SELECT
SALES_REP,
CUSTOMER_ID,
SUM(QUANTITY) AS TOTAL_QUANTITY,
SUM(AMOUNT) AS TOTAL_SALES,
COUNT(DISTINCT PRODUCT) AS TOTAL_PRODUCT
FROM LAST_7_DAYS
GROUP BY SALES_REP,
CUSTOMER_ID),
TOP_CUST_BY_REP AS (SELECT
*,
ROW_NUMBER() OVER(PARTITION BY SALES_REP ORDER BY TOTAL_SALES DESC) AS RN
FROM REP_CUST_SALES),
REPS_TOTAL AS (SELECT
SALES_REP,
SUM(TOTAL_SALES) AS REP_SALES
FROM TOP_CUST_BY_REP
GROUP BY SALES_REP),
REP_RANK AS (SELECT
SALES_REP,
REP_SALES,
RANK() OVER(ORDER BY REP_SALES DESC) AS SALES_REP_RANK
FROM REPS_TOTAL)
SELECT
T.SALES_REP,
T.CUSTOMER_ID,
T.TOTAL_QUANTITY,
T.TOTAL_SALES,
T.TOTAL_PRODUCT,
R.SALES_REP_RANK
FROM TOP_CUST_BY_REP T
JOIN REP_RANK R
ON T.SALES_REP = R.SALES_REP
WHERE T.RN = 1
ORDER BY R.SALES_REP_RANK, T.SALES_REP;


