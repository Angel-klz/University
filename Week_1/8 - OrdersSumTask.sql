SELECT c.customer_name, COUNT(o.order_id) as orders_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;