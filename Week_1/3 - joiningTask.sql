SELECT c.customer_name, p.product_id, p.category, o.sales
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
ORDER BY sales ASC;


SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;