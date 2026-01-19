-- Customer Churn Rate using Cohort Analysis
-- PROBLEM : Ek SaaS company (project management tool) hai jiska naam hai "TaskFlow". 
-- Company ko ye samajhna hai ki jo customers unka product subscribe karte hain, 
-- unme se kitne percent customers har month churn (leave) kar rahe hain.

-- WHY:
-- 1. Revenue Loss Prevention
-- 2. Product Issues Identify
-- 3. Marketing ROI
-- 4. Retention Strategy
-- 5. Investor Reporting

-- TABLES 

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    signup_date DATE,
    plan_type VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_id INT,
    subscription_month DATE,  
    subscription_status VARCHAR(20), 
    monthly_revenue DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Rajesh Kumar', 'rajesh.k@gmail.com', '2024-01-05', 'Professional', 'India'),
(2, 'Priya Sharma', 'priya.s@yahoo.com', '2024-01-08', 'Business', 'India'),
(3, 'Amit Patel', 'amit.p@outlook.com', '2024-01-12', 'Professional', 'India'),
(4, 'Sneha Reddy', 'sneha.r@gmail.com', '2024-01-15', 'Starter', 'India'),
(5, 'Vikram Singh', 'vikram.s@company.com', '2024-01-18', 'Business', 'India'),
(6, 'Ananya Iyer', 'ananya.i@gmail.com', '2024-01-22', 'Professional', 'India'),
(7, 'Rahul Verma', 'rahul.v@tech.com', '2024-01-25', 'Starter', 'India'),
(8, 'Pooja Gupta', 'pooja.g@startup.io', '2024-01-28', 'Business', 'India'),
(9, 'Karthik Menon', 'karthik.m@gmail.com', '2024-02-02', 'Professional', 'India'),
(10, 'Divya Nair', 'divya.n@company.com', '2024-02-05', 'Business', 'India'),
(11, 'Arjun Rao', 'arjun.r@outlook.com', '2024-02-08', 'Starter', 'India'),
(12, 'Meera Joshi', 'meera.j@gmail.com', '2024-02-12', 'Professional', 'India'),
(13, 'Sanjay Desai', 'sanjay.d@enterprise.com', '2024-02-15', 'Business', 'India'),
(14, 'Kavya Pillai', 'kavya.p@startup.io', '2024-02-18', 'Professional', 'India'),
(15, 'Rohan Chopra', 'rohan.c@gmail.com', '2024-02-22', 'Starter', 'India'),
(16, 'Nisha Agarwal', 'nisha.a@tech.com', '2024-02-25', 'Business', 'India'),
(17, 'Aditya Khanna', 'aditya.k@company.com', '2024-02-28', 'Professional', 'India'),
(18, 'Shreya Malhotra', 'shreya.m@gmail.com', '2024-03-03', 'Business', 'India'),
(19, 'Varun Sinha', 'varun.s@outlook.com', '2024-03-07', 'Starter', 'India'),
(20, 'Ritika Bansal', 'ritika.b@startup.io', '2024-03-10', 'Professional', 'India'),
(21, 'Manish Tiwari', 'manish.t@gmail.com', '2024-03-14', 'Business', 'India'),
(22, 'Ishita Saxena', 'ishita.s@company.com', '2024-03-18', 'Professional', 'India'),
(23, 'Nikhil Bhatt', 'nikhil.b@tech.com', '2024-03-21', 'Starter', 'India'),
(24, 'Tanvi Shah', 'tanvi.s@enterprise.com', '2024-03-25', 'Business', 'India'),
(25, 'Gaurav Mehta', 'gaurav.m@gmail.com', '2024-03-28', 'Professional', 'India'),
(26, 'Simran Kaur', 'simran.k@outlook.com', '2024-04-02', 'Business', 'India'),
(27, 'Harsh Pandey', 'harsh.p@startup.io', '2024-04-05', 'Starter', 'India'),
(28, 'Aarti Kulkarni', 'aarti.k@gmail.com', '2024-04-09', 'Professional', 'India'),
(29, 'Deepak Yadav', 'deepak.y@company.com', '2024-04-12', 'Business', 'India'),
(30, 'Riya Bajaj', 'riya.b@tech.com', '2024-04-16', 'Professional', 'India'),
(31, 'Akash Thakur', 'akash.t@gmail.com', '2024-04-19', 'Starter', 'India'),
(32, 'Pallavi Jain', 'pallavi.j@enterprise.com', '2024-04-23', 'Business', 'India'),
(33, 'Kunal Arora', 'kunal.a@outlook.com', '2024-04-26', 'Professional', 'India'),
(34, 'Swati Mishra', 'swati.m@startup.io', '2024-04-29', 'Business', 'India'),
(35, 'Vishal Kapoor', 'vishal.k@gmail.com', '2024-05-03', 'Starter', 'India'),
(36, 'Neha Bose', 'neha.b@company.com', '2024-05-06', 'Professional', 'India'),
(37, 'Sahil Dutta', 'sahil.d@tech.com', '2024-05-10', 'Business', 'India'),
(38, 'Preeti Sengupta', 'preeti.s@gmail.com', '2024-05-13', 'Professional', 'India'),
(39, 'Mohit Ghosh', 'mohit.g@enterprise.com', '2024-05-17', 'Starter', 'India'),
(40, 'Anjali Chatterjee', 'anjali.c@outlook.com', '2024-05-20', 'Business', 'India'),
(41, 'Siddharth Roy', 'siddharth.r@startup.io', '2024-05-24', 'Professional', 'India'),
(42, 'Kriti Mukherjee', 'kriti.m@gmail.com', '2024-05-27', 'Business', 'India'),
(43, 'Yash Banerjee', 'yash.b@company.com', '2024-05-30', 'Starter', 'India'),
(44, 'Sonali Das', 'sonali.d@tech.com', '2024-06-02', 'Professional', 'India'),
(45, 'Abhishek Saha', 'abhishek.s@gmail.com', '2024-06-05', 'Business', 'India'),
(46, 'Tanya Chakraborty', 'tanya.c@enterprise.com', '2024-06-09', 'Professional', 'India'),
(47, 'Rishab Mazumdar', 'rishab.m@outlook.com', '2024-06-12', 'Starter', 'India'),
(48, 'Sakshi Bhattacharya', 'sakshi.b@startup.io', '2024-06-16', 'Business', 'India'),
(49, 'Ayush Ganguly', 'ayush.g@gmail.com', '2024-01-10', 'Professional', 'India'),
(50, 'Isha Karmakar', 'isha.k@company.com', '2024-01-20', 'Business', 'India');
INSERT INTO subscriptions VALUES
(1, 1, '2024-01-01', 'Active', 499.00),
(2, 1, '2024-02-01', 'Active', 499.00),
(3, 1, '2024-03-01', 'Active', 499.00),
(4, 1, '2024-04-01', 'Active', 499.00),
(5, 1, '2024-05-01', 'Active', 499.00),
(6, 1, '2024-06-01', 'Active', 499.00),
(7, 2, '2024-01-01', 'Active', 999.00),
(8, 2, '2024-02-01', 'Active', 999.00),
(9, 2, '2024-03-01', 'Active', 999.00),
(10, 2, '2024-04-01', 'Active', 999.00),
(11, 2, '2024-05-01', 'Churned', 0.00),
(12, 3, '2024-01-01', 'Active', 499.00),
(13, 3, '2024-02-01', 'Active', 499.00),
(14, 3, '2024-03-01', 'Churned', 0.00),
(15, 4, '2024-01-01', 'Active', 199.00),
(16, 4, '2024-02-01', 'Churned', 0.00),
(17, 5, '2024-01-01', 'Active', 999.00),
(18, 5, '2024-02-01', 'Active', 999.00),
(19, 5, '2024-03-01', 'Active', 999.00),
(20, 5, '2024-04-01', 'Active', 999.00),
(21, 5, '2024-05-01', 'Active', 999.00),
(22, 5, '2024-06-01', 'Active', 999.00),
(23, 6, '2024-01-01', 'Active', 499.00),
(24, 6, '2024-02-01', 'Active', 499.00),
(25, 6, '2024-03-01', 'Active', 499.00),
(26, 6, '2024-04-01', 'Churned', 0.00),
(27, 7, '2024-01-01', 'Active', 199.00),
(28, 7, '2024-02-01', 'Active', 199.00),
(29, 7, '2024-03-01', 'Active', 199.00),
(30, 7, '2024-04-01', 'Active', 199.00),
(31, 7, '2024-05-01', 'Active', 199.00),
(32, 7, '2024-06-01', 'Active', 199.00),
(33, 8, '2024-01-01', 'Active', 999.00),
(34, 8, '2024-02-01', 'Active', 999.00),
(35, 8, '2024-03-01', 'Churned', 0.00),
(36, 49, '2024-01-01', 'Active', 499.00),
(37, 49, '2024-02-01', 'Churned', 0.00),
(38, 50, '2024-01-01', 'Active', 999.00),
(39, 50, '2024-02-01', 'Active', 999.00),
(40, 50, '2024-03-01', 'Active', 999.00),
(41, 50, '2024-04-01', 'Active', 999.00),
(42, 50, '2024-05-01', 'Active', 999.00),
(43, 50, '2024-06-01', 'Active', 999.00),
(44, 9, '2024-02-01', 'Active', 499.00),
(45, 9, '2024-03-01', 'Active', 499.00),
(46, 9, '2024-04-01', 'Active', 499.00),
(47, 9, '2024-05-01', 'Active', 499.00),
(48, 9, '2024-06-01', 'Active', 499.00),
(49, 10, '2024-02-01', 'Active', 999.00),
(50, 10, '2024-03-01', 'Active', 999.00),
(51, 10, '2024-04-01', 'Churned', 0.00),
(52, 11, '2024-02-01', 'Active', 199.00),
(53, 11, '2024-03-01', 'Churned', 0.00),
(54, 12, '2024-02-01', 'Active', 499.00),
(55, 12, '2024-03-01', 'Active', 499.00),
(56, 12, '2024-04-01', 'Active', 499.00),
(57, 12, '2024-05-01', 'Active', 499.00),
(58, 12, '2024-06-01', 'Active', 499.00),
(59, 13, '2024-02-01', 'Active', 999.00),
(60, 13, '2024-03-01', 'Active', 999.00),
(61, 13, '2024-04-01', 'Active', 999.00),
(62, 13, '2024-05-01', 'Churned', 0.00),
(63, 14, '2024-02-01', 'Active', 499.00),
(64, 14, '2024-03-01', 'Active', 499.00),
(65, 14, '2024-04-01', 'Active', 499.00),
(66, 14, '2024-05-01', 'Active', 499.00),
(67, 14, '2024-06-01', 'Active', 499.00),
(68, 15, '2024-02-01', 'Active', 199.00),
(69, 15, '2024-03-01', 'Churned', 0.00),
(70, 16, '2024-02-01', 'Active', 999.00),
(71, 16, '2024-03-01', 'Active', 999.00),
(72, 16, '2024-04-01', 'Active', 999.00),
(73, 16, '2024-05-01', 'Active', 999.00),
(74, 16, '2024-06-01', 'Active', 999.00),
(75, 17, '2024-02-01', 'Active', 499.00),
(76, 17, '2024-03-01', 'Active', 499.00),
(77, 17, '2024-04-01', 'Churned', 0.00),
(78, 18, '2024-03-01', 'Active', 999.00),
(79, 18, '2024-04-01', 'Active', 999.00),
(80, 18, '2024-05-01', 'Active', 999.00),
(81, 18, '2024-06-01', 'Active', 999.00),
(82, 19, '2024-03-01', 'Active', 199.00),
(83, 19, '2024-04-01', 'Churned', 0.00),
(84, 20, '2024-03-01', 'Active', 499.00),
(85, 20, '2024-04-01', 'Active', 499.00),
(86, 20, '2024-05-01', 'Active', 499.00),
(87, 20, '2024-06-01', 'Active', 499.00),
(88, 21, '2024-03-01', 'Active', 999.00),
(89, 21, '2024-04-01', 'Active', 999.00),
(90, 21, '2024-05-01', 'Churned', 0.00),
(91, 22, '2024-03-01', 'Active', 499.00),
(92, 22, '2024-04-01', 'Active', 499.00),
(93, 22, '2024-05-01', 'Active', 499.00),
(94, 22, '2024-06-01', 'Active', 499.00),
(95, 23, '2024-03-01', 'Active', 199.00),
(96, 23, '2024-04-01', 'Active', 199.00),
(97, 23, '2024-05-01', 'Active', 199.00),
(98, 23, '2024-06-01', 'Active', 199.00),
(99, 24, '2024-03-01', 'Active', 999.00),
(100, 24, '2024-04-01', 'Active', 999.00),
(101, 24, '2024-05-01', 'Active', 999.00),
(102, 24, '2024-06-01', 'Active', 999.00),
(103, 25, '2024-03-01', 'Active', 499.00),
(104, 25, '2024-04-01', 'Churned', 0.00),
(105, 26, '2024-04-01', 'Active', 999.00),
(106, 26, '2024-05-01', 'Active', 999.00),
(107, 26, '2024-06-01', 'Active', 999.00),
(108, 27, '2024-04-01', 'Active', 199.00),
(109, 27, '2024-05-01', 'Churned', 0.00),
(110, 28, '2024-04-01', 'Active', 499.00),
(111, 28, '2024-05-01', 'Active', 499.00),
(112, 28, '2024-06-01', 'Active', 499.00),
(113, 29, '2024-04-01', 'Active', 999.00),
(114, 29, '2024-05-01', 'Active', 999.00),
(115, 29, '2024-06-01', 'Active', 999.00),
(116, 30, '2024-04-01', 'Active', 499.00),
(117, 30, '2024-05-01', 'Active', 499.00),
(118, 30, '2024-06-01', 'Active', 499.00),
(119, 31, '2024-04-01', 'Active', 199.00),
(120, 31, '2024-05-01', 'Active', 199.00),
(121, 31, '2024-06-01', 'Active', 199.00),
(122, 32, '2024-04-01', 'Active', 999.00),
(123, 32, '2024-05-01', 'Churned', 0.00),
(124, 33, '2024-04-01', 'Active', 499.00),
(125, 33, '2024-05-01', 'Active', 499.00),
(126, 33, '2024-06-01', 'Active', 499.00),
(127, 34, '2024-05-01', 'Active', 999.00),
(128, 34, '2024-06-01', 'Active', 999.00),
(129, 35, '2024-05-01', 'Active', 199.00),
(130, 35, '2024-06-01', 'Churned', 0.00),
(131, 36, '2024-05-01', 'Active', 499.00),
(132, 36, '2024-06-01', 'Active', 499.00),
(133, 37, '2024-05-01', 'Active', 999.00),
(134, 37, '2024-06-01', 'Active', 999.00),
(135, 38, '2024-05-01', 'Active', 499.00),
(136, 38, '2024-06-01', 'Active', 499.00),
(137, 39, '2024-05-01', 'Active', 199.00),
(138, 39, '2024-06-01', 'Active', 199.00),
(139, 40, '2024-05-01', 'Active', 999.00),
(140, 40, '2024-06-01', 'Active', 999.00),
(141, 41, '2024-05-01', 'Active', 499.00),
(142, 41, '2024-06-01', 'Active', 499.00),
(143, 42, '2024-05-01', 'Active', 999.00),
(144, 42, '2024-06-01', 'Active', 999.00),
(145, 43, '2024-06-01', 'Active', 199.00),
(146, 44, '2024-06-01', 'Active', 499.00),
(147, 45, '2024-06-01', 'Active', 999.00),
(148, 46, '2024-06-01', 'Active', 499.00),
(149, 47, '2024-06-01', 'Active', 199.00),
(150, 48, '2024-06-01', 'Active', 999.00);

