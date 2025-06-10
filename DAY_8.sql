-- DAY 8 0F 100 : Compare monthly revenue growth by region for the year 2024 and 
-- identify the region with the highest average monthly growth

CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    region TEXT,
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL
);

INSERT INTO sales_data VALUES
(1, 'North', '2024-01-15', 10, 100),
(2, 'North', '2024-02-10', 12, 100),
(3, 'North', '2024-03-12', 15, 100),
(4, 'South', '2024-01-20', 8, 120),
(5, 'South', '2024-02-18', 10, 120),
(6, 'South', '2024-03-25', 15, 120),
(7, 'East', '2024-01-05', 5, 90),
(8, 'East', '2024-02-15', 6, 90),
(9, 'East', '2024-03-10', 9, 90),
(10, 'West', '2024-01-08', 10, 110),
(11, 'West', '2024-02-11', 11, 110),
(12, 'West', '2024-03-15', 14, 110);

SELECT * FROM SALES_DATA;

WITH
	TOTAL_REVENUE AS (
		SELECT
			REGION,
			CAST((DATE_TRUNC('MONTH', SALE_DATE)) AS DATE) AS SALE_MONTH,
			SUM(QUANTITY * UNIT_PRICE) AS REVENUE
		FROM
			SALES_DATA
		WHERE
			EXTRACT(
				YEAR
				FROM
					SALE_DATE
			) = 2024
		GROUP BY
			REGION,
			SALE_MONTH
	),
	MONTHLY_GROWTH AS (
		SELECT
			REGION,
			SALE_MONTH,
			REVENUE,
			LAG(REVENUE) OVER (
				PARTITION BY
					REGION
				ORDER BY
					SALE_MONTH
			) AS PREV_MONTH_REVENUE
		FROM
			TOTAL_REVENUE
	),
	GROWTH_CALC AS (
		SELECT
			REGION,
			SALE_MONTH,
			REVENUE,
			CASE
				WHEN PREV_MONTH_REVENUE IS NOT NULL
				AND PREV_MONTH_REVENUE != 0 THEN ROUND(
					(
						(REVENUE - PREV_MONTH_REVENUE) / PREV_MONTH_REVENUE
					) * 100,
					2
				)
				ELSE NULL
			END AS MONTHLY_GROWTH_PERCENTAGE
		FROM
			MONTHLY_GROWTH
	)
SELECT
	REGION,
	ROUND(AVG(MONTHLY_GROWTH_PERCENTAGE), 2) AS AVG_MONTHLY_GROWTH
FROM
	GROWTH_CALC
GROUP BY
	REGION
ORDER BY
	AVG_MONTHLY_GROWTH DESC;




