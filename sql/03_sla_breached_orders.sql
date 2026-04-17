-- Title: SLA Breached Orders
-- Description: Counts how many orders breached SLA based on same-city (24h) and outside-city (48h) rules.

SELECT COUNT(*) AS sla_breached_orders
FROM orders
WHERE EXTRACT(EPOCH FROM (order_delivery_date - order_pickup_date)) / 3600.0 >
      CASE
          WHEN pickup_city = delivery_city THEN 24
          ELSE 48
      END;
