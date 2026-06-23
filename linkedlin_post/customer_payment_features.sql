WITH payments AS (
    SELECT customer_id,
           payment_date,
           amount,
           status
    FROM stg_payments
),

aggregated AS (
    SELECT
        customer_id,
        COUNT(*) AS total_payments,
        SUM(amount) AS total_paid,
        AVG(amount) AS avg_payment,
        SUM(CASE
                WHEN status = 'FAILED' THEN 1
                ELSE 0
            END) AS failed_payments
    FROM payments
    GROUP BY customer_id
)

SELECT *
FROM aggregated
