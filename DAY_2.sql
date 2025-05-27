-- DAY 2/100 OF REAL BUSINESS QUESTION IN SQL

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    segment VARCHAR(20),       -- e.g., Consumer, SMB, Enterprise
    region VARCHAR(20),        -- e.g., North, South, East, West
    signup_date DATE
);

INSERT INTO customers (customer_name, segment, region, signup_date) VALUES
('Alice',  'Consumer',   'North', '2023-11-18'),
('Bob',    'SMB',        'South', '2023-12-02'),
('Carla',  'Enterprise', 'East',  '2023-10-25'),
('David',  'Consumer',   'West',  '2023-09-19'),
('Eva',    'SMB',        'North', '2023-11-03'),
('Frank',  'Enterprise', 'South', '2023-10-11'),
('Grace',  'Consumer',   'East',  '2023-12-14'),
('Henry',  'SMB',        'West',  '2023-11-27');

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO orders (customer_id, order_date, amount) VALUES
-- January 2024
(1, '2024-01-04', 120.00),
(2, '2024-01-05', 350.00),
(3, '2024-01-06', 1250.00),
(4, '2024-01-10',  90.00),
(5, '2024-01-11', 400.00),
(6, '2024-01-12', 980.00),
(7, '2024-01-13', 150.00),
(8, '2024-01-14', 300.00),
-- February 2024
(1, '2024-02-01', 140.00),
(2, '2024-02-03', 370.00),
(3, '2024-02-05', 1100.00),
(4, '2024-02-07',  95.00),
(5, '2024-02-09', 420.00),
(6, '2024-02-11',1050.00),
-- March 2024
(7, '2024-03-02', 160.00),
(8, '2024-03-04', 310.00),
(1, '2024-03-10', 130.00),
(2, '2024-03-12', 360.00),
(3, '2024-03-14',1150.00),
(6, '2024-03-20',1020.00);

SELECT * FROM ORDERS;

--Q2: How many orders were placed from each region in Q1 2024?
SELECT
	REGION,
	COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM
	CUSTOMERS
	JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
WHERE
	ORDER_DATE BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY
	REGION
ORDER BY
	TOTAL_ORDERS DESC;


