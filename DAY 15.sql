-- DAY 15 OF 100 : Identify repeat customers and analyze their purchasing patterns:
-- For each region and product, find customers who made purchases on at least two different days in the last 7 days. For these repeat customers, show:
-- The number of distinct purchase days
-- Their total quantity purchased
-- Their total sales amount
-- The average days between their purchases (purchase frequency)

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
('2025-06-20', 'North', 'Laptop', 101, 1, 1200.00),
('2025-06-22', 'North', 'Laptop', 101, 2, 2400.00),
('2025-06-24', 'North', 'Laptop', 101, 1, 1200.00),
('2025-06-21', 'East', 'Tablet', 102, 2, 800.00),
('2025-06-23', 'East', 'Tablet', 102, 1, 400.00),
('2025-06-20', 'West', 'Phone', 103, 3, 1800.00),
('2025-06-25', 'West', 'Phone', 103, 1, 600.00),
('2025-06-21', 'North', 'Laptop', 104, 2, 2400.00),
('2025-06-23', 'North', 'Laptop', 104, 1, 1200.00),
('2025-06-22', 'East', 'Tablet', 105, 1, 400.00),
('2025-06-24', 'East', 'Tablet', 105, 2, 800.00),
('2025-06-22', 'West', 'Laptop', 106, 1, 1200.00),
('2025-06-26', 'West', 'Laptop', 106, 2, 2400.00),
('2025-06-23', 'North', 'Phone', 107, 2, 1200.00),
('2025-06-25', 'North', 'Phone', 107, 1, 600.00),
('2025-06-23', 'East', 'Laptop', 108, 1, 1200.00),
('2025-06-26', 'East', 'Laptop', 108, 2, 2400.00),
('2025-06-24', 'West', 'Tablet', 109, 2, 800.00),
('2025-06-26', 'West', 'Tablet', 109, 1, 400.00),
('2025-06-24', 'North', 'Laptop', 110, 1, 1200.00),
('2025-06-26', 'North', 'Laptop', 110, 1, 1200.00),
('2025-06-25', 'East', 'Phone', 111, 3, 1800.00),
('2025-06-26', 'East', 'Phone', 111, 1, 600.00),
('2025-06-25', 'West', 'Laptop', 112, 2, 2400.00),
('2025-06-26', 'West', 'Laptop', 112, 1, 1200.00);

SELECT * FROM SALES;

WITH
	LAST_7_DAYS AS (
		SELECT
			*
		FROM
			SALES
		WHERE
			SALE_DATE BETWEEN '2025-06-20' AND '2025-06-26'
	),
	CUSTOMER_ACTIVITY AS (
		SELECT
			REGION,
			PRODUCT,
			CUSTOMER_ID,
			COUNT(DISTINCT SALE_DATE) AS PURCHASED_DAYS,
			SUM(QUANTITY) AS TOTAL_QUANTITY,
			SUM(AMOUNT) AS TOTAL_AMOUNT,
			ARRAY_AGG(
				DISTINCT SALE_DATE
				ORDER BY
					SALE_DATE
			) AS PURCHASED_DATES
		FROM
			LAST_7_DAYS
		GROUP BY
			REGION,
			PRODUCT,
			CUSTOMER_ID
		HAVING
			COUNT(DISTINCT SALE_DATE) >= 2
	)
SELECT
	REGION,
	PRODUCT,
	CUSTOMER_ID,
	PURCHASED_DAYS,
	TOTAL_QUANTITY,
	TOTAL_AMOUNT,
	CASE
		WHEN PURCHASED_DAYS > 1 THEN ROUND(
			(
				PURCHASED_DATES[ARRAY_LENGTH(PURCHASED_DATES, 1)] - PURCHASED_DATES[1]
			) / (PURCHASED_DAYS -1),
			2
		)
		ELSE NULL
	END AS AVG_PURCHASED_DAYS
FROM
	CUSTOMER_ACTIVITY;




