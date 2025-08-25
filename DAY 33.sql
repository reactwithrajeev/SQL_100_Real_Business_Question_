-- DAY 33 OF 100 : Banks want to identify “Dormant Customers” — customers who haven’t 
-- made any transactions in the last 6 months but still have an active account.

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
('Neha Agarwal', 'Kolkata'),
('Suresh Iyer', 'Hyderabad'),
('Pooja Nair', 'Pune');

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    account_type VARCHAR(50),
    balance NUMERIC(12,2),
    status VARCHAR(20)
);

INSERT INTO accounts (customer_id, account_type, balance, status) VALUES
(1, 'Savings', 85000, 'Active'),
(2, 'Current', 125000, 'Active'),
(3, 'Savings', 40000, 'Active'),
(4, 'Current', 95000, 'Active'),
(5, 'Savings', 150000, 'Active'),
(6, 'Current', 30000, 'Active'),
(7, 'Savings', 5000, 'Active'),
(8, 'Current', 80000, 'Active');

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    transaction_date DATE,
    amount NUMERIC(12,2),
    transaction_type VARCHAR(20)
);

INSERT INTO transactions (account_id, transaction_date, amount, transaction_type) VALUES
(1, '2025-07-15', 5000, 'Credit'),   
(1, '2025-07-20', 2000, 'Debit'),
(2, '2025-02-10', 7000, 'Credit'),  
(3, '2025-05-25', 3000, 'Debit'),  
(4, '2024-12-10', 15000, 'Credit'), 
(5, '2025-01-05', 25000, 'Debit'),  
(6, '2025-02-15', 10000, 'Credit'),  
(7, '2024-11-01', 2000, 'Debit'),    
(8, '2025-08-01', 9000, 'Credit');  

SELECT * FROM CUSTOMERS;
SELECT * FROM ACCOUNTS;
SELECT * FROM TRANSACTIONS;


WITH LAST_TXN AS (SELECT
C.CUSTOMER_NAME,
A.ACCOUNT_ID,
A.ACCOUNT_TYPE,
A.STATUS,
A.BALANCE,
MAX(TRANSACTION_DATE) AS LAST_TRANSACTION_DATE
FROM CUSTOMERS C
JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
LEFT JOIN TRANSACTIONS T ON A.ACCOUNT_ID = T.ACCOUNT_ID 
GROUP BY 
C.CUSTOMER_NAME,
A.ACCOUNT_ID,
A.ACCOUNT_TYPE,
A.BALANCE)
SELECT
CUSTOMER_NAME,
ACCOUNT_TYPE,
LAST_TRANSACTION_DATE,
CURRENT_DATE - LAST_TRANSACTION_DATE AS INACTIVE_DAYS
FROM LAST_TXN
WHERE STATUS = 'Active' AND LAST_TRANSACTION_DATE <= CURRENT_DATE - INTERVAL'6 MONTHS'
ORDER BY INACTIVE_DAYS DESC;




























