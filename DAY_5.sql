-- DAY 5 OF 100 : Identify customers who purchased from 3 or more different product categories in Q1 2024.

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name TEXT
);

INSERT INTO customers VALUES
(1, 'Anjali'),
(2, 'Ravi'),
(3, 'Neha'),
(4, 'Karan'),
(5, 'Pooja');

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name TEXT
);

INSERT INTO categories VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Clothing'),
(4, 'Books'),
(5, 'Groceries');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name TEXT,
    category_id INT
);

INSERT INTO products VALUES
(101, 'Laptop', 1),
(102, 'Chair', 2),
(103, 'T-Shirt', 3),
(104, 'Novel', 4),
(105, 'Rice Bag', 5);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT
);

INSERT INTO sales VALUES
(1, 1, 101, '2024-01-05', 1),
(2, 1, 102, '2024-01-12', 2),
(3, 1, 103, '2024-01-20', 1),
(4, 2, 101, '2024-01-15', 1),
(5, 2, 104, '2024-02-02', 1),
(6, 3, 105, '2024-01-28', 2),
(7, 3, 103, '2024-02-10', 1),
(8, 4, 102, '2024-01-07', 1),
(9, 4, 104, '2024-02-15', 1),
(10, 4, 105, '2024-03-10', 1),
(11, 5, 101, '2024-01-05', 1),
(12, 5, 102, '2024-01-12', 1),
(13, 5, 103, '2024-02-20', 1),
(14, 5, 104, '2024-03-10', 1);

SELECT * FROM CUSTOMERS;
SELECT * FROM CATEGORIES;
SELECT * FROM PRODUCTS;
SELECT * FROM SALES;

SELECT
	CX.CUSTOMER_ID,
	CX.CUSTOMER_NAME,
	COUNT(DISTINCT C.CATEGORY_ID) AS CATEGORY_COUNT
FROM
	CUSTOMERS CX
	JOIN SALES S ON S.CUSTOMER_ID = CX.CUSTOMER_ID
	JOIN PRODUCTS P ON S.PRODUCT_ID = P.PRODUCT_ID
	JOIN CATEGORIES C ON P.CATEGORY_ID = C.CATEGORY_ID
WHERE
	SALE_DATE BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY
	CX.CUSTOMER_ID,
	CX.CUSTOMER_NAME
HAVING
	COUNT(DISTINCT C.CATEGORY_ID) >= 3;

