-- DAY 22 OF 100 : The marketing team wants to analyze email campaign effectiveness by understanding user engagement delay
-- and non-engagement rate for each campaign.
-- They ask you to provide:
-- 1). The average time (in hours) it took users to click on the product after receiving the email (only for those who clicked).
-- 2). The percentage of users who never clicked the product after receiving the campaign email.

CREATE TABLE campaign_emails (
    user_id INT,
    campaign_name TEXT,
    sent_time TIMESTAMP
);

INSERT INTO campaign_emails (user_id, campaign_name, sent_time) VALUES
(101, 'Diwali Blast', '2025-07-01 09:00:00'),
(102, 'Diwali Blast', '2025-07-01 09:00:00'),
(103, 'Diwali Blast', '2025-07-01 09:00:00'),
(104, 'Diwali Blast', '2025-07-01 09:00:00'),
(105, 'Diwali Blast', '2025-07-01 09:00:00'),
(106, 'Festive Sale', '2025-07-03 10:00:00'),
(107, 'Festive Sale', '2025-07-03 10:00:00'),
(108, 'Festive Sale', '2025-07-03 10:00:00'),
(109, 'Festive Sale', '2025-07-03 10:00:00'),
(110, 'Festive Sale', '2025-07-03 10:00:00');

CREATE TABLE product_clicks (
    user_id INT,
    campaign_name TEXT,
    click_time TIMESTAMP
);

INSERT INTO product_clicks (user_id, campaign_name, click_time) VALUES
(101, 'Diwali Blast', '2025-07-01 09:05:00'),
(102, 'Diwali Blast', '2025-07-01 12:00:00'),
(104, 'Diwali Blast', '2025-07-01 20:00:00'),
(106, 'Festive Sale', '2025-07-03 11:00:00'),
(107, 'Festive Sale', '2025-07-03 13:15:00'),
(108, 'Festive Sale', '2025-07-03 18:00:00');


SELECT * FROM CAMPAIGN_EMAILS;
SELECT * FROM PRODUCT_CLICKS;

WITH ENGAGEMENT_DATA AS (SELECT
E.USER_ID,
E.CAMPAIGN_NAME,
E.SENT_TIME,
C.CLICK_TIME,
EXTRACT(EPOCH FROM (C.CLICK_TIME - E.SENT_TIME))/3600 AS DELAY_IN_HR
FROM
CAMPAIGN_EMAILS E
LEFT JOIN 
PRODUCT_CLICKS C
ON E.USER_ID = C.USER_ID AND E.CAMPAIGN_NAME = C.CAMPAIGN_NAME)
SELECT
USER_ID,
CAMPAIGN_NAME,
ROUND(AVG(DELAY_IN_HR),2) AS AVG_DELAY_TIME,
COUNT(*) FILTER(WHERE CLICK_TIME IS NULL)*100.00 / COUNT(*) AS NON_ENGAGED_PCT
FROM ENGAGEMENT_DATA
GROUP BY USER_ID,
CAMPAIGN_NAME;











