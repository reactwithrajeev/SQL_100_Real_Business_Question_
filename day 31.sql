-- DAY 31 OF 100 :  Your bank’s risk department wants to identify the top 3 cities 
-- where the number of >30-day late EMI payments increased the most compared to the previous month.
-- This will help prioritize collection efforts in regions with rising default risk.

 CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Rajeev Raina', 'Delhi'),
(2, 'Anita Mehta', 'Mumbai'),
(3, 'Suresh Kumar', 'Bangalore'),
(4, 'Neha Shah', 'Pune'),
(5, 'Imran Ali', 'Delhi'),
(6, 'Priya Verma', 'Chennai'),
(7, 'Rohit Das', 'Mumbai'),
(8, 'Kavita Nair', 'Bangalore');

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(20),
    loan_start_date DATE,
    term_months INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO loans VALUES
(1, 1, 'Home', '2022-05-01', 240),
(2, 2, 'Car', '2023-01-01', 60),
(3, 3, 'Personal', '2024-01-01', 36),
(4, 4, 'Home', '2021-06-01', 180),
(5, 5, 'Education', '2023-04-01', 48),
(6, 6, 'Car', '2024-06-01', 48),
(7, 7, 'Personal', '2024-02-01', 24),
(8, 8, 'Home', '2022-08-01', 180);

CREATE TABLE emi_payments (
    payment_id INT PRIMARY KEY,
    loan_id INT,
    due_date DATE,
    payment_date DATE,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

INSERT INTO emi_payments VALUES
(1, 1, '2024-12-05', '2024-12-10'),
(2, 2, '2024-12-10', '2025-01-20'),
(3, 3, '2024-12-15', '2024-12-28'),
(4, 4, '2024-12-20', '2025-01-25'),
(5, 1, '2025-01-05', '2025-01-20'),
(6, 2, '2025-01-10', '2025-02-15'),
(7, 3, '2025-01-15', '2025-02-25'),
(8, 4, '2025-01-20', '2025-02-18'),
(9, 5, '2025-01-12', '2025-01-13'),
(10, 2, '2025-02-10', '2025-03-20'),
(11, 3, '2025-02-15', '2025-03-25'),
(12, 5, '2025-02-12', '2025-03-20'),
(13, 6, '2025-02-18', '2025-02-28'),
(14, 7, '2025-02-22', '2025-03-30'),
(15, 8, '2025-02-25', '2025-03-28');


SELECT * FROM CUSTOMERS;
SELECT * FROM LOANS;
SELECT * FROM EMI_PAYMENTS;

WITH PAYMENT_COUNT As (SELECT
C.CITY,
DATE_TRUNC('MONTH',E.DUE_DATE) AS PMT_MONTH,
COUNT(*) AS LATE_COUNT
FROM EMI_PAYMENTS E
JOIN LOANS L ON E.LOAN_ID = L.loan_id
JOIN CUSTOMERS C ON L.CUSTOMER_ID = C.CUSTOMER_ID
WHERE E.PAYMENT_DATE > E.DUE_DATE + INTERVAL'30 DAYS'
GROUP BY C.CITY,
DATE_TRUNC('MONTH',E.DUE_DATE)),
COUNT_CHANGE AS (SELECT
CITY,
PMT_MONTH,
LATE_COUNT,
LAG(LATE_COUNT) OVER(PARTITION BY CITY ORDER BY PMT_MONTH ) AS PREV_MONTH_LATE_COUNT,
LATE_COUNT - LAG(LATE_COUNT) OVER(PARTITION BY CITY ORDER BY PMT_MONTH ) AS LATE_COUNT_CHANGE
FROM PAYMENT_COUNT)
SELECT
CITY,
PMT_MONTH,
LATE_COUNT,
PREV_MONTH_LATE_COUNT,
LATE_COUNT_CHANGE
FROM COUNT_CHANGE
WHERE PREV_MONTH_LATE_COUNT IS NOT NULL AND LATE_COUNT_CHANGE >0
ORDER BY LATE_COUNT_CHANGE DESC
LIMIT 3;

























 













