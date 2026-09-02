SELECT order_id
FROM (SELECT order_id, creation_time FROM orders) AS t1
INNER JOIN
(SELECT order_id, time FROM courier_actions WHERE action = 'deliver_order') AS t2
USING(order_id)
ORDER BY time - creation_time desc
LIMIT 10