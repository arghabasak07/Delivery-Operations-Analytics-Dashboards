-- Title: City Change Summary Metrics
-- Description: Summarizes total city change orders, returned cases, SLA breaches, and breach percentage.

WITH city_change_logs AS (
    SELECT DISTINCT order_id
    FROM order_logs
    WHERE description ILIKE '%City Change%'
),
city_change_summary AS (
    SELECT
        o.order_id,
        o.order_status AS final_status,
        EXTRACT(EPOCH FROM (o.order_delivery_date - o.order_pickup_date)) / 3600.0 AS aging_hours,
        CASE
            WHEN EXTRACT(EPOCH FROM (o.order_delivery_date - o.order_pickup_date)) / 3600.0 >
                 CASE
                     WHEN o.pickup_city = o.delivery_city THEN 24
                     ELSE 48
                 END
            THEN 1 ELSE 0
        END AS sla_breached
    FROM orders o
    JOIN city_change_logs c ON o.order_id = c.order_id
)
SELECT
    COUNT(*) AS total_city_change_orders,
    SUM(CASE WHEN final_status = 'Return' THEN 1 ELSE 0 END) AS returned_city_change_orders,
    SUM(sla_breached) AS sla_breached_city_change_orders,
    ROUND(100.0 * SUM(sla_breached) / COUNT(*), 3) AS sla_breached_pct
FROM city_change_summary;
