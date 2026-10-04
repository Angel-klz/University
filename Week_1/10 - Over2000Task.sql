SELECT c.customer_name, COALESCE(SUM(o.sales), 0) as gen_sum
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY customer_name
HAVING SUM(o.sales) >= 2000;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;