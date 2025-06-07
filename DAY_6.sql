-- DAY 6 OF 100 : Which products had a sales increase of more than 20% in Q2 2024 compared to Q1 2024?

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name TEXT
);

INSERT INTO products VALUES
(101, 'Laptop'),
(102, 'Chair'),
(103, 'T-Shirt'),
(104, 'Book'),
(105, 'Rice Bag');

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT
);

INSERT INTO sales VALUES
(1, 101, '2024-01-10', 10),
(2, 101, '2024-04-15', 15),
(3, 102, '2024-01-20', 8),
(4, 102, '2024-04-25', 7),
(5, 103, '2024-02-05', 20),
(6, 103, '2024-04-02', 30),
(7, 104, '2024-03-10', 25),
(8, 104, '2024-04-11', 15),
(9, 105, '2024-02-12', 5),
(10, 105, '2024-05-05', 8);

SELECT * FROM PRODUCTS;
SELECT * FROM sales;

WITH
	Q1_SALES AS (
		SELECT
			PRODUCT_ID,
			SUM(QUANTITY) AS Q1_QTY
		FROM
			SALES
		WHERE
			SALE_DATE BETWEEN '2024-01-01' AND '2024-03-31'
		GROUP BY
			PRODUCT_ID
	),
	Q2_SALES AS (
		SELECT
			PRODUCT_ID,
			SUM(QUANTITY) AS Q2_QTY
		FROM
			SALES
		WHERE
			SALE_DATE BETWEEN '2024-04-01' AND '2024-06-30'
		GROUP BY
			PRODUCT_ID
	)
SELECT
	P.PRODUCT_NAME,
	Q1.Q1_QTY,
	Q2.Q2_QTY,
	ROUND(((Q2.Q2_QTY - Q1.Q1_QTY) * 100.00) / Q1.Q1_QTY, 2) AS GROWTH_PERCENT
FROM
	Q1_SALES Q1
	JOIN Q2_SALES Q2 ON Q1.PRODUCT_ID = Q2.PRODUCT_ID
	JOIN PRODUCTS P ON Q2.PRODUCT_ID = P.PRODUCT_ID 
	WHERE
	ROUND(((Q2.Q2_QTY - Q1.Q1_QTY) * 100.00) / Q1.Q1_QTY, 2) > 20.00;






