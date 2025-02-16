SELECT
    c.customer_id,
    c.first_name_hashed,
    c.last_name_hashed,
    SUM(o.order_value) as total_sales
  FROM
    `mlcase-hassakura.case1.customers` AS c
    INNER JOIN `mlcase-hassakura.case1.orders` AS o ON c.customer_id = o.seller_id
  WHERE
    EXTRACT(MONTH FROM c.birth_date) = EXTRACT(MONTH FROM DATE("2025-05-10"))
    AND EXTRACT(DAY FROM c.birth_date) = EXTRACT(DAY FROM DATE("2025-05-10"))
    -- EXTRACT(MONTH FROM c.birth_date) = EXTRACT(MONTH FROM CURRENT_DATE())
    -- AND EXTRACT(DAY FROM c.birth_date) = EXTRACT(DAY FROM CURRENT_DATE())

    -- The original code is commented. The extraction was hardcoded just to have at least one customer in the output

    AND o.created_at BETWEEN '2020-01-01' AND '2020-01-31'
    AND o.cancelled_at is null
  GROUP BY 1, 2, 3
HAVING SUM(o.order_value) > 1500;