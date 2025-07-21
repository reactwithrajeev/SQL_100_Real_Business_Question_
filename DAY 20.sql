-- DAY 20 OF 100 : The performance team wants to understand how consistent each campaign is in generating engagement (clicks).
-- For each campaign, calculate the standard deviation of daily click-through rate (CTR) over its active days.
-- This metric will help identify campaigns with stable vs. volatile daily performance
-- campaigns with high variation may need optimization or A/B testing.


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
(1, 'Diwali Dhamaka', 'Facebook', '2025-07-01', 10000, 400, 60, 120.00),
(1, 'Diwali Dhamaka', 'Facebook', '2025-07-02', 11000, 420, 62, 125.00),
(1, 'Diwali Dhamaka', 'Facebook', '2025-07-03', 10500, 410, 58, 122.00),
(1, 'Diwali Dhamaka', 'Facebook', '2025-07-04', 9800, 300, 50, 115.00),
(2, 'Summer Splash', 'Google', '2025-07-01', 14000, 1000, 160, 200.00),
(2, 'Summer Splash', 'Google', '2025-07-02', 13000, 970, 150, 195.00),
(2, 'Summer Splash', 'Google', '2025-07-03', 14500, 800, 120, 190.00),
(3, 'Monsoon Madness', 'Instagram', '2025-07-01', 9000, 310, 58, 92.00),
(3, 'Monsoon Madness', 'Instagram', '2025-07-02', 9300, 280, 50, 91.00),
(3, 'Monsoon Madness', 'Instagram', '2025-07-03', 9500, 270, 48, 95.00);
SELECT * FROM marketing_campaign_stats;

WITH CTR_CALC AS (SELECT
CAMPAIGN_ID,
CAMPAIGN_NAME,
REPORT_DATE,
CASE
	WHEN CLICKS > 0 THEN ROUND(CLICKS::NUMERIC / IMPRESSIONS,2)
	ELSE NULL
	END AS CTR
FROM
marketing_campaign_stats)
SELECT
CAMPAIGN_ID,
CAMPAIGN_NAME,
ROUND(AVG(CTR),4) AS AVG_CTR,
ROUND(STDDEV_POP(CTR),4) AS STDDEV_CTR,
COUNT(*)
FROM CTR_CALC
GROUP BY CAMPAIGN_ID,CAMPAIGN_NAME; 







