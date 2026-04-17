-- Title: City Change Cases from Order Logs
-- Description: Returns city change cases with reason, final status, aging hours, and SLA breach flag.

WITH city_change_logs AS (
    SELECT
        order_id,
        TRIM(SPLIT_PART(description, 'Reason:', 2)) AS city_change_reason
    FROM order_logs
    WHERE description ILIKE '%City Change%'
),
base AS (
    SELECT
        o.order_id,
        city_change_reason,
        o.order_status AS final_status,
        ROUND(EXTRACT(EPOCH FROM (o.order_delivery_date - o.order_pickup_date)) / 3600.0, 2) AS aging_hours,
        CASE
            WHEN EXTRACT(EPOCH FROM (o.order_delivery_date - o.order_pickup_date)) / 3600.0 >
                 CASE
                     WHEN o.pickup_city = o.delivery_city THEN 24
                     ELSE 48
                 END
            THEN TRUE ELSE FALSE
        END AS sla_breached
    FROM orders o
    JOIN city_change_logs c ON o.order_id = c.order_id
)
SELECT
    order_id,
    city_change_reason,
    final_status,
    aging_hours,
    sla_breached
FROM base
ORDER BY order_id;
