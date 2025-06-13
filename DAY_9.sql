-- DAY 9 OF 100 : Identify the top 2 products in each category that contributed the highest profit in the last 3 months,
-- and analyze their share in the total category profit.

CREATE TABLE sales_data (
    sale_id INT,
    product TEXT,
    category TEXT,
    quantity INT,
    unit_price DECIMAL,
    cost_price DECIMAL,
    sale_date DATE
);

INSERT INTO sales_data VALUES
(1, 'Laptop', 'Electronics', 4, 900, 600, '2025-04-01'),
(2, 'Smartphone', 'Electronics', 8, 600, 400, '2025-05-15'),
(3, 'Tablet', 'Electronics', 10, 350, 220, '2025-05-28'),
(4, 'Smartwatch', 'Electronics', 5, 450, 300, '2025-06-01'),
(5, 'Headphones', 'Electronics', 12, 150, 80, '2025-06-03'),
(6, 'Office Chair', 'Furniture', 6, 250, 180, '2025-04-05'),
(7, 'Desk', 'Furniture', 3, 400, 280, '2025-05-10'),
(8, 'Bookshelf', 'Furniture', 4, 300, 200, '2025-06-01'),
(9, 'Sofa', 'Furniture', 2, 700, 500, '2025-05-30'),
(10, 'Coffee Table', 'Furniture', 5, 180, 120, '2025-06-04'),
(11, 'Notebook', 'Stationery', 60, 3, 1, '2025-04-12'),
(12, 'Pen', 'Stationery', 100, 2, 0.5, '2025-05-15'),
(13, 'Marker', 'Stationery', 50, 3.5, 1.5, '2025-05-28'),
(14, 'File Folder', 'Stationery', 40, 4, 2.5, '2025-06-01'),
(15, 'Stapler', 'Stationery', 20, 6, 3, '2025-06-03');

SELECT * FROM SALES_DATA;

WITH RECENT_SALES AS (SELECT
*,
(UNIT_PRICE - COST_PRICE)*QUANTITY AS PROFIT
FROM SALES_DATA),
CATEGORY_SALES AS (SELECT CATEGORY,
SUM(PROFIT) AS CAT_PROFIT
FROM RECENT_SALES
GROUP BY CATEGORY),
RANKED_PRODUCTS AS (SELECT 
RS.PRODUCT,
RS.CATEGORY,
RS.PROFIT,
CS.CAT_PROFIT,
ROUND(((RS.PROFIT*100)/CS.CAT_PROFIT),2) AS CAT_PROFIT_SHARE,
RANK() OVER(PARTITION BY RS.CATEGORY ORDER BY RS.PROFIT DESC) AS RNK
FROM RECENT_SALES RS
JOIN CATEGORY_SALES CS
ON RS.CATEGORY = CS.CATEGORY
ORDER BY RS.CATEGORY)
SELECT
CATEGORY,
PRODUCT,
PROFIT,
CAT_PROFIT,
CAT_PROFIT_SHARE
FROM RANKED_PRODUCTS
WHERE RNK<= 2
ORDER BY CATEGORY,PROFIT DESC;

  
