-- Day 14 of 100 : For each region, find the top 2 products with the highest total sales amount in the last 7 days. 
-- For each of these products, show the daily sales trend and the cumulative (running) total of sales amount day by day.

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
('2025-06-01', 'North', 'Laptop', 101, 1, 1200.00),
('2025-06-01', 'East', 'Tablet', 102, 2, 800.00),
('2025-06-01', 'West', 'Phone', 103, 3, 1800.00),
('2025-06-02', 'North', 'Laptop', 104, 2, 2400.00),
('2025-06-02', 'East', 'Tablet', 105, 1, 400.00),
('2025-06-02', 'West', 'Phone', 106, 1, 600.00),
('2025-06-03', 'North', 'Tablet', 107, 1, 400.00),
('2025-06-03', 'East', 'Phone', 108, 2, 1200.00),
('2025-06-03', 'West', 'Laptop', 109, 1, 1200.00),
('2025-06-04', 'North', 'Phone', 110, 2, 1200.00),
('2025-06-04', 'East', 'Laptop', 111, 1, 1200.00),
('2025-06-04', 'West', 'Tablet', 112, 2, 800.00),
('2025-06-05', 'North', 'Laptop', 113, 1, 1200.00),
('2025-06-05', 'East', 'Tablet', 114, 2, 800.00),
('2025-06-05', 'West', 'Phone', 115, 1, 600.00),
('2025-06-06', 'North', 'Tablet', 116, 1, 400.00),
('2025-06-06', 'East', 'Phone', 117, 3, 1800.00),
('2025-06-06', 'West', 'Laptop', 118, 2, 2400.00),
('2025-06-07', 'North', 'Phone', 119, 1, 600.00),
('2025-06-07', 'East', 'Laptop', 120, 2, 2400.00),
('2025-06-07', 'West', 'Tablet', 121, 1, 400.00);

select * from sales;

WITH
	LAST_7_DAYS AS (
		SELECT
			*
		FROM
			SALES
		WHERE
			SALE_DATE BETWEEN '2025-06-01' AND '2025-06-07'
	),
	PRODUCT_TOTAL AS (
		SELECT
			REGION,
			PRODUCT,
			SUM(AMOUNT) AS TOTAL_SALES
		FROM
			LAST_7_DAYS
		GROUP BY
			REGION,
			PRODUCT
		ORDER BY
			REGION
	),
	PRODUCT_RANK AS (
		SELECT
			REGION,
			PRODUCT,
			TOTAL_SALES,
			ROW_NUMBER() OVER (
				PARTITION BY
					REGION
				ORDER BY
					TOTAL_SALES DESC
			) AS PROD_RANK
		FROM
			PRODUCT_TOTAL
		ORDER BY
			REGION,
			TOTAL_SALES DESC
	),
	FILTERED_SALES AS (
		SELECT
			L.REGION,
			L.PRODUCT,
			L.SALE_DATE,
			L.AMOUNT
		FROM
			LAST_7_DAYS L
			JOIN PRODUCT_RANK P ON L.PRODUCT = P.PRODUCT
			AND L.REGION = P.REGION
		WHERE
			P.PROD_RANK <= 2
		ORDER BY
			REGION
	)
SELECT
	REGION,
	PRODUCT,
	SALE_DATE,
	SUM(AMOUNT) AS DAILY_SALES,
	SUM(SUM(AMOUNT)) OVER (
		PARTITION BY
			REGION,
			PRODUCT
		ORDER BY
			SALE_DATE ROWS BETWEEN UNBOUNDED PRECEDING
			AND CURRENT ROW
	) AS RUNNING_TOTAL
FROM
	FILTERED_SALES
GROUP BY
	REGION,
	PRODUCT,
	SALE_DATE
ORDER BY
	REGION,
	PRODUCT,
	SALE_DATE





	
