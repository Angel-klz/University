CREATE OR REPLACE PROCEDURE get_customer_sales(p_customer_id VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    total_sales NUMERIC;
BEGIN
    SELECT SUM(sales)
    INTO total_sales
    FROM orders
    WHERE customer_id = p_customer_id;

    RAISE NOTICE 'Customer: %, Total sales: %', p_customer_id, total_sales;
END;
$$;

CALL get_customer_sales('CUST00861');
SELECT customer_id FROM orders LIMIT 1;
CALL get_customer_sales('founf_id');