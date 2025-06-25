-- DAY 11 OF 100 : Calculate the running total of sales amount for each day in the last 7 days, 
-- and also show the percentage contribution of each day's sales to the total sales in that period. Order the results by date ascending.

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO sales (sale_date, amount) VALUES
('2025-06-10', 1000.00),
('2025-06-10', 500.00),
('2025-06-11', 750.00),
('2025-06-11', 300.00),
('2025-06-12', 1200.00),
('2025-06-12', 400.00),
('2025-06-13', 900.00),
('2025-06-13', 600.00),
('2025-06-14', 1500.00),
('2025-06-14', 200.00),
('2025-06-15', 800.00),
('2025-06-15', 450.00),
('2025-06-16', 1300.00),
('2025-06-16', 700.00),
('2025-06-17', 1100.00),
('2025-06-17', 650.00),
('2025-06-18', 1400.00),
('2025-06-18', 550.00),
('2025-06-19', 900.00),
('2025-06-19', 300.00),
('2025-06-20', 1000.00),
('2025-06-20', 400.00),
('2025-06-21', 850.00),
('2025-06-21', 450.00),
('2025-06-22', 1000.00),
('2025-06-22', 600.00),
('2025-06-23', 950.00),
('2025-06-23', 550.00),
('2025-06-24', 1200.00),
('2025-06-24', 700.00);

SELECT * FROM SALES;

WITH
	LAST_7DAYS_SALES AS (
		SELECT
			SALE_DATE,
			SUM(AMOUNT) AS DAILY_SALES
		FROM
			SALES
		WHERE
			SALE_DATE >= CURRENT_DATE - INTERVAL '7 DAYS'
		GROUP BY
			SALE_DATE
	),
	TOTAL_AMOUNT AS (
		SELECT
			SUM(DAILY_SALES) AS TOTAL_SALES
		FROM
			LAST_7DAYS_SALES
	)
SELECT
	S.SALE_DATE,
	S.DAILY_SALES,
	SUM(S.DAILY_SALES) OVER (
		ORDER BY
			S.SALE_DATE ROWS BETWEEN UNBOUNDED PRECEDING
			AND CURRENT ROW
	) AS RUNNING_TOTAL,
	ROUND((S.DAILY_SALES / T.TOTAL_SALES) * 100, 2) AS PERC_TOTAL
FROM
	LAST_7DAYS_SALES S
	CROSS JOIN TOTAL_AMOUNT T
ORDER BY
	S.SALE_DATE;