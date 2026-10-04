SELECT p.product_name, COALESCE(SUM(o.sales), 0) as gen_sum
FROM products p
LEFT JOIN orders o on p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY gen_sum DESC;



SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;