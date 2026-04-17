-- Title: Multiple Deliveries to the Same Customer in the Last 7 Days
-- Description: Counts customers who received more than one order in the last 7 days, based on the latest delivery date in the dataset.

WITH max_dt AS (
    SELECT MAX(order_delivery_date) AS max_delivery_date
    FROM orders
),
last_7_days AS (
    SELECT *
    FROM orders, max_dt
    WHERE order_delivery_date >= max_delivery_date - INTERVAL '7 days'
)
SELECT COUNT(*) AS customer_count
FROM (
    SELECT customer_id
    FROM last_7_days
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) t;
