-- DAY 19 OF 100 : As a marketing analyst, you are asked to identify "fatigue patterns" in ad campaigns.
-- Specifically, for each campaign and channel, identify any 3 consecutive days where:
-- Impressions were consistently high, but
-- Conversion rates declined each day
-- This helps the marketing team spot when audiences may be tired of seeing the same ad, even if it’s still heavily promoted.


CREATE TABLE marketing_campaign_stats (
    campaign_id INT,
    campaign_name TEXT,
    channel TEXT,
    report_date DATE,
    impressions INT,
    clicks INT,
    conversions INT,
    spend NUMERIC(10,2)
);

INSERT INTO marketing_campaign_stats VALUES
(1, 'Diwali Dhamaka', 'Facebook', '2025-07-01', 10000, 500, 80, 120.00),
(1, 'Diwali Dhamaka', 'Facebook', '2025-07-02', 12000, 600, 75, 130.00),
(1, 'Diwali Dhamaka', 'Facebook', '2025-07-03', 11000, 550, 60, 115.00),
(1, 'Diwali Dhamaka', 'Facebook', '2025-07-04', 9500, 480, 55, 110.00),
(2, 'Summer Splash', 'Google', '2025-07-01', 15000, 800, 150, 200.00),
(2, 'Summer Splash', 'Google', '2025-07-02', 14000, 790, 145, 190.00),
(2, 'Summer Splash', 'Google', '2025-07-03', 14500, 780, 140, 185.00),
(3, 'Monsoon Madness', 'Instagram', '2025-07-01', 9000, 300, 60, 90.00),
(3, 'Monsoon Madness', 'Instagram', '2025-07-02', 9500, 310, 58, 95.00),
(3, 'Monsoon Madness', 'Instagram', '2025-07-03', 9700, 320, 52, 100.00),
(3, 'Monsoon Madness', 'Instagram', '2025-07-04', 9900, 330, 50, 102.00);

SELECT * FROM marketing_campaign_stats;

WITH ENRICHED_DATA AS (SELECT
*,
CASE 
	WHEN CLICKS >0 THEN ROUND(CONVERSIONS::NUMERIC / CLICKS,2)
	ELSE NULL
	END AS CONVERSION_RATE
FROM marketing_campaign_stats),
RANKED_DATA AS (SELECT
*,
ROW_NUMBER() OVER(PARTITION BY CAMPAIGN_ID,CHANNEL ORDER BY REPORT_DATE) AS RN
FROM 
ENRICHED_DATA),
WINDOWS_DATA AS (SELECT
A.CAMPAIGN_ID,
A.CAMPAIGN_NAME,
A.CHANNEL,
A.REPORT_DATE AS DAY_1,
B.REPORT_DATE AS DAY_2,
C.REPORT_DATE AS DAY_3,
A.IMPRESSIONS AS IMP1,
B.IMPRESSIONS AS IMP2,
C.IMPRESSIONS AS IMP3,
A.CONVERSION_RATE AS CR1,
B.CONVERSION_RATE AS CR2,
C.CONVERSION_RATE AS CR3
FROM
RANKED_DATA A
JOIN 
RANKED_DATA B
ON A.CAMPAIGN_ID = B.CAMPAIGN_ID AND A.CHANNEL = B.CHANNEL AND B.RN =A.RN+1
JOIN 
RANKED_DATA C
ON A.CAMPAIGN_ID = C.CAMPAIGN_ID AND A.CHANNEL = C.CHANNEL AND C.RN =A.RN+2)
SELECT
CAMPAIGN_ID,
CAMPAIGN_NAME,
CHANNEL,
DAY_1,
DAY_2,
DAY_3,
CR1,
CR2,
CR3
FROM WINDOWS_DATA
WHERE
IMP1>=9000 AND IMP2>=9000 AND IMP3>=9000
AND
CR1>CR2 AND CR2>CR3;







