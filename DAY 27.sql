-- DAY 27 OF 100 : Identify the top 3 campaigns in the last 30 days that have the highest 'Quality Score'.
-- Return campaign name, platform, quality score, and rank them in descending order.

CREATE TABLE campaign_performance (
    campaign_id INT,
    campaign_name TEXT,
    platform TEXT,
    click_date DATE,
    clicks INT,
    conversions INT,
    time_on_site_seconds INT,
    bounce_rate FLOAT
);

INSERT INTO campaign_performance VALUES
(101, 'Summer Sale 2024', 'Facebook', CURRENT_DATE - INTERVAL '5 days', 1200, 110, 45000, 0.35),
(102, 'Monsoon Deals', 'Google', CURRENT_DATE - INTERVAL '12 days', 800, 90, 30000, 0.25),
(103, 'July Bonanza', 'Instagram', CURRENT_DATE - INTERVAL '18 days', 1500, 100, 60000, 0.5),
(104, 'Flash Friday', 'Facebook', CURRENT_DATE - INTERVAL '8 days', 2000, 140, 70000, 0.4),
(105, 'Big Bang Promo', 'Google', CURRENT_DATE - INTERVAL '25 days', 900, 45, 25000, 0.6),
(106, 'End of Season', 'Instagram', CURRENT_DATE - INTERVAL '3 days', 1800, 160, 85000, 0.28),
(107, 'Clearance Sale', 'Facebook', CURRENT_DATE - INTERVAL '15 days', 1000, 50, 27000, 0.45),
(108, 'Raksha Bandhan Promo', 'Google', CURRENT_DATE - INTERVAL '7 days', 1700, 190, 92000, 0.3),
(109, 'August Steals', 'Instagram', CURRENT_DATE - INTERVAL '2 days', 1600, 150, 80000, 0.27),
(110, 'Budget Boost', 'Facebook', CURRENT_DATE - INTERVAL '1 days', 1100, 100, 50000, 0.32);

SELECT * FROM CAMPAIGN_PERFORMANCE;

WITH LAST_30_DAYS AS (SELECT
CAMPAIGN_NAME,
PLATFORM,
SUM(CONVERSIONS)*1.0 / SUM(CLICKS) AS CONVERSION_RATE,
SUM(TIME_ON_SITE_SECONDS)*1.0 / SUM(CLICKS) AS AVG_TIME_SPENT,
AVG(BOUNCE_RATE) AS AVG_BOUNCE_RATE
FROM
CAMPAIGN_PERFORMANCE
WHERE 
CLICK_DATE >= CURRENT_DATE - INTERVAL '30 DAYS'
GROUP BY CAMPAIGN_NAME,
PLATFORM)
SELECT
CAMPAIGN_NAME,
PLATFORM,
ROUND(((AVG_TIME_SPENT * CONVERSION_RATE ) / AVG_BOUNCE_RATE)::NUMERIC,2) AS QUALITY_SCORE
FROM
LAST_30_DAYS
ORDER BY QUALITY_SCORE DESC
LIMIT 3;










