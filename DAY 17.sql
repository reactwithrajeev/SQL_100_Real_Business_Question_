-- DAY 17 OF 100 : For each marketing campaign, calculate these performance metrics over its active period:
-- Total impressions
-- Total clicks
-- Total conversions
-- Total spend
-- Click-through rate (CTR)
-- Conversion rate
-- Cost per conversion


CREATE TABLE marketing_campaigns (
    campaign_id SERIAL PRIMARY KEY,
    campaign_name VARCHAR(100),
    channel VARCHAR(50),
    start_date DATE,
    end_date DATE
);

CREATE TABLE campaign_performance (
    performance_id SERIAL PRIMARY KEY,
    campaign_id INT REFERENCES marketing_campaigns(campaign_id),
    report_date DATE,
    impressions INT,
    clicks INT,
    conversions INT,
    spend DECIMAL(10,2)
);

INSERT INTO marketing_campaigns (campaign_name, channel, start_date, end_date) VALUES
('Summer Sale', 'Email', '2025-06-01', '2025-06-30'),
('Flash Discount', 'Social Media', '2025-06-10', '2025-06-20'),
('New Arrivals', 'Search', '2025-06-15', '2025-07-10'),
('Winter Bonanza', 'Display', '2025-06-05', '2025-06-25'),
('VIP Exclusive', 'Influencer', '2025-06-12', '2025-06-28');

INSERT INTO campaign_performance (campaign_id, report_date, impressions, clicks, conversions, spend) 
VALUES
(1, '2025-06-05', 5200, 320, 32, 410.00),
(1, '2025-06-10', 5300, 330, 34, 420.00),
(1, '2025-06-15', 6000, 350, 40, 500.00),
(1, '2025-06-20', 7000, 400, 50, 600.00),
(1, '2025-06-25', 6500, 390, 45, 570.00),
(2, '2025-06-11', 8000, 600, 60, 700.00),
(2, '2025-06-13', 8100, 610, 62, 710.00),
(2, '2025-06-15', 8500, 620, 65, 750.00),
(2, '2025-06-18', 9000, 650, 70, 800.00),
(2, '2025-06-20', 9200, 670, 72, 820.00),
(3, '2025-06-16', 4000, 220, 25, 350.00),
(3, '2025-06-18', 4200, 230, 27, 360.00),
(3, '2025-06-20', 4500, 250, 28, 400.00),
(3, '2025-06-25', 5000, 300, 35, 450.00),
(3, '2025-07-01', 5200, 320, 36, 470.00),
(4, '2025-06-06', 6000, 340, 38, 430.00),
(4, '2025-06-10', 6100, 350, 39, 440.00),
(4, '2025-06-15', 6200, 355, 41, 450.00),
(4, '2025-06-20', 6300, 360, 43, 460.00),
(4, '2025-06-25', 6400, 365, 44, 470.00),
(5, '2025-06-13', 3000, 180, 20, 250.00),
(5, '2025-06-16', 3200, 190, 22, 260.00),
(5, '2025-06-20', 3500, 210, 24, 280.00),
(5, '2025-06-24', 3700, 220, 26, 290.00),
(5, '2025-06-28', 3900, 230, 28, 300.00);

SELECT * FROM marketing_campaigns;
SELECT * FROM campaign_performance;


SELECT
	MC.CAMPAIGN_NAME,
	MC.CHANNEL,
	SUM(CP.IMPRESSIONS) AS TOTAL_IMPRESSION,
	SUM(CP.CLICKS) AS TOTAL_CLICK,
	SUM(CP.CONVERSIONS) AS TOTAL_CONVERSION,
	SUM(CP.SPEND) AS TOTAL_SPEND,
	ROUND(SUM(CP.CLICKS)::NUMERIC / SUM(CP.IMPRESSIONS), 3) AS CTR,
	ROUND(SUM(CP.CONVERSIONS)::NUMERIC / SUM(CP.CLICKS), 3) AS CONVERSION_RATE,
	ROUND(SUM(CP.SPEND)::NUMERIC / SUM(CP.CONVERSIONS), 3) AS COST_PER_CONVERSION
FROM
	MARKETING_CAMPAIGNS MC
	JOIN CAMPAIGN_PERFORMANCE CP ON MC.CAMPAIGN_ID = CP.CAMPAIGN_ID
GROUP BY
	MC.CAMPAIGN_NAME,
	MC.CHANNEL
ORDER BY
	MC.CAMPAIGN_NAME;














