SELECT 
    product_caterogy,
    total_sales
FROM (
    SELECT
        product_caterogy,
        SUM(total_amount) as total_sales
    FROM flourmills_sales
    GROUP BY product_caterogy
) as subquery
WHERE total_sales > 50000000
ORDER BY total_sales DESC;