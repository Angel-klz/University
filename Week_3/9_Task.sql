CREATE OR REPLACE PROCEDURE apply_regional_discount(region_name VARCHAR, discount_rate NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders o
    SET sales = o.sales * (1 - discount_rate)
    FROM customers c
    WHERE o.customer_id = c.customer_id
      AND c.region = region_name;

    RAISE NOTICE 'Applied discount % to region %', discount_rate, region_name;
END;
$$;
CALL apply_regional_discount('West', 0.10);