SELECT DISTINCT x1.product_caterogy
FROM flourmills_sales x1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales x2
    WHERE x2.product_caterogy = x1.product_caterogy
    GROUP BY x2.product_caterogy
    HAVING COUNT(DISTINCT x2.region) > 3
)
ORDER BY x1.product_caterogy;