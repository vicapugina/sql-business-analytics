WITH
no_canceled_order AS (SELECT DISTINCT order_id FROM user_actions WHERE order_id NOT IN (SELECT order_id FROM user_actions WHERE action = 'cancel_order'))

SELECT creation_time AS date, SUM(price) AS revenue
FROM
(SELECT order_id, creation_time::DATE, product_id, price
FROM
(SELECT order_id, creation_time, UNNEST(product_ids) AS product_id
FROM (SELECT * FROM user_actions WHERE order_id IN (SELECT * FROM no_canceled_order)) AS t
    LEFT JOIN orders
    USING (order_id)
) AS q
LEFT JOIN
products
USING(product_id)) AS Q
GROUP BY creation_time