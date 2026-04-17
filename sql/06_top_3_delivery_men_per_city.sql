-- Title: Top 3 Delivery Men per Delivery City
-- Description: Ranks delivery men within each delivery city based on delivered order count and returns the top 3.

WITH delivered_orders AS (
    SELECT
        o.delivery_city,
        o.delivery_man_id,
        dm.name AS delivery_man_name,
        COUNT(*) AS delivered_order_count
    FROM orders o
    JOIN delivery_men dm ON o.delivery_man_id = dm.id
    WHERE o.order_status = 'Delivery'
    GROUP BY o.delivery_city, o.delivery_man_id, dm.name
),
ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY delivery_city
               ORDER BY delivered_order_count DESC, delivery_man_id
           ) AS rn
    FROM delivered_orders
)
SELECT
    delivery_city,
    delivery_man_id,
    delivery_man_name,
    delivered_order_count
FROM ranked
WHERE rn <= 3
ORDER BY delivery_city, rn;
