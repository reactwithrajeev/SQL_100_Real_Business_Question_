-- DAY 24 OF 100 : As a marketing analyst, your manager has asked you to analyze how ad campaigns are performing in different regions.
-- Find the top performing campaign (based on conversion rate) in each region, along with key performance metrics:
-- Total impressions
-- Total clicks
-- Total conversions
-- Conversion rate
-- Click-through rate (CTR)
-- ROI


CREATE TABLE ad_campaigns (
    campaign_id SERIAL PRIMARY KEY,
    campaign_name TEXT,
    region TEXT
);

INSERT INTO ad_campaigns (campaign_name, region) VALUES
('Diwali Blast', 'North'),
('Diwali Blast', 'South'),
('Festive Sale', 'North'),
('Festive Sale', 'West'),
('New Year Bonanza', 'East');

CREATE TABLE ad_performance (
    ad_id SERIAL PRIMARY KEY,
    campaign_id INT,
    user_id INT,
    impressions INT,
    clicks INT,
    conversions INT,
    spend NUMERIC,
    revenue NUMERIC,
    date DATE
);

INSERT INTO ad_performance (campaign_id, user_id, impressions, clicks, conversions, spend, revenue, date) VALUES
(1, 101, 1000, 120, 10, 500, 1000, '2025-07-01'),
(1, 102, 1500, 130, 15, 700, 1300, '2025-07-02'),
(2, 103, 900, 80, 6, 300, 700, '2025-07-02'),
(3, 104, 1200, 110, 12, 450, 950, '2025-07-03'),
(4, 105, 800, 50, 4, 200, 400, '2025-07-03'),
(5, 106, 1600, 150, 20, 800, 1600, '2025-07-04'),
(3, 107, 1100, 90, 9, 420, 880, '2025-07-04'),
(1, 108, 1000, 140, 14, 600, 1200, '2025-07-05'),
(2, 109, 950, 95, 8, 350, 780, '2025-07-05'),
(4, 110, 1000, 100, 10, 400, 900, '2025-07-05');

SELECT * FROM AD_CAMPAIGNS;
SELECT * FROM AD_PERFORMANCE;

WITH CAMP_DATA AS (SELECT
AC.CAMPAIGN_NAME,
AC.REGION,
AP.CAMPAIGN_ID,
SUM(IMPRESSIONS) AS TOTAL_IMPRESSIONS,
SUM(CLICKS) AS TOTAL_CLICKS,
SUM(CONVERSIONS) AS TOTAL_CONVERSIONS,
ROUND(SUM(CONVERSIONS)::NUMERIC / NULLIF(SUM(CLICKS),0)*100,2) AS CONVERSION_RATE,
ROUND(SUM(CLICKS)::NUMERIC / NULLIF(SUM(IMPRESSIONS),0)*100,2) AS CTR,
ROUND(((SUM(REVENUE) - SUM(SPEND))/ SUM(SPEND))*100,2) AS ROI
FROM
AD_CAMPAIGNS AC
JOIN AD_PERFORMANCE AP
ON AC.CAMPAIGN_ID = AP.CAMPAIGN_ID
GROUP BY 
AC.CAMPAIGN_NAME,
AC.REGION,
AP.CAMPAIGN_ID),
RANKED_CAMP AS (SELECT
*,
RANK() OVER(PARTITION BY REGION ORDER BY CONVERSION_RATE DESC) AS RN
FROM
CAMP_DATA)
SELECT
REGION,
CAMPAIGN_NAME,
TOTAL_IMPRESSIONS,
TOTAL_CLICKS,
TOTAL_CONVERSIONS,
CONVERSION_RATE,
CTR,
ROI
FROM
RANKED_CAMP
WHERE RN = 1
ORDER BY REGION,CAMPAIGN_NAME;

















