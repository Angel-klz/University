SELECT
    product_name,
    total_amount,
    total_amount / (SELECT SUM(total_amount) FROM flourmills_sales) AS amount_sh
FROM flourmills_sales;