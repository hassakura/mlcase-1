-- //////////// ANSWER 1 CASE 1 ///////////////

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

-- //////////// ANSWER 2 CASE 1 ///////////////

WITH
  sales AS (
    SELECT
      DATE_TRUNC(DATE(o.created_at), MONTH) AS reference_month,
      c.first_name_hashed,
      c.last_name_hashed,
      SUM(o.item_quantity) AS total_quantity,
      COUNT(o.order_id) AS total_orders,
      SUM(o.order_value) AS total_revenue
    FROM
      `mlcase-hassakura.case1.orders` AS o
        LEFT JOIN `mlcase-hassakura.case1.customers` AS c ON o.seller_id = c.customer_id
        LEFT JOIN `mlcase-hassakura.case1.items` AS i ON o.item_id = i.item_id
        LEFT JOIN `mlcase-hassakura.case1.categories` AS cat ON i.category_id = cat.category_id
    WHERE
      cat.name = 'cell phones'
        AND DATE(o.created_at) BETWEEN '2020-01-01' AND '2020-12-31'
        AND o.cancelled_at IS NULL
    GROUP BY 1, 2, 3
  ),

  months AS (
    SELECT month
    FROM
      UNNEST( GENERATE_DATE_ARRAY(DATE('2020-01-01'), DATE('2020-12-31'), INTERVAL 1 MONTH) ) AS month
  ),
    
  top_sales AS (
    SELECT
      reference_month,
      first_name_hashed,
      last_name_hashed,
      total_quantity,
      total_orders,
      total_revenue,
      RANK() OVER (PARTITION BY reference_month ORDER BY total_revenue DESC) AS rank_sales
    FROM
      sales
  )

SELECT
  FORMAT_DATE('%Y-%m', m.month) AS year_month,
  COALESCE(first_name_hashed, "--") AS first_name,
  COALESCE(last_name_hashed, "--") AS last_name,
  COALESCE(total_orders, 0) AS total_orders,
  COALESCE(total_quantity, 0) AS total_quantity,
  COALESCE(total_revenue, 0) AS total_revenue,
  COALESCE(rank_sales, 0) AS rank_sales
FROM
  months m
    LEFT JOIN top_sales ts ON m.month = ts.reference_month
WHERE
  ts.rank_sales <= 5
  OR ts.rank_sales IS NULL
ORDER BY
  m.month, rank_sales;

-- //////////// ANSWER 3 CASE 1 ///////////////


CREATE OR REPLACE PROCEDURE `mlcase-hassakura.case1.populate_items_daily`() BEGIN

  MERGE `mlcase-hassakura.case1.items_daily` AS items_daily USING (
    SELECT
        item_id,
        CURRENT_DATE() AS snapshot_date,
        price,
        status,
        CURRENT_TIMESTAMP() AS updated_at
      FROM `mlcase-hassakura.case1.items`
  ) AS items
  ON items_daily.item_id = items.item_id AND items_daily.snapshot_date = items.snapshot_date
  
  WHEN MATCHED THEN UPDATE SET
      price = items.price,
      status = items.status,
      updated_at = items.updated_at
  
  WHEN NOT MATCHED THEN
    INSERT (item_id, snapshot_date, price, status, updated_at)
    VALUES (
      items.item_id, items.snapshot_date, items.price, items.status, items.updated_at
    );
END;

CALL `mlcase-hassakura.case1.populate_items_daily`();