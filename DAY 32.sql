-- DAY 32 OF 100:Some customers take loans but close them early (before the scheduled end date).
-- Find all customers who closed their loans at least 6 months early, and 
-- calculate how many months early they closed.

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO customers (customer_name, city) VALUES
('Amit Sharma', 'Delhi'),
('Priya Verma', 'Mumbai'),
('Rohit Mehta', 'Bangalore'),
('Sneha Kapoor', 'Delhi'),
('Vikram Singh', 'Chennai'),
('Anita Desai', 'Kolkata'),
('Suresh Iyer', 'Hyderabad'),
('Meena Joshi', 'Pune'),
('Karan Malhotra', 'Delhi'),
('Pooja Nair', 'Mumbai'),
('Arjun Reddy', 'Hyderabad'),
('Nisha Bansal', 'Chandigarh'),
('Ravi Kumar', 'Delhi'),
('Simran Kaur', 'Amritsar'),
('Manoj Yadav', 'Lucknow');

CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    loan_amount NUMERIC(12,2),
    start_date DATE,
    scheduled_end_date DATE,
    actual_closure_date DATE
);

INSERT INTO loans (customer_id, loan_amount, start_date, scheduled_end_date, actual_closure_date) VALUES
(1, 500000, '2022-01-01', '2025-01-01', '2024-01-01'),
(2, 300000, '2021-06-15', '2024-06-15', '2024-01-15'),
(3, 800000, '2020-03-01', '2025-03-01', '2024-06-01'),
(4, 450000, '2021-09-10', '2024-09-10', '2024-08-10'),
(5, 600000, '2022-05-05', '2025-05-05', '2024-10-05'),
(6, 750000, '2019-08-01', '2024-08-01', '2022-12-01'),
(7, 550000, '2020-11-15', '2025-11-15', '2023-11-15'),
(8, 400000, '2021-03-20', '2024-03-20', '2024-03-20'),
(9, 300000, '2020-04-10', '2023-04-10', '2023-01-10'),
(10, 900000, '2019-07-01', '2024-07-01', '2023-12-01'),
(11, 200000, '2021-02-01', '2024-02-01', '2022-08-01'),
(12, 650000, '2022-01-01', '2025-01-01', '2024-11-01'),
(13, 780000, '2020-05-05', '2023-05-05', '2022-10-05'),
(14, 250000, '2021-06-01', '2024-06-01', '2024-06-01'),
(15, 500000, '2018-09-15', '2023-09-15', '2020-09-15'),
(3, 350000, '2022-02-01', '2025-02-01', '2025-01-01'),
(7, 120000, '2021-10-01', '2024-10-01', '2024-02-01'),
(10, 420000, '2019-12-01', '2024-12-01', '2024-01-01'),
(13, 310000, '2021-01-01', '2024-01-01', '2023-07-01'),
(15, 900000, '2017-05-01', '2022-05-01', '2021-01-01');

SELECT * FROM CUSTOMERS;
SELECT * FROM LOANS;

WITH
	EARLY_PMT AS (
		SELECT
			C.CUSTOMER_NAME,
			C.CITY,
			L.LOAN_AMOUNT,
			L.SCHEDULED_END_DATE,
			L.ACTUAL_CLOSURE_DATE,
			DATE_PART(
				'YEAR',
				AGE (L.SCHEDULED_END_DATE, L.ACTUAL_CLOSURE_DATE)
			) * 12 + DATE_PART(
				'MONTH',
				AGE (L.SCHEDULED_END_DATE, L.ACTUAL_CLOSURE_DATE)
			) AS MONTH_EARLY
		FROM
			CUSTOMERS C
			JOIN LOANS L ON C.CUSTOMER_ID = L.CUSTOMER_ID
	)
SELECT
	CUSTOMER_NAME,
	CITY,
	LOAN_AMOUNT,
	SCHEDULED_END_DATE,
	ACTUAL_CLOSURE_DATE,
	MONTH_EARLY
FROM
	EARLY_PMT
WHERE
	MONTH_EARLY >= 6;






























