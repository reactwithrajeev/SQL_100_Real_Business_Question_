CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    region VARCHAR(20)
);

INSERT INTO regions (region) VALUES
('North'), ('South'), ('East'), ('West');

SELECT * FROM REGIONS;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    region_id INT REFERENCES regions(region_id)
);

INSERT INTO customers (customer_name, region_id) VALUES
('Alice', 1), ('Bob', 2), ('Carla', 3), ('David', 4),
('Eva', 1), ('Frank', 2), ('Grace', 3), ('Henry', 4),
('Ivy', 1), ('Jack', 2);

SELECT * FROM CUSTOMERS;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50)
);

INSERT INTO products (product_name) VALUES
('Laptop'), ('Mouse'), ('Keyboard'), ('Monitor'), ('Printer');

SELECT * FROM PRODUCTS;

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    unit_price DECIMAL(10, 2),
    sale_date DATE
);

INSERT INTO sales (customer_id, product_id, quantity, unit_price, sale_date) VALUES
(1, 1, 2, 700.00, '2024-01-10'), (1, 2, 5, 25.00, '2024-01-15'),
(2, 1, 1, 700.00, '2024-01-16'), (2, 3, 3, 45.00, '2024-02-03'),
(3, 2, 10, 25.00, '2024-02-05'), (3, 4, 2, 150.00, '2024-02-10'),
(4, 5, 1, 200.00, '2024-02-18'), (4, 1, 1, 700.00, '2024-02-22'),
(5, 3, 4, 45.00, '2024-03-01'), (5, 5, 1, 200.00, '2024-03-05'),
(6, 1, 3, 700.00, '2024-03-10'), (6, 4, 1, 150.00, '2024-03-12'),
(7, 2, 6, 25.00, '2024-03-14'), (7, 5, 1, 200.00, '2024-03-16'),
(8, 1, 1, 700.00, '2024-03-18'), (8, 3, 2, 45.00, '2024-03-21');

SELECT * FROM SALES;

-- QNS 4 OF 100 : Find the top 2 revenue-generating products in each region for Q1 2024

SELECT
	PRODUCT_NAME,
	REGION,
	TOTAL_REVENUE
FROM
	(
		SELECT
			P.PRODUCT_NAME,
			R.REGION,
			SUM(S.UNIT_PRICE * S.QUANTITY) AS TOTAL_REVENUE,
			RANK() OVER (
				PARTITION BY
					R.REGION
				ORDER BY
					SUM(S.UNIT_PRICE * S.QUANTITY) DESC
			) AS REVENUE_RANK
		FROM
			PRODUCTS P
			JOIN SALES S ON P.PRODUCT_ID = S.PRODUCT_ID
			JOIN CUSTOMERS C ON C.CUSTOMER_ID = S.CUSTOMER_ID
			JOIN REGIONS R ON C.REGION_ID = R.REGION_ID
		WHERE
			S.SALE_DATE BETWEEN '2024-01-01' AND '2024-03-31'
		GROUP BY
			P.PRODUCT_NAME,
			R.REGION
	) PROD_REVENUE
WHERE
	REVENUE_RANK <= 2
ORDER BY
	REGION,
	TOTAL_REVENUE DESC;