SELECT c.region, SUM(o.sales) AS gen_sales
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;


SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;