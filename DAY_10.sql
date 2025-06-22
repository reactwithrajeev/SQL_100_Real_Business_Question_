-- DAY 10 OF 100 : Segment customers based on their total profit contribution over the last 6 months,
-- and identify which segment contributes the most to overall revenue.

CREATE TABLE customer_sales (
    sale_id INT,
    customer_name TEXT,
    product TEXT,
    quantity INT,
    unit_price DECIMAL,
    cost_price DECIMAL,
    sale_date DATE
);

INSERT INTO customer_sales VALUES
(1, 'Customer_1', 'Laptop', 1, 950, 780, '2025-04-15'),
(2, 'Customer_1', 'Monitor', 2, 400, 300, '2025-03-18'),
(3, 'Customer_2', 'Mouse', 5, 50, 30, '2025-05-05'),
(4, 'Customer_2', 'Keyboard', 3, 80, 60, '2025-06-02'),
(5, 'Customer_3', 'Desk', 1, 500, 350, '2025-04-01'),
(6, 'Customer_3', 'Chair', 2, 200, 150, '2025-05-21'),
(7, 'Customer_4', 'Smartphone', 1, 700, 500, '2025-06-03'),
(8, 'Customer_4', 'Laptop', 1, 1000, 800, '2025-04-10'),
(9, 'Customer_5', 'Tablet', 2, 400, 250, '2025-05-09'),
(10, 'Customer_5', 'Mouse', 4, 45, 25, '2025-06-01'),
(11, 'Customer_6', 'Keyboard', 3, 75, 55, '2025-04-04'),
(12, 'Customer_6', 'Monitor', 1, 350, 200, '2025-03-15'),
(13, 'Customer_7', 'Printer', 2, 220, 120, '2025-06-04'),
(14, 'Customer_8', 'Tablet', 1, 390, 250, '2025-06-02'),
(15, 'Customer_8', 'Desk', 1, 480, 350, '2025-05-20'),
(16, 'Customer_9', 'Laptop', 1, 980, 720, '2025-04-18'),
(17, 'Customer_10', 'Smartwatch', 1, 450, 300, '2025-05-11'),
(18, 'Customer_11', 'Tablet', 2, 400, 280, '2025-04-08'),
(19, 'Customer_11', 'Monitor', 1, 340, 260, '2025-06-03'),
(20, 'Customer_12', 'Desk', 2, 490, 380, '2025-03-20'),
(21, 'Customer_13', 'Keyboard', 1, 65, 45, '2025-05-05'),
(22, 'Customer_13', 'Mouse', 2, 50, 30, '2025-06-04'),
(23, 'Customer_14', 'Laptop', 1, 970, 750, '2025-04-10'),
(24, 'Customer_15', 'Printer', 1, 210, 130, '2025-05-10'),
(25, 'Customer_16', 'Smartphone', 1, 680, 500, '2025-06-01'),
(26, 'Customer_17', 'Tablet', 2, 420, 300, '2025-06-02'),
(27, 'Customer_18', 'Desk', 1, 520, 360, '2025-05-04'),
(28, 'Customer_19', 'Monitor', 1, 320, 220, '2025-06-04'),
(29, 'Customer_20', 'Smartwatch', 1, 430, 280, '2025-04-14'),
(30, 'Customer_21', 'Chair', 3, 190, 140, '2025-05-01'),
(31, 'Customer_22', 'Mouse', 5, 40, 20, '2025-04-28'),
(32, 'Customer_23', 'Keyboard', 2, 60, 40, '2025-05-15'),
(33, 'Customer_24', 'Printer', 2, 230, 150, '2025-06-03'),
(34, 'Customer_25', 'Tablet', 3, 390, 270, '2025-03-25'),
(35, 'Customer_26', 'Laptop', 1, 950, 780, '2025-05-20'),
(36, 'Customer_27', 'Desk', 2, 500, 370, '2025-06-01'),
(37, 'Customer_28', 'Smartphone', 1, 710, 530, '2025-05-11'),
(38, 'Customer_29', 'Smartwatch', 1, 440, 310, '2025-04-03'),
(39, 'Customer_30', 'Monitor', 1, 300, 180, '2025-06-01'),
(40, 'Customer_31', 'Tablet', 2, 410, 300, '2025-04-22'),
(41, 'Customer_32', 'Desk', 1, 480, 350, '2025-06-01'),
(42, 'Customer_33', 'Chair', 2, 210, 160, '2025-05-10'),
(43, 'Customer_34', 'Mouse', 3, 50, 25, '2025-06-04'),
(44, 'Customer_35', 'Laptop', 1, 1000, 800, '2025-03-15'),
(45, 'Customer_36', 'Printer', 1, 220, 140, '2025-06-03'),
(46, 'Customer_37', 'Smartphone', 1, 690, 490, '2025-04-25'),
(47, 'Customer_38', 'Keyboard', 2, 75, 50, '2025-05-22'),
(48, 'Customer_39', 'Desk', 1, 520, 390, '2025-06-01'),
(49, 'Customer_40', 'Chair', 2, 200, 150, '2025-04-28'),
(50, 'Customer_41', 'Tablet', 1, 400, 300, '2025-05-11'),
(51, 'Customer_42', 'Monitor', 1, 310, 200, '2025-06-04'),
(52, 'Customer_43', 'Smartwatch', 1, 460, 330, '2025-05-08'),
(53, 'Customer_44', 'Printer', 1, 210, 130, '2025-06-02'),
(54, 'Customer_45', 'Laptop', 1, 990, 750, '2025-04-17'),
(55, 'Customer_46', 'Smartphone', 1, 670, 480, '2025-06-01'),
(56, 'Customer_47', 'Tablet', 2, 430, 310, '2025-05-14'),
(57, 'Customer_48', 'Desk', 2, 510, 370, '2025-06-03'),
(58, 'Customer_49', 'Chair', 1, 220, 160, '2025-05-04'),
(59, 'Customer_50', 'Mouse', 4, 50, 30, '2025-06-01');

SELECT * FROM CUSTOMER_SALES;

WITH
	RECENT_SALES AS (
		SELECT
			*,
			(UNIT_PRICE - COST_PRICE) * QUANTITY AS PROFIT,
			UNIT_PRICE * QUANTITY AS REVENUE
		FROM
			CUSTOMER_SALES
		WHERE
			SALE_DATE >= CURRENT_DATE - INTERVAL '6 MONTHS'
	),
	CUSTOMER_PROFIT AS (
		SELECT
			CUSTOMER_NAME,
			SUM(PROFIT) AS CUST_PROFIT,
			SUM(REVENUE) AS CUST_REVENUE
		FROM
			RECENT_SALES
		GROUP BY
			CUSTOMER_NAME
	),
	CUSTOMER_SEGMENT AS (
		SELECT
			*,
			CASE
				WHEN CUST_PROFIT >= 300 THEN 'GOLD'
				WHEN CUST_PROFIT >= 150 THEN 'SILVER'
				ELSE 'BRONZE'
			END AS CUST_SEGMENT
		FROM
			CUSTOMER_PROFIT
	)
SELECT
	CUST_SEGMENT,
	COUNT(*) AS TOTAL_CUSTOMERS,
	SUM(CUST_PROFIT) AS SEG_PROFITS,
	SUM(CUST_REVENUE) AS SEG_REVENUE
FROM
	CUSTOMER_SEGMENT
GROUP BY
	CUST_SEGMENT
ORDER BY
	SEG_REVENUE DESC;
 


