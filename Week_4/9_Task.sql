WITH monthly_sales AS (
    SELECT
        country,
        DATE_TRUNC('month', invoice_date)::date AS month,
        customer_id,
        ROUND(SUM(quantity * unit_price)::numeric, 2) AS total_amount
    FROM retail_sales
    WHERE customer_id IS NOT NULL
      AND quantity > 0
      AND unit_price > 0
    GROUP BY country, DATE_TRUNC('month', invoice_date), customer_id
),
ranked_sales AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY country, month
            ORDER BY total_amount DESC
        ) AS sales_rank
    FROM monthly_sales
)
SELECT country, month, customer_id, total_amount, sales_rank
FROM ranked_sales
WHERE sales_rank <= 5
ORDER BY country, month, sales_rank, customer_id;