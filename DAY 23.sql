-- DAY 23 OF 100 : For each user who converted, calculate the delay (in days) between click_date and conversion_date. Then:
-- Calculate the average conversion delay per campaign
-- For each user, categorize their delay
-- Exclude users who never converted.

CREATE TABLE campaign_conversion (
  user_id INTEGER,
  campaign_name TEXT,
  click_date DATE,
  conversion_date DATE
);

INSERT INTO campaign_conversion VALUES
(101, 'Diwali Blast', '2025-07-01', '2025-07-03'),
(102, 'Diwali Blast', '2025-07-01', '2025-07-01'),
(103, 'Diwali Blast', '2025-07-02', NULL),
(104, 'Diwali Blast', '2025-07-03', '2025-07-10'),
(105, 'Diwali Blast', '2025-07-03', NULL),
(106, 'Festive Sale', '2025-07-02', '2025-07-02'),
(107, 'Festive Sale', '2025-07-02', '2025-07-04'),
(108, 'Festive Sale', '2025-07-03', '2025-07-09'),
(109, 'Festive Sale', '2025-07-03', NULL),
(110, 'Festive Sale', '2025-07-04', NULL);

SELECT * FROM campaign_conversion;

WITH DELAY_DATA AS (SELECT
USER_ID,
CAMPAIGN_NAME,
CLICK_DATE,
CONVERSION_DATE,
(CONVERSION_DATE - CLICK_DATE) AS DELAY_IN_DAYS
FROM campaign_conversion
WHERE CONVERSION_DATE IS NOT NULL),
AVERAGE_DELAY AS (SELECT
CAMPAIGN_NAME,
ROUND(AVG(DELAY_IN_DAYS)::NUMERIC ,2) AS AVG_DELAY
FROM DELAY_DATA
GROUP BY CAMPAIGN_NAME)
SELECT
D.USER_ID,
D.CAMPAIGN_NAME,
D.CLICK_DATE,
D.CONVERSION_DATE,
D.DELAY_IN_DAYS,
A.AVG_DELAY,
CASE 
	WHEN D.DELAY_IN_DAYS < A.AVG_DELAY THEN 'FAST'
	WHEN D.DELAY_IN_DAYS = A.AVG_DELAY THEN 'AVERAGE'
	WHEN D.DELAY_IN_DAYS > A.AVG_DELAY THEN 'SLOW'
	END AS DELAY_CATEGORY
FROM DELAY_DATA D
JOIN
AVERAGE_DELAY A 
ON D.CAMPAIGN_NAME = A.CAMPAIGN_NAME
ORDER BY D.CAMPAIGN_NAME,D.USER_ID;






