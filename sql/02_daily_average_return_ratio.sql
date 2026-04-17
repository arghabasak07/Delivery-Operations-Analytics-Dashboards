-- Title: Daily Average Return Ratio
-- Description: Calculates the daily return ratio and then computes the average across all delivery days.

WITH daily_return AS (
    SELECT
        DATE(order_delivery_date) AS delivery_day,
        AVG(CASE WHEN order_status = 'Return' THEN 1.0 ELSE 0 END) AS daily_return_ratio
    FROM orders
    GROUP BY DATE(order_delivery_date)
)
SELECT
    COUNT(*) AS total_days,
    ROUND(100.0 * AVG(daily_return_ratio), 3) AS daily_avg_return_ratio_pct
FROM daily_return;
