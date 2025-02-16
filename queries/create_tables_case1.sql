
DROP TABLE IF EXISTS `mlcase-hassakura.case1.customers`;

CREATE OR REPLACE TABLE
  `mlcase-hassakura.case1.customers` (
    customer_id STRING,
    document_hashed STRING,
    email_hashed STRING,
    first_name_hashed STRING,
    last_name_hashed STRING,
    gender STRING,
    birth_date DATE,
    phone_number_hashed STRING,
    type STRING,
    status STRING,
    address_hashed STRUCT<full_address STRING, state STRING, city STRING, country STRING>,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    cancelled_at TIMESTAMP,
    other_columns STRUCT<any_data STRING>
  )
  PARTITION BY DATE(created_at)
  CLUSTER BY customer_id;

ALTER TABLE `mlcase-hassakura.case1.customers` ADD PRIMARY KEY (customer_id) NOT ENFORCED;


DROP TABLE IF EXISTS `mlcase-hassakura.case1.categories`;

CREATE OR REPLACE TABLE
  `mlcase-hassakura.case1.categories` (
    category_id STRING,
    parent_category_id STRING,
    name STRING,
    complete_path STRING,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
  )
  PARTITION BY DATE(created_at)
  CLUSTER BY category_id;


ALTER TABLE `mlcase-hassakura.case1.categories` ADD PRIMARY KEY (category_id) NOT ENFORCED;


DROP TABLE IF EXISTS `mlcase-hassakura.case1.items`;

CREATE OR REPLACE TABLE
  `mlcase-hassakura.case1.items` (
    item_id STRING,
    title STRING,
    description STRING,
    status STRING,
    price NUMERIC,
    category_id STRING,
    seller_id STRING,
    parent_item_id STRING,
    more_columns STRUCT<a_column STRING>,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
  )
  PARTITION BY DATE(created_at)
  CLUSTER BY item_id;


ALTER TABLE `mlcase-hassakura.case1.items` ADD PRIMARY KEY (item_id) NOT ENFORCED;


DROP TABLE IF EXISTS `mlcase-hassakura.case1.orders`;

CREATE OR REPLACE TABLE
  `mlcase-hassakura.case1.orders` (
    order_id STRING,
    item_id STRING,
    buyer_id STRING,
    seller_id STRING,
    status STRING,
    item_quantity NUMERIC,
    item_price NUMERIC,
    order_value NUMERIC,
    more_columns STRUCT<a_column STRING>,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    cancelled_at TIMESTAMP
  )
  PARTITION BY DATE(created_at)
  CLUSTER BY order_id;

ALTER TABLE `mlcase-hassakura.case1.orders` ADD PRIMARY KEY (order_id) NOT ENFORCED;


DROP TABLE IF EXISTS `mlcase-hassakura.case1.items_daily`;

CREATE OR REPLACE TABLE
  `mlcase-hassakura.case1.items_daily` (
    item_id STRING,
    snapshot_date DATE,
    status STRING,
    price NUMERIC,
    updated_at TIMESTAMP
  )
  PARTITION BY snapshot_date
  CLUSTER BY item_id;

ALTER TABLE `mlcase-hassakura.case1.items_daily` ADD PRIMARY KEY (item_id, snapshot_date) NOT ENFORCED;