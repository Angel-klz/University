WITH RECURSIVE date_range AS (
    SELECT
        MIN(sale_date) AS start_date,
        MAX(sale_date) AS end_date
    FROM flourmills_sales
),
calendar AS (
    SELECT start_date AS calendar_date, end_date
    FROM date_range

    UNION ALL

    SELECT (calendar_date + INTERVAL '1 day')::date, end_date
    FROM calendar
    WHERE calendar_date < end_date
)
SELECT calendar_date
FROM calendar
ORDER BY calendar_date ASC;

WITH RECURSIVE date_range AS (
    SELECT MIN(sale_date) AS start_date, MAX(sale_date) AS end_date
    FROM flourmills_sales
),
calendar AS (
    SELECT start_date AS calendar_date, end_date FROM date_range
    UNION ALL
    SELECT (calendar_date + INTERVAL '1 day')::date, end_date
    FROM calendar
    WHERE calendar_date < end_date
)
SELECT COUNT(*) FROM calendar;