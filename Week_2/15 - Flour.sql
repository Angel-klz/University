SELECT DISTINCT x1.region
FROM flourmills_sales x1
WHERE NOT EXISTS (
    SELECT 1
    FROM flourmills_sales x2
    WHERE x2.region = x1.region
      AND x2.product_caterogy = 'Flour'
);