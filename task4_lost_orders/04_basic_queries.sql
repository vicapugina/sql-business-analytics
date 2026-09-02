WITH subquery AS (SELECT order_id FROM courier_actions WHERE action = 'deliver_order') 
SELECT COUNT(DISTINCT order_id) AS orders_count
FROM user_actions
WHERE order_id NOT IN (SELECT order_id FROM subquery)