SELECT 
    x1.product_name, 
    x1.region, 
    x1.total_amount,
    (SELECT MIN(x2.total_amount)
    FROM flourmills_sales x2
    WHERE x2.region = x1.region) AS region_min_a
FROM flourmills_sales x1
ORDER BY x1.sales_id
LIMIT 5;
