SELECT 
    c.region, 
    COUNT(CASE WHEN o.sales > 1000 THEN 1 END) as high_value, 
    COUNT(CASE WHEN o.sales <= 1000 THEN 1 END) as low_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;


SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;