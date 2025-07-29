-- DAY 25 OF 100 : You are working as a data analyst for a digital marketing agency. 
-- The marketing team wants to understand user behavior for repeat ad viewers.
-- Specifically, they want you to identify:
-- Users who have seen the same ad at least 3 times
-- The average time gap between their first and last view
-- And how many of these users clicked on the ad at least once.


CREATE TABLE ad_impressions (
    user_id INT,
    ad_id INT,
    impression_time TIMESTAMP,
    clicked BOOLEAN
);

INSERT INTO ad_impressions (user_id, ad_id, impression_time, clicked) VALUES
(101, 201, '2025-07-20 10:00:00', FALSE),
(101, 201, '2025-07-21 12:30:00', FALSE),
(101, 201, '2025-07-23 09:15:00', TRUE),
(102, 202, '2025-07-21 14:00:00', FALSE),
(102, 202, '2025-07-21 15:00:00', FALSE),
(103, 203, '2025-07-19 11:00:00', TRUE),
(103, 203, '2025-07-20 11:00:00', FALSE),
(103, 203, '2025-07-21 11:00:00', FALSE),
(104, 204, '2025-07-22 13:00:00', FALSE),
(105, 205, '2025-07-22 15:00:00', TRUE),
(105, 205, '2025-07-24 16:00:00', TRUE),
(105, 205, '2025-07-25 17:00:00', TRUE);

SELECT * FROM AD_IMPRESSIONS;

SELECT
USER_ID,
AD_ID,
COUNT(*),
ROUND(EXTRACT(EPOCH FROM (MAX(IMPRESSION_TIME) - MIN(IMPRESSION_TIME)))/86400,2) AS TIME_GAP_IN_DAYS,
CASE
	WHEN BOOL_OR(CLICKED) THEN 'YES'
	ELSE 'NO'
	END AS CLICKED_ATLEAST_ONCE
FROM
AD_IMPRESSIONS
GROUP BY 
USER_ID,
AD_ID
HAVING COUNT(*) >=3;















