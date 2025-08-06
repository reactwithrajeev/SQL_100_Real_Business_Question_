-- DAY 29 OF 100: Identify high-risk customers who are currently using high-interest financial products, 
-- and whose utilization (current balance vs. credit limit) exceeds 80%. 
-- Generate a prioritized list for credit risk audit purposes.

CREATE TABLE customer_profiles (
    customer_id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INT,
    income NUMERIC,
    risk_segment TEXT, -- 'Low', 'Medium', 'High'
    city TEXT
);

CREATE TABLE financial_products (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    product_type TEXT, -- 'Loan', 'Credit Card', 'Savings Account', etc.
    interest_rate NUMERIC,
    annual_fee NUMERIC
);

CREATE TABLE product_subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer_profiles(customer_id),
    product_id INT REFERENCES financial_products(product_id),
    start_date DATE,
    end_date DATE,
    subscription_status TEXT, -- 'Active', 'Closed', 'Defaulted'
    credit_limit NUMERIC,
    current_balance NUMERIC
);

INSERT INTO customer_profiles (full_name, age, income, risk_segment, city) VALUES
('Rajeev Raina', 32, 950000, 'Low', 'Delhi'),
('Anita Mehta', 45, 450000, 'Medium', 'Mumbai'),
('Suresh Kumar', 27, 300000, 'High', 'Bangalore'),
('Neha Shah', 39, 850000, 'Low', 'Pune'),
('Imran Ali', 50, 600000, 'Medium', 'Hyderabad'),
('Priya Verma', 31, 250000, 'High', 'Chennai');

INSERT INTO financial_products (product_name, product_type, interest_rate, annual_fee) VALUES
('Gold Credit Card', 'Credit Card', 15.5, 1000),
('Personal Loan A', 'Loan', 12.0, 0),
('Savings Plus', 'Savings Account', 4.0, 0),
('Platinum Credit Card', 'Credit Card', 18.0, 2500),
('Home Loan Basic', 'Loan', 9.0, 0);

INSERT INTO product_subscriptions (customer_id, product_id, start_date, end_date, subscription_status, credit_limit, current_balance) VALUES
(1, 1, '2022-01-01', NULL, 'Active', 200000, 50000),
(2, 2, '2021-03-15', '2023-05-01', 'Closed', NULL, 0),
(3, 4, '2023-06-01', NULL, 'Active', 150000, 145000),
(4, 5, '2022-07-10', NULL, 'Active', NULL, 1200000),
(5, 1, '2020-09-01', '2022-10-01', 'Defaulted', 100000, 0),
(6, 3, '2023-01-01', NULL, 'Active', NULL, 20000);

select * from customer_profiles;
SELECT * from financial_products;
select * from product_subscriptions;


WITH
	CREDIT_REPORTS AS (
		SELECT
			PS.CUSTOMER_ID,
			PS.PRODUCT_ID,
			PS.SUBSCRIPTION_STATUS,
			PS.CREDIT_LIMIT,
			PS.CURRENT_BALANCE,
			FP.PRODUCT_NAME,
			FP.INTEREST_RATE
		FROM
			PRODUCT_SUBSCRIPTIONS PS
			JOIN FINANCIAL_PRODUCTS FP ON PS.PRODUCT_ID = FP.PRODUCT_ID
		WHERE
			FP.PRODUCT_TYPE = 'Credit Card'
			AND PS.SUBSCRIPTION_STATUS = 'Active'
	),
	UTILIZATION_REPORT AS (
		SELECT
			CP.CUSTOMER_ID,
			CP.FULL_NAME,
			CP.RISK_SEGMENT,
			C.PRODUCT_ID,
			C.CREDIT_LIMIT,
			C.CURRENT_BALANCE,
			C.INTEREST_RATE,
			ROUND(
				(C.CURRENT_BALANCE * 100.00) / NULLIF(C.CREDIT_LIMIT, 0),
				2
			) AS UTILIZATION_PCT
		FROM
			CUSTOMER_PROFILES CP
			JOIN CREDIT_REPORTS C ON CP.CUSTOMER_ID = C.CUSTOMER_ID
		WHERE
			CP.RISK_SEGMENT = 'High'
	)
SELECT
	*
FROM
	UTILIZATION_REPORT
WHERE
	UTILIZATION_PCT > 80;






















