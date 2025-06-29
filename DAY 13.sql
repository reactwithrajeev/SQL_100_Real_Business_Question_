-- Day 13 of 100 : For each region and product combination, calculate:
-- Monthly total sales
-- Month-over-Month (MoM) sales growth rate (%)
-- 3-month moving average of sales
-- Monthly sales rank within each region-product group (1 = highest sales)

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
('2025-03-01', 'North', 'Laptop', 101, 2, 2000.00),
('2025-03-02', 'East', 'Tablet', 102, 3, 900.00),
('2025-03-03', 'South', 'Phone', 103, 5, 2500.00),
('2025-03-04', 'North', 'Laptop', 104, 1, 1000.00),
('2025-03-05', 'West', 'Tablet', 105, 4, 1200.00),
('2025-03-06', 'East', 'Phone', 106, 2, 1000.00),
('2025-03-07', 'South', 'Laptop', 101, 3, 3000.00),
('2025-03-08', 'West', 'Tablet', 102, 1, 300.00),
('2025-03-09', 'North', 'Phone', 103, 2, 1000.00),
('2025-04-01', 'East', 'Laptop', 104, 2, 2000.00),
('2025-04-02', 'South', 'Tablet', 105, 3, 900.00),
('2025-04-03', 'West', 'Phone', 106, 4, 2000.00),
('2025-04-04', 'North', 'Laptop', 101, 2, 2000.00),
('2025-04-05', 'East', 'Tablet', 102, 2, 600.00),
('2025-04-06', 'South', 'Phone', 103, 3, 1500.00),
('2025-04-07', 'West', 'Laptop', 104, 1, 1000.00),
('2025-04-08', 'North', 'Tablet', 105, 4, 1200.00),
('2025-04-09', 'East', 'Phone', 106, 2, 1000.00),
('2025-05-01', 'South', 'Laptop', 101, 3, 3000.00),
('2025-05-02', 'West', 'Tablet', 102, 1, 300.00),
('2025-05-03', 'North', 'Phone', 103, 2, 1000.00),
('2025-05-04', 'East', 'Laptop', 104, 2, 2000.00),
('2025-05-05', 'South', 'Tablet', 105, 3, 900.00),
('2025-05-06', 'West', 'Phone', 106, 4, 2000.00),
('2025-05-07', 'North', 'Laptop', 101, 2, 2000.00),
('2025-05-08', 'East', 'Tablet', 102, 2, 600.00),
('2025-05-09', 'South', 'Phone', 103, 3, 1500.00),
('2025-05-10', 'West', 'Laptop', 104, 1, 1000.00),
('2025-05-11', 'North', 'Tablet', 105, 4, 1200.00),
('2025-05-12', 'East', 'Phone', 106, 2, 1000.00);


select * from sales;

WITH
	MONTHLY_SALES AS (
		SELECT
			REGION,
			PRODUCT,
			DATE_TRUNC('MONTH', SALE_DATE)::DATE AS SALE_MONTH,
			SUM(AMOUNT) AS TOTAL_SALES
		FROM
			SALES
		GROUP BY
			1,
			2,
			3
	),
	MOM_STATS AS (
		SELECT
			*,
			LAG(TOTAL_SALES) OVER (
				PARTITION BY
					REGION,
					PRODUCT
				ORDER BY
					SALE_MONTH
			) AS PREV_MONTH_SALES,
			ROUND(
				AVG(TOTAL_SALES) OVER (
					PARTITION BY
						REGION,
						PRODUCT
					ORDER BY
						SALE_MONTH ROWS BETWEEN 2 PRECEDING
						AND CURRENT ROW
				),
				2
			) AS MONTHLY_AVG_3M
		FROM
			MONTHLY_SALES
	)
SELECT
	REGION,
	PRODUCT,
	SALE_MONTH,
	TOTAL_SALES,
	PREV_MONTH_SALES,
	MONTHLY_AVG_3M,
	ROUND(
		(
			(TOTAL_SALES - PREV_MONTH_SALES) / PREV_MONTH_SALES
		) * 100,
		2
	) AS GROWTH_PERC,
	DENSE_RANK() OVER (
		PARTITION BY
			REGION,
			PRODUCT
		ORDER BY
			TOTAL_SALES DESC
	) AS MONTHLY_RANK
FROM
	MOM_STATS;






