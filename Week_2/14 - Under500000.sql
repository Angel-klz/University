SELECT DISTINCT x1.product_caterogy
FROM flourmills_sales x1
WHERE NOT EXISTS (
    SELECT 1
    FROM flourmills_sales x2
    WHERE x2.product_caterogy = x1.product_caterogy
    AND x2.total_amount > 500000
);
