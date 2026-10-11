SELECT x1.product_name, x1.product_caterogy, x1.total_amount
FROM flourmills_sales x1
WHERE x1.total_amount > (
    SELECT AVG(x2.total_amount)
    FROM flourmills_sales x2
    WHERE x2.product_caterogy = x1.product_caterogy
); 