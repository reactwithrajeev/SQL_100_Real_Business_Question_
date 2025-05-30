-- DAY 3 OF 100 REAL  BUSINESS QUESTIONS SERIES IN SQL

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    segment VARCHAR(20),
    region VARCHAR(20),
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
('Henry',  'SMB',        'West',  '2023-11-27'),
('Ivy',    'Enterprise', 'North', '2023-08-15'),
('Jack',   'Consumer',   'South', '2023-07-22');

SELECT * FROM CUSTOMERS;

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO orders (customer_id, order_date, amount) VALUES
(1, '2024-01-04', 120.00), (2, '2024-01-05', 350.00),
(3, '2024-01-06',1250.00), (4, '2024-01-10',  90.00),
(5, '2024-01-11', 400.00), (6, '2024-01-12', 980.00),
(7, '2024-01-13', 150.00), (8, '2024-01-14', 300.00),
(9, '2024-01-16', 600.00), (10,'2024-01-18', 130.00),
(1, '2024-02-01', 140.00), (2, '2024-02-03', 370.00),
(3, '2024-02-05',1100.00), (4, '2024-02-07',  95.00),
(5, '2024-02-09', 420.00), (6, '2024-02-11',1050.00),
(7, '2024-02-15', 160.00), (8, '2024-02-18', 310.00),
(9, '2024-02-22', 700.00), (10,'2024-02-24', 135.00),
(1, '2024-03-10', 130.00), (2, '2024-03-12', 360.00),
(3, '2024-03-14',1150.00), (4, '2024-03-16',  92.00),
(5, '2024-03-17', 410.00), (6, '2024-03-18',1020.00),
(7, '2024-03-19', 170.00), (8, '2024-03-20', 330.00),
(9, '2024-03-21', 750.00), (10,'2024-03-23', 140.00);

SELECT* FROM ORDERS;

-- Q3: Show the monthly revenue trend for each customer segment in Q1 2024."

SELECT
	C.SEGMENT,
	TO_CHAR(O.ORDER_DATE, 'YYYY-MON') AS ORDER_MONTH,
	SUM(O.AMOUNT) AS TOTAL_REVENUE
FROM
	CUSTOMERS C
	JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE
	O.ORDER_DATE BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY
	C.SEGMENT,
	TO_CHAR(O.ORDER_DATE, 'YYYY-MON')
ORDER BY
	TOTAL_REVENUE DESC;


