SELECT x1.*
FROM flourmills_sales x1
WHERE EXISTS(
    SELECT 1
    FROM flourmills_sales x2
    WHERE x2.product_name = x1.product_name
    GROUP BY x2.product_name
    HAVING COUNT(DISTINCT EXTRACT(MONTH FROM x2.sale_date)) > 1
);