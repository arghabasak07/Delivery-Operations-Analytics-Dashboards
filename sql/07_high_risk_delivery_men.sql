-- Title: Delivery Men with Tenure > 30 Days and Return Ratio > 20%
-- Description: Identifies delivery men whose tenure is more than 30 days and return ratio is above 20%.

WITH max_dt AS (
    SELECT MAX(order_delivery_date) AS max_delivery_date
    FROM orders
),
delivery_man_stats AS (
    SELECT
        o.delivery_man_id,
        dm.name AS delivery_man_name,
        dm.working_area,
        DATE_PART('day', max_delivery_date - dm.joining_date) AS tenure_days,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN o.order_status = 'Return' THEN 1 ELSE 0 END) AS returned_orders,
        ROUND(
            1.0 * SUM(CASE WHEN o.order_status = 'Return' THEN 1 ELSE 0 END) / COUNT(*),
            4
        ) AS return_ratio
    FROM orders o
    JOIN delivery_men dm ON o.delivery_man_id = dm.id
    CROSS JOIN max_dt
    GROUP BY o.delivery_man_id, dm.name, dm.working_area, dm.joining_date, max_delivery_date
)
SELECT
    delivery_man_id,
    delivery_man_name,
    working_area,
    tenure_days,
    total_orders,
    returned_orders,
    return_ratio
FROM delivery_man_stats
WHERE tenure_days > 30
  AND return_ratio > 0.20
ORDER BY return_ratio DESC, delivery_man_id;