select * from customers;
select * from subscriptions;

WITH
	CUST_COHORT AS (
		SELECT
			CUSTOMER_ID,
			DATE_TRUNC('MONTH', MIN(SUBSCRIPTION_MONTH))::DATE AS COHORT_MONTH
		FROM
			SUBSCRIPTIONS
		GROUP BY
			CUSTOMER_ID
	),
	COHORT_SIZES AS (
		SELECT
			COHORT_MONTH,
			COUNT(DISTINCT CUSTOMER_ID) AS COHORT_SIZE
		FROM
			CUST_COHORT
		GROUP BY
			COHORT_MONTH
	),
	MONTHLY_ACTIVITY AS (
		SELECT
			CC.COHORT_MONTH,
			S.SUBSCRIPTION_MONTH,
			EXTRACT(
				YEAR
				FROM
					AGE (S.SUBSCRIPTION_MONTH, CC.COHORT_MONTH)
			) * 12 + EXTRACT(
				MONTH
				FROM
					AGE (S.SUBSCRIPTION_MONTH, CC.COHORT_MONTH)
			) AS MONTH_NUMBER,
			COUNT(DISTINCT S.CUSTOMER_ID) AS ACTIVE_CUSTOMERS
		FROM
			SUBSCRIPTIONS S
			JOIN CUST_COHORT CC ON S.CUSTOMER_ID = CC.CUSTOMER_ID
		WHERE
			S.SUBSCRIPTION_STATUS = 'Active'
		GROUP BY
			CC.COHORT_MONTH,
			S.SUBSCRIPTION_MONTH
	)
SELECT
	MA.COHORT_MONTH,
	TO_CHAR(MA.COHORT_MONTH, 'Mon YYYY') AS COHORT_NAME,
	MA.SUBSCRIPTION_MONTH,
	MA.MONTH_NUMBER,
	MA.ACTIVE_CUSTOMERS,
	CS.COHORT_SIZE AS TOTAL_CUSTOMERS,
	ROUND(
		(
			MA.ACTIVE_CUSTOMERS::NUMERIC / CS.COHORT_SIZE::NUMERIC
		) * 100,
		2
	) AS RETENTION_RATE,
	ROUND(
		100 - (
			MA.ACTIVE_CUSTOMERS::NUMERIC / CS.COHORT_SIZE::NUMERIC
		) * 100,
		2
	) AS CHURN_RATE_PERCENTAGE
FROM
	MONTHLY_ACTIVITY MA
	JOIN COHORT_SIZES CS ON MA.COHORT_MONTH = CS.COHORT_MONTH
ORDER BY
	MA.COHORT_MONTH,
	MA.MONTH_NUMBER;