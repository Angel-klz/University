SELECT SUM(total_amount)
FROM flourmills_sales
WHERE EXTRACT(MONTH FROM sale_date) = 8;