WITH
delivered_order AS (SELECT order_id FROM courier_actions WHERE action = 'deliver_order'AND time BETWEEN '2022-09-01' AND '2022-10-01')

SELECT products.name, COUNT(*) AS times_purchased
FROM
(SELECT DISTINCT order_id, UNNEST(product_ids) AS product_id
FROM orders 
WHERE order_id IN (SELECT * FROM delivered_order)) AS t1
LEFT JOIN
products
USING(product_id)
GROUP BY products.name, t1.product_id
ORDER BY times_purchased DESC
LIMIT 10