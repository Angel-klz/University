SELECT * 
FROM flourmills_sales
WHERE product_caterogy = (
    SELECT product_caterogy
    FROM flourmills_sales
    GROUP BY product_caterogy
    ORDER BY SUM(total_amount) DESC
    LIMIT 1
)
ORDER BY sales_id ASC
LIMIT 5;