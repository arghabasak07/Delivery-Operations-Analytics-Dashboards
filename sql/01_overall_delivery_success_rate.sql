-- Title: Overall Delivery Success Rate
-- Description: Calculates total orders, delivered orders, and delivery success rate.

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Delivery' THEN 1 ELSE 0 END) AS delivered_orders,
    ROUND(
        100.0 * SUM(CASE WHEN order_status = 'Delivery' THEN 1 ELSE 0 END) / COUNT(*),
        3
    ) AS delivery_success_rate_pct
FROM orders;
