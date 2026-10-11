SELECT * 
FROM flourmills_sales x1
WHERE EXISTS(
    SELECT 1 
    FROM flourmills_sales x2
    WHERE x2.region = x1.region
    AND EXTRACT(YEAR FROM x2.sale_date) = 2024
)
