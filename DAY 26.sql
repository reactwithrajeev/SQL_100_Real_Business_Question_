-- DAY 26 OF 100 : Which marketing channels delivered the highest-performing ad in each campaign over the last 60 days
-- based on Click-Through Rate (CTR)?

CREATE TABLE marketing_campaigns (
    campaign_id INT,
    campaign_name VARCHAR,
    start_date DATE,
    end_date DATE
);

INSERT INTO marketing_campaigns VALUES
(101, 'Summer Promo', '2025-05-01', '2025-08-01'),
(102, 'Diwali Blast', '2025-06-10', '2025-09-15'),
(103, 'Year End Bonanza', '2025-06-01', '2025-09-30'),
(104, 'New Product Launch', '2025-07-01', '2025-10-01'),
(105, 'Flash Sale', '2025-06-25', '2025-07-30');

CREATE TABLE ad_performance (
    ad_id INT,
    campaign_id INT,
    ad_name VARCHAR,
    channel VARCHAR,
    impressions INT,
    clicks INT,
    ad_date DATE
);

INSERT INTO ad_performance VALUES
(1, 101, 'Ad A', 'Google', 1000, 120, '2025-07-10'),
(2, 101, 'Ad B', 'Facebook', 800, 80, '2025-07-12'),
(3, 101, 'Ad C', 'Instagram', 1500, 200, '2025-07-18'),
(4, 102, 'Ad D', 'YouTube', 900, 130, '2025-07-01'),
(5, 102, 'Ad E', 'Google', 700, 90, '2025-07-20'),
(6, 102, 'Ad F', 'Instagram', 1200, 110, '2025-07-15'),
(7, 103, 'Ad G', 'Facebook', 1100, 95, '2025-07-05'),
(8, 103, 'Ad H', 'YouTube', 950, 120, '2025-07-08'),
(9, 103, 'Ad I', 'Google', 300, 50, '2025-07-10'),
(10, 104, 'Ad J', 'Instagram', 1300, 250, '2025-07-22'),
(11, 104, 'Ad K', 'YouTube', 1000, 180, '2025-07-24'),
(12, 104, 'Ad L', 'Facebook', 600, 50, '2025-07-20'),
(13, 105, 'Ad M', 'Google', 500, 40, '2025-07-19'),
(14, 105, 'Ad N', 'Facebook', 800, 75, '2025-07-18'),
(15, 105, 'Ad O', 'Instagram', 950, 110, '2025-07-27');

SELECT * FROM MARKETING_CAMPAIGNS;
SELECT * FROM AD_PERFORMANCE;

WITH ALL_CTRS AS (SELECT
AP.AD_ID,
AP.CAMPAIGN_ID,
MC.CAMPAIGN_NAME,
AP.AD_NAME,
AP.CHANNEL,
AP.IMPRESSIONS,
AP.CLICKS,
AP.AD_DATE,
ROUND(((AP.CLICKS*100.00) / AP.IMPRESSIONS),2) AS CTR
FROM
AD_PERFORMANCE AP
JOIN
MARKETING_CAMPAIGNS MC
ON AP.CAMPAIGN_ID = MC.CAMPAIGN_ID
WHERE
AP.AD_DATE >= CURRENT_DATE - INTERVAL '60 DAYS'),
AD_RANK AS (SELECT
*,
ROW_NUMBER() OVER(PARTITION BY CAMPAIGN_ID ORDER BY CTR DESC) AS RN
FROM
ALL_CTRS)
SELECT
CAMPAIGN_NAME,
AD_NAME,
CHANNEL,
CTR
FROM AD_RANK
WHERE RN =1;


























