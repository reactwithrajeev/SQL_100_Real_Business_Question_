-- DAY 21 OF 100 : As a marketing analyst, your team wants to understand where users are dropping off in a 3-step marketing funnel.
-- A campaign drives traffic to a landing page, and from there users may:
-- Click a product (Step 1)
-- Add product to cart (Step 2)
-- Complete purchase (Step 3)
-- You are asked to calculate conversion drop-off rates at each step and 
-- identify which campaigns are losing users between Step 1 and Step 2 the most.

CREATE TABLE campaign_funnel (
    user_id INT,
    campaign_name VARCHAR,
    event_date DATE,
    funnel_step VARCHAR, -- 'click_product', 'add_to_cart', 'purchase'
    event_time TIMESTAMP
);

INSERT INTO campaign_funnel (user_id, campaign_name, event_date, funnel_step, event_time) VALUES
(101, 'Winter Blast', '2025-07-17', 'click_product', '2025-07-17 10:01:05'),
(101, 'Winter Blast', '2025-07-17', 'add_to_cart', '2025-07-17 10:02:12'),
(101, 'Winter Blast', '2025-07-17', 'purchase', '2025-07-17 10:04:40'),
(102, 'Winter Blast', '2025-07-17', 'click_product', '2025-07-17 10:11:15'),
(103, 'Festive Frenzy', '2025-07-18', 'click_product', '2025-07-18 12:25:45'),
(103, 'Festive Frenzy', '2025-07-18', 'add_to_cart', '2025-07-18 12:26:05'),
(104, 'Festive Frenzy', '2025-07-18', 'click_product', '2025-07-18 13:05:12'),
(104, 'Festive Frenzy', '2025-07-18', 'add_to_cart', '2025-07-18 13:06:20'),
(104, 'Festive Frenzy', '2025-07-18', 'purchase', '2025-07-18 13:07:00'),
(105, 'Winter Blast', '2025-07-18', 'click_product', '2025-07-18 14:01:10'),
(105, 'Winter Blast', '2025-07-18', 'add_to_cart', '2025-07-18 14:03:25');

select * from campaign_funnel;

WITH STEPS_COUNT AS (SELECT 
CAMPAIGN_NAME,
COUNT(CASE WHEN FUNNEL_STEP = 'click_product' THEN 1 END) AS CLICKED_PRODUCT_COUNT,
COUNT(CASE WHEN FUNNEL_STEP = 'add_to_cart' THEN 1 END) AS ADDED_TO_CART,
COUNT(CASE WHEN FUNNEL_STEP = 'purchase' THEN 1 END) AS PRODUCT_PURCHASED
FROM
CAMPAIGN_FUNNEL
GROUP BY CAMPAIGN_NAME)
SELECT
*,
ROUND(((CLICKED_PRODUCT_COUNT - ADDED_TO_CART)::NUMERIC /CLICKED_PRODUCT_COUNT)*100,2) AS DROP_OFF_STEP1_TO_2,
ROUND(((ADDED_TO_CART - PRODUCT_PURCHASED)::NUMERIC /ADDED_TO_CART)*100,2) AS DROP_OFF_STEP2_TO_3
FROM
STEPS_COUNT;





