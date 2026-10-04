SELECT p.category, AVG(o.discount) as avg_dis
FROM products p 
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;