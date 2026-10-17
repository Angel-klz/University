WITH ranked_orders AS (
    SELECT
        c.customer_name,
        o.order_id,
        o.order_date,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date DESC, o.order_id DESC
        ) AS order_rank
    FROM orders o
    JOIN customers c
        ON c.customer_id = o.customer_id
)
SELECT
    customer_name,
    order_id,
    order_date
FROM ranked_orders
WHERE order_rank <= 2
ORDER BY customer_name, order_rank;