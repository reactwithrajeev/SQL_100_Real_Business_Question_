-- DAY 7 OF 100 :For each product category, find the top-selling product based on total quantity sold in 2024.

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name TEXT,
    category TEXT
);

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Smartphone', 'Electronics'),
(103, 'Chair', 'Furniture'),
(104, 'Table', 'Furniture'),
(105, 'T-Shirt', 'Apparel'),
(106, 'Jeans', 'Apparel');

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT
);

INSERT INTO sales VALUES
(1, 101, '2024-01-10', 10),
(2, 102, '2024-03-05', 20),
(3, 103, '2024-02-15', 15),
(4, 104, '2024-05-01', 25),
(5, 105, '2024-04-22', 30),
(6, 106, '2024-06-05', 22),
(7, 101, '2024-05-20', 18),
(8, 102, '2024-06-10', 12),
(9, 103, '2024-03-15', 10),
(10, 104, '2024-04-10', 10),
(11, 105, '2024-06-15', 10),
(12, 106, '2024-06-20', 10);


SELECT * FROM PRODUCTS;
SELECT * FROM SALES;

SELECT
	CATEGORY,
	PRODUCT_NAME,
	TOTAL_SALES
FROM
	(
		SELECT
			P.CATEGORY,
			P.PRODUCT_NAME,
			SUM(S.QUANTITY) AS TOTAL_SALES,
			RANK() OVER (
				PARTITION BY
					P.CATEGORY
				ORDER BY
					SUM(S.QUANTITY) DESC
			) AS SALES_RANK
		FROM
			PRODUCTS P
			JOIN SALES S ON P.PRODUCT_ID = S.PRODUCT_ID
		WHERE
			S.SALE_DATE BETWEEN '2024-01-01' AND '2024-12-31'
		GROUP BY
			P.CATEGORY,
			P.PRODUCT_NAME
		ORDER BY
			P.CATEGORY,
			SALES_RANK
	)
WHERE
	SALES_RANK = 1;


