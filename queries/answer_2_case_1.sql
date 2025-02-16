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