-- Title: Registered City vs Delivery City Mismatch
-- Description: Counts distinct customers whose delivery city differs from the city in their registered address.

WITH customer_city AS (
    SELECT
        id AS customer_id,
        TRIM(SPLIT_PART(address, ',', 3)) AS registered_city
    FROM customers
)
SELECT COUNT(DISTINCT o.customer_id) AS mismatch_customer_count
FROM orders o
JOIN customer_city c ON o.customer_id = c.customer_id
WHERE o.delivery_city <> c.registered_city;
