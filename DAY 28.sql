-- DAY 28 OF 100 : Which customers are at a high risk of default based on their recent repayment behavior, 
-- outstanding loan amount, and credit score trends over time?

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name TEXT,
    age INT,
    city TEXT
);

INSERT INTO customers (name, age, city) VALUES
('Anjali Verma', 35, 'Delhi'),
('Rakesh Sharma', 42, 'Mumbai'),
('Pooja Iyer', 29, 'Bangalore'),
('Vikram Singh', 38, 'Chennai'),
('Neha Kapoor', 31, 'Pune'),
('Manoj Yadav', 47, 'Hyderabad');

CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    customer_id INT,
    loan_amount NUMERIC,
    outstanding_amount NUMERIC,
    emi_amount NUMERIC,
    loan_start_date DATE,
    term_months INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO loans (customer_id, loan_amount, outstanding_amount, emi_amount, loan_start_date, term_months) VALUES
(1, 500000, 320000, 15000, '2023-01-01', 36),
(2, 750000, 400000, 18000, '2022-07-01', 48),
(3, 300000, 270000, 9000, '2024-01-01', 24),
(4, 600000, 200000, 17000, '2023-03-01', 36),
(5, 450000, 430000, 13000, '2024-03-01', 36),
(6, 800000, 750000, 20000, '2024-02-01', 60);

CREATE TABLE repayments (
    payment_id SERIAL PRIMARY KEY,
    loan_id INT,
    payment_date DATE,
    amount_paid NUMERIC,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

INSERT INTO repayments (loan_id, payment_date, amount_paid) VALUES
(1, '2025-03-01', 15000),
(1, '2025-04-01', 0),
(1, '2025-05-01', 15000),
(1, '2025-06-01', 0),
(1, '2025-07-01', 15000),
(2, '2025-03-01', 18000),
(2, '2025-04-01', 18000),
(2, '2025-05-01', 18000),
(2, '2025-06-01', 18000),
(2, '2025-07-01', 18000),
(3, '2025-03-01', 0),
(3, '2025-04-01', 0),
(3, '2025-05-01', 9000),
(3, '2025-06-01', 0),
(3, '2025-07-01', 0),
(4, '2025-03-01', 17000),
(4, '2025-04-01', 17000),
(4, '2025-05-01', 17000),
(4, '2025-06-01', 17000),
(4, '2025-07-01', 17000),
(5, '2025-03-01', 0),
(5, '2025-04-01', 0),
(5, '2025-05-01', 0),
(5, '2025-06-01', 13000),
(5, '2025-07-01', 0),
(6, '2025-03-01', 20000),
(6, '2025-04-01', 0),
(6, '2025-05-01', 20000),
(6, '2025-06-01', 20000),
(6, '2025-07-01', 0);

CREATE TABLE credit_scores (
    customer_id INT,
    score_date DATE,
    credit_score INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO credit_scores (customer_id, score_date, credit_score) VALUES
(1, '2025-01-01', 710),
(1, '2025-04-01', 680),
(1, '2025-07-01', 650),
(3, '2025-01-01', 690),
(3, '2025-04-01', 660),
(3, '2025-07-01', 640),
(5, '2025-01-01', 620),
(5, '2025-04-01', 610),
(5, '2025-07-01', 580),
(6, '2025-01-01', 720),
(6, '2025-04-01', 700),
(6, '2025-07-01', 680);

SELECT * FROM customers;
SELECT * FROM loans;
SELECT * FROM repayments;
SELECT * FROM credit_scores;

WITH MISSING_EMIS AS (SELECT
C.CUSTOMER_ID,
L.LOAN_ID,
COUNT(*) FILTER(WHERE R.AMOUNT_PAID = 0) AS MISSED_EMI
FROM CUSTOMERS C
JOIN LOANS L ON C.CUSTOMER_ID = L.customer_id
JOIN REPAYMENTS R ON L.LOAN_ID = R.LOAN_ID
WHERE R.PAYMENT_DATE >= CURRENT_DATE - INTERVAL '6 MONTHS'
GROUP BY C.CUSTOMER_ID,L.LOAN_ID),
SCORE_TREND AS (SELECT
CUSTOMER_ID,
SCORE_DATE,
CREDIT_SCORE,
FIRST_VALUE(CREDIT_SCORE) OVER(PARTITION BY CUSTOMER_ID ORDER BY SCORE_DATE) AS EARLIEST_SCORE,
LAST_VALUE(CREDIT_SCORE) OVER(PARTITION BY CUSTOMER_ID ORDER BY SCORE_DATE ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LATEST_SCORE
FROM 
CREDIT_SCORES),
HIGH_RISK_CLIENTS AS (SELECT
C.CUSTOMER_ID,
C.NAME,
L.LOAN_ID,
L.OUTSTANDING_AMOUNT,
M.MISSED_EMI,
S.EARLIEST_SCORE ,
S.LATEST_SCORE
FROM
CUSTOMERS C
JOIN LOANS L ON C.CUSTOMER_ID = L.customer_id
JOIN MISSING_EMIS M ON M.LOAN_ID = L.LOAN_ID
JOIN SCORE_TREND S ON M.CUSTOMER_ID = S.CUSTOMER_ID
WHERE S.LATEST_SCORE < S.EARLIEST_SCORE AND M.MISSED_EMI > 2 AND L.OUTSTANDING_AMOUNT > 250000)
SELECT DISTINCT * FROM HIGH_RISK_CLIENTS;




































 












