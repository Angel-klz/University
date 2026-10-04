SELECT 
    c.customer_name, 
    SUM(o.sales) AS total_sales, 
    AVG(o.discount) AS avg_discount, 
    COUNT(o.order_id) AS order_amount, 
    CASE 
        WHEN SUM(o.sales) > 2500 THEN 'VIP'  
        ELSE 'REGULAR' 
    END AS c_type
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_sales DESC;
