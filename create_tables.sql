
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

-- //////////////// Populate the Table ////////////////////


INSERT INTO `mlcase-hassakura.case1.customers` (customer_id, document_hashed, email_hashed, first_name_hashed, last_name_hashed, gender, birth_date, phone_number_hashed, type, status, address_hashed, created_at, updated_at, cancelled_at, other_columns) VALUES
('customer_id_1', 'document_1', 'email_1', 'first_name_1', 'last_name_1', 'male', DATE('2000-01-01'), 'phone_1', 'buyer', 'active', STRUCT('address_1', 'state_1', 'city_1', 'country_1'), TIMESTAMP('2019-01-01'), TIMESTAMP('2019-01-01'), NULL, STRUCT('other_1')),
('customer_id_2', 'document_2', 'email_2', 'first_name_2', 'last_name_2', 'female', DATE('1995-05-10'), 'phone_2', 'seller', 'active', STRUCT('address_2', 'state_2', 'city_2', 'country_2'), TIMESTAMP('2019-01-02'), TIMESTAMP('2019-01-02'), NULL, STRUCT('other_2')),
('customer_id_3', 'document_3', 'email_3', 'first_name_3', 'last_name_3', 'non binary', DATE('1998-08-15'), 'phone_3', 'seller', 'active', STRUCT('address_3', 'state_3', 'city_3', 'country_3'), TIMESTAMP('2019-01-03'), TIMESTAMP('2019-01-03'), NULL, STRUCT('other_3')),
('customer_id_4', 'document_4', 'email_4', 'first_name_4', 'last_name_4', 'female', DATE('1990-03-22'), 'phone_4', 'buyer', 'active', STRUCT('address_4', 'state_4', 'city_4', 'country_4'), TIMESTAMP('2019-01-04'), TIMESTAMP('2019-01-04'), NULL, STRUCT('other_4')),
('customer_id_5', 'document_5', 'email_5', 'first_name_5', 'last_name_5', 'male', DATE('1992-11-07'), 'phone_5', 'buyer', 'active', STRUCT('address_5', 'state_1', 'city_1', 'country_1'), TIMESTAMP('2019-01-05'), TIMESTAMP('2019-01-05'), NULL, STRUCT('other_5')),
('customer_id_6', 'document_6', 'email_6', 'first_name_6', 'last_name_6', 'female', DATE('1997-06-18'), 'phone_6', 'seller', 'active', STRUCT('address_6', 'state_2', 'city_2', 'country_2'), TIMESTAMP('2019-01-06'), TIMESTAMP('2019-01-06'), NULL, STRUCT('other_6')),
('customer_id_7', 'document_7', 'email_7', 'first_name_7', 'last_name_7', 'other', DATE('1991-04-30'), 'phone_7', 'seller', 'active', STRUCT('address_7', 'state_3', 'city_3', 'country_3'), TIMESTAMP('2019-01-07'), TIMESTAMP('2019-01-07'), NULL, STRUCT('other_7')),
('customer_id_8', 'document_8', 'email_8', 'first_name_8', 'last_name_8', 'female', DATE('1999-09-12'), 'phone_8', 'buyer', 'inactive', STRUCT('address_8', 'state_4', 'city_4', 'country_4'), TIMESTAMP('2019-01-08'), TIMESTAMP('2019-01-08'), NULL, STRUCT('other_8')),
('customer_id_9', 'document_9', 'email_9', 'first_name_9', 'last_name_9', 'male', DATE('1993-02-05'), 'phone_9', 'buyer', 'inactive', STRUCT('address_9', 'state_1', 'city_1', 'country_1'), TIMESTAMP('2019-01-09'), TIMESTAMP('2019-01-09'), NULL, STRUCT('other_9')),
('customer_id_10', 'document_10', 'email_10', 'first_name_10', 'last_name_10', 'female', DATE('1996-07-21'), 'phone_10', 'seller', 'active', STRUCT('address_10', 'state_2', 'city_2', 'country_2'), TIMESTAMP('2019-01-10'), TIMESTAMP('2019-01-10'), NULL, STRUCT('other_10')),
('customer_id_11', 'document_11', 'email_11', 'first_name_11', 'last_name_11', 'male', DATE('1994-12-28'), 'phone_11', 'buyer', 'active', STRUCT('address_11', 'state_3', 'city_3', 'country_3'), TIMESTAMP('2019-01-11'), TIMESTAMP('2019-01-11'), NULL, STRUCT('other_11')),
('customer_id_12', 'document_12', 'email_12', 'first_name_12', 'last_name_12', 'female', DATE('1989-01-14'), 'phone_12', 'seller', 'active', STRUCT('address_12', 'state_4', 'city_4', 'country_4'), TIMESTAMP('2019-01-12'), TIMESTAMP('2019-01-12'), NULL, STRUCT('other_12')),
('customer_id_13', 'document_13', 'email_13', 'first_name_13', 'last_name_13', 'male', DATE('1991-08-03'), 'phone_13', 'buyer', 'active', STRUCT('address_13', 'state_1', 'city_1', 'country_1'), TIMESTAMP('2019-01-13'), TIMESTAMP('2019-01-13'), NULL, STRUCT('other_13')),
('customer_id_14', 'document_14', 'email_14', 'first_name_14', 'last_name_14', 'female', DATE('1993-04-17'), 'phone_14', 'seller', 'inactive', STRUCT('address_14', 'state_2', 'city_2', 'country_12'), TIMESTAMP('2019-01-14'), TIMESTAMP('2019-01-14'), NULL, STRUCT('other_14')),
('customer_id_15', 'document_15', 'email_15', 'first_name_15', 'last_name_15', 'male', DATE('1997-10-25'), 'phone_15', 'buyer', 'active', STRUCT('address_15', 'state_3', 'city_3', 'country_3'), TIMESTAMP('2019-01-15'), TIMESTAMP('2019-01-15'), NULL, STRUCT('other_15'));






INSERT INTO `mlcase-hassakura.case1.categories` (category_id, parent_category_id, name, complete_path, created_at, updated_at, deleted_at) VALUES
('category_id_1', NULL, 'electronics', 'electronics', TIMESTAMP('2019-02-01'), TIMESTAMP('2019-02-01'), NULL),
('category_id_2', 'category_id_1', 'cell phones', 'electronics > cell phones', TIMESTAMP('2019-02-02'), TIMESTAMP('2019-02-02'), NULL),
('category_id_3', 'category_id_2', 'smartphones', 'electronics > cell phones > smartphones', TIMESTAMP('2019-02-03'), TIMESTAMP('2019-02-03'), NULL),
('category_id_4', 'category_id_1', 'accessories', 'electronics > accessories', TIMESTAMP('2019-02-04'), TIMESTAMP('2019-02-04'), NULL),
('category_id_5', NULL, 'clothing', 'clothing', TIMESTAMP('2019-02-05'), TIMESTAMP('2019-02-05'), NULL),
('category_id_6', 'category_id_5', 'mens clothing', 'clothing > mens clothing', TIMESTAMP('2019-02-06'), TIMESTAMP('2019-02-06'), NULL),
('category_id_7', 'category_id_5', 'womens clothing', 'clothing > womens clothing', TIMESTAMP('2019-02-07'), TIMESTAMP('2019-02-07'), NULL);





INSERT INTO `mlcase-hassakura.case1.items` (item_id, title, description, status, price, category_id, seller_id, parent_item_id, more_columns, created_at, updated_at, deleted_at) VALUES
('item_id_1', 'iPhone 14', 'Apple iPhone 14', 'active', 799.00, 'category_id_3', 'customer_id_10', NULL, STRUCT('more_1'), TIMESTAMP('2019-03-01'), TIMESTAMP('2019-03-01'), NULL),
('item_id_2', 'Samsung Galaxy S23', 'Samsung Galaxy S23', 'active', 899.00, 'category_id_3', 'customer_id_12', NULL, STRUCT('more_2'), TIMESTAMP('2019-03-02'), TIMESTAMP('2019-03-02'), NULL),
('item_id_3', 'iPhone 15', 'Apple iPhone 15', 'active', 999.00, 'category_id_3', 'customer_id_2', NULL, STRUCT('more_3'), TIMESTAMP('2019-03-03'), TIMESTAMP('2019-03-03'), NULL),
('item_id_4', 'Case for iPhone 15', 'Clear Case', 'active', 29.99, 'category_id_2', 'customer_id_2', NULL, STRUCT('more_4'), TIMESTAMP('2019-03-04'), TIMESTAMP('2019-03-04'), NULL),
('item_id_5', 'Charger', 'Fast Charger', 'active', 19.99, 'category_id_4', 'customer_id_3', NULL, STRUCT('more_5'), TIMESTAMP('2019-03-05'), TIMESTAMP('2019-03-05'), NULL),
('item_id_6', 'T-Shirt', 'Mens T-Shirt', 'active', 25.00, 'category_id_6', 'customer_id_6', NULL, STRUCT('more_6'), TIMESTAMP('2019-03-06'), TIMESTAMP('2019-03-06'), NULL),
('item_id_7', 'Dress', 'Womens Dress', 'active', 50.00, 'category_id_7', 'customer_id_7', NULL, STRUCT('more_7'), TIMESTAMP('2019-03-07'), TIMESTAMP('2019-03-07'), NULL),
('item_id_8', 'iPhone 13', 'Apple iPhone 13', 'inactive', 699.00, 'category_id_3', 'customer_id_2', NULL, STRUCT('more_8'), TIMESTAMP('2019-03-08'), TIMESTAMP('2019-03-08'), NULL),
('item_id_9', 'Samsung Galaxy S22', 'Samsung Galaxy S22', 'active', 799.00, 'category_id_3', 'customer_id_3', NULL, STRUCT('more_9'), TIMESTAMP('2019-03-09'), TIMESTAMP('2019-03-09'), NULL),
('item_id_10', 'iPhone 12', 'Apple iPhone 12', 'inactive', 599.00, 'category_id_3', 'customer_id_10', NULL, STRUCT('more_10'), TIMESTAMP('2019-03-10'), TIMESTAMP('2019-03-10'), NULL),
('item_id_11', 'Case for iPhone 14', 'Clear Case', 'active', 24.99, 'category_id_2', 'customer_id_10', NULL, STRUCT('more_11'), TIMESTAMP('2019-03-11'), TIMESTAMP('2019-03-11'), NULL),
('item_id_12', 'Charger', 'Fast Charger', 'active', 19.99, 'category_id_4', 'customer_id_3', NULL, STRUCT('more_12'), TIMESTAMP('2019-03-12'), TIMESTAMP('2019-03-12'), NULL),
('item_id_13', 'T-Shirt', 'Mens T-Shirt', 'active', 20.00, 'category_id_6', 'customer_id_6', NULL, STRUCT('more_13'), TIMESTAMP('2019-03-13'), TIMESTAMP('2019-03-13'), NULL),
('item_id_14', 'Dress', 'Womens Dress', 'active', 40.00, 'category_id_7', 'customer_id_7', NULL, STRUCT('more_14'), TIMESTAMP('2019-03-14'), TIMESTAMP('2019-03-14'), NULL),
('item_id_15', 'iPhone 11', 'Apple iPhone 11', 'inactive', 499.00, 'category_id_3', 'customer_id_10', NULL, STRUCT('more_15'), TIMESTAMP('2019-03-15'), TIMESTAMP('2019-03-15'), NULL),
('item_id_16', 'Samsung Galaxy S21', 'Samsung Galaxy S21', 'active', 699.00, 'category_id_3', 'customer_id_12', NULL, STRUCT('more_16'), TIMESTAMP('2019-03-16'), TIMESTAMP('2019-03-16'), NULL),
('item_id_17', 'iPhone X', 'Apple iPhone X', 'inactive', 399.00, 'category_id_3', 'customer_id_2', NULL, STRUCT('more_17'), TIMESTAMP('2019-03-17'), TIMESTAMP('2019-03-17'), NULL),
('item_id_18', 'Case for iPhone 14', 'Clear Case', 'active', 24.99, 'category_id_2', 'customer_id_2', NULL, STRUCT('more_18'), TIMESTAMP('2019-03-18'), TIMESTAMP('2019-03-18'), NULL),
('item_id_19', 'Charger', 'Fast Charger', 'active', 19.99, 'category_id_4', 'customer_id_12', NULL, STRUCT('more_19'), TIMESTAMP('2019-03-19'), TIMESTAMP('2019-03-19'), NULL),
('item_id_20', 'T-Shirt', 'Mens T-Shirt', 'active', 15.00, 'category_id_6', 'customer_id_6', NULL, STRUCT('more_20'), TIMESTAMP('2019-03-20'), TIMESTAMP('2019-03-20'), NULL),
('item_id_21', 'Dress', 'Womens Dress', 'active', 30.00, 'category_id_7', 'customer_id_7', NULL, STRUCT('more_21'), TIMESTAMP('2019-03-21'), TIMESTAMP('2019-03-21'), NULL),
('item_id_22', 'Galaxy Buds', 'Wireless Earbuds', 'active', 149.00, 'category_id_4', 'customer_id_3', NULL, STRUCT('more_22'), TIMESTAMP('2019-03-22'), TIMESTAMP('2019-03-22'), NULL),
('item_id_23', 'AirPods Pro', 'Wireless Earbuds', 'active', 249.00, 'category_id_4', 'customer_id_2', NULL, STRUCT('more_23'), TIMESTAMP('2019-03-23'), TIMESTAMP('2019-03-23'), NULL),
('item_id_24', 'Jeans', 'Mens Jeans', 'active', 70.00, 'category_id_6', 'customer_id_6', NULL, STRUCT('more_24'), TIMESTAMP('2019-03-24'), TIMESTAMP('2019-03-24'), NULL),
('item_id_25', 'Skirt', 'Womens Skirt', 'active', 35.00, 'category_id_7', 'customer_id_7', NULL, STRUCT('more_25'), TIMESTAMP('2019-03-25'), TIMESTAMP('2019-03-25'), NULL),
('item_id_26', 'iPad Pro', 'Apple iPad Pro', 'active', 1099.00, 'category_id_1', 'customer_id_2', NULL, STRUCT('more_26'), TIMESTAMP('2019-03-26'), TIMESTAMP('2019-03-26'), NULL),
('item_id_27', 'Galaxy Tab S8', 'Samsung Galaxy Tab S8', 'active', 999.00, 'category_id_1', 'customer_id_3', NULL, STRUCT('more_27'), TIMESTAMP('2019-03-27'), TIMESTAMP('2019-03-27'), NULL),
('item_id_28', 'Apple Pencil', 'Apple Pencil', 'active', 129.00, 'category_id_4', 'customer_id_2', NULL, STRUCT('more_28'), TIMESTAMP('2019-03-28'), TIMESTAMP('2019-03-28'), NULL),
('item_id_29', 'S Pen', 'Samsung S Pen', 'active', 99.00, 'category_id_4', 'customer_id_3', NULL, STRUCT('more_29'), TIMESTAMP('2019-03-29'), TIMESTAMP('2019-03-29'), NULL),
('item_id_30', 'T-Shirt', 'Mens T-Shirt', 'inactive', 22.00, 'category_id_6', 'customer_id_6', NULL, STRUCT('more_30'), TIMESTAMP('2019-03-30'), TIMESTAMP('2019-03-30'), NULL);





INSERT INTO `mlcase-hassakura.case1.orders` (order_id, item_id, buyer_id, seller_id, status, item_quantity, item_price, order_value, more_columns, created_at, updated_at, cancelled_at) VALUES
('order_id_1', 'item_id_1', 'customer_id_1', 'customer_id_10', 'completed', 2, 799.00, 1598.00, STRUCT('any_columns'), TIMESTAMP('2020-01-05 10:00:00'), TIMESTAMP('2020-01-05 10:00:00'), NULL),
('order_id_2', 'item_id_2', 'customer_id_4', 'customer_id_12', 'completed', 1, 899.00, 899.00, STRUCT('any_columns'), TIMESTAMP('2020-01-12 11:00:00'), TIMESTAMP('2020-01-12 11:00:00'), NULL),
('order_id_3', 'item_id_3', 'customer_id_5', 'customer_id_2', 'completed', 3, 999.00, 2997.00, STRUCT('any_columns'), TIMESTAMP('2020-01-18 12:00:00'), TIMESTAMP('2020-01-18 12:00:00'), NULL),
('order_id_4', 'item_id_4', 'customer_id_8', 'customer_id_2', 'completed', 1, 29.99, 29.99, STRUCT('any_columns'), TIMESTAMP('2020-01-22 13:00:00'), TIMESTAMP('2020-01-22 13:00:00'), NULL),
('order_id_5', 'item_id_5', 'customer_id_11', 'customer_id_3', 'cancelled', 2, 19.99, 39.98, STRUCT('any_columns'), TIMESTAMP('2020-01-28 14:00:00'), TIMESTAMP('2020-01-28 14:00:00'), TIMESTAMP('2020-01-28 14:00:00')),
('order_id_6', 'item_id_6', 'customer_id_13', 'customer_id_6', 'completed', 1, 25.00, 25.00, STRUCT('any_columns'), TIMESTAMP('2020-01-03 15:00:00'), TIMESTAMP('2020-01-03 15:00:00'), NULL),
('order_id_7', 'item_id_7', 'customer_id_15', 'customer_id_7', 'completed', 4, 50.00, 200.00, STRUCT('any_columns'), TIMESTAMP('2020-01-08 16:00:00'), TIMESTAMP('2020-01-08 16:00:00'), NULL),
('order_id_8', 'item_id_8', 'customer_id_1', 'customer_id_2', 'completed', 1, 699.00, 699.00, STRUCT('any_columns'), TIMESTAMP('2020-01-15 17:00:00'), TIMESTAMP('2020-01-15 17:00:00'), NULL),
('order_id_9', 'item_id_9', 'customer_id_4', 'customer_id_3', 'completed', 2, 799.00, 1598.00, STRUCT('any_columns'), TIMESTAMP('2020-02-07 10:00:00'), TIMESTAMP('2020-02-07 10:00:00'), NULL),
('order_id_10', 'item_id_10', 'customer_id_5', 'customer_id_10', 'completed', 1, 599.00, 599.00, STRUCT('any_columns'), TIMESTAMP('2020-02-14 11:00:00'), TIMESTAMP('2020-02-14 11:00:00'), NULL),
('order_id_11', 'item_id_11', 'customer_id_8', 'customer_id_10', 'completed', 3, 24.99, 74.97, STRUCT('any_columns'), TIMESTAMP('2020-02-21 12:00:00'), TIMESTAMP('2020-02-21 12:00:00'), NULL),
('order_id_12', 'item_id_12', 'customer_id_11', 'customer_id_12', 'completed', 1, 19.99, 19.99, STRUCT('any_columns'), TIMESTAMP('2020-02-25 13:00:00'), TIMESTAMP('2020-02-25 13:00:00'), NULL),
('order_id_13', 'item_id_13', 'customer_id_13', 'customer_id_6', 'cancelled', 2, 20.00, 40.00, STRUCT('any_columns'), TIMESTAMP('2020-02-02 14:00:00'), TIMESTAMP('2020-02-02 14:00:00'), TIMESTAMP('2020-02-02 14:00:00')),
('order_id_14', 'item_id_14', 'customer_id_15', 'customer_id_7', 'completed', 1, 40.00, 40.00, STRUCT('any_columns'), TIMESTAMP('2020-02-09 15:00:00'), TIMESTAMP('2020-02-09 15:00:00'), NULL),
('order_id_15', 'item_id_15', 'customer_id_1', 'customer_id_10', 'completed', 4, 499.00, 1996.00, STRUCT('any_columns'), TIMESTAMP('2020-02-16 16:00:00'), TIMESTAMP('2020-02-16 16:00:00'), NULL),
('order_id_16', 'item_id_16', 'customer_id_4', 'customer_id_12', 'completed', 1, 699.00, 699.00, STRUCT('any_columns'), TIMESTAMP('2020-02-23 17:00:00'), TIMESTAMP('2020-02-23 17:00:00'), NULL),
('order_id_17', 'item_id_17', 'customer_id_5', 'customer_id_2', 'completed', 2, 399.00, 798.00, STRUCT('any_columns'), TIMESTAMP('2020-03-09 10:00:00'), TIMESTAMP('2020-03-09 10:00:00'), NULL),
('order_id_18', 'item_id_18', 'customer_id_8', 'customer_id_2', 'completed', 1, 24.99, 24.99, STRUCT('any_columns'), TIMESTAMP('2020-03-16 11:00:00'), TIMESTAMP('2020-03-16 11:00:00'), NULL),
('order_id_19', 'item_id_19', 'customer_id_11', 'customer_id_12', 'completed', 3, 19.99, 59.97, STRUCT('any_columns'), TIMESTAMP('2020-03-23 12:00:00'), TIMESTAMP('2020-03-23 12:00:00'), NULL),
('order_id_20', 'item_id_20', 'customer_id_13', 'customer_id_6', 'completed', 1, 15.00, 15.00, STRUCT('any_columns'), TIMESTAMP('2020-03-27 13:00:00'), TIMESTAMP('2020-03-27 13:00:00'), NULL),
('order_id_21', 'item_id_21', 'customer_id_15', 'customer_id_7', 'cancelled', 2, 30.00, 60.00, STRUCT('any_columns'), TIMESTAMP('2020-03-04 14:00:00'), TIMESTAMP('2020-03-04 14:00:00'), TIMESTAMP('2020-03-04 14:00:00')),
('order_id_22', 'item_id_22', 'customer_id_1', 'customer_id_3', 'completed', 1, 149.00, 149.00, STRUCT('any_columns'), TIMESTAMP('2020-03-11 15:00:00'), TIMESTAMP('2020-03-11 15:00:00'), NULL),
('order_id_23', 'item_id_23', 'customer_id_4', 'customer_id_2', 'completed', 4, 249.00, 996.00, STRUCT('any_columns'), TIMESTAMP('2020-03-18 16:00:00'), TIMESTAMP('2020-03-18 16:00:00'), NULL),
('order_id_24', 'item_id_24', 'customer_id_5', 'customer_id_6', 'completed', 1, 70.00, 70.00, STRUCT('any_columns'), TIMESTAMP('2020-03-25 17:00:00'), TIMESTAMP('2020-03-25 17:00:00'), NULL),
('order_id_25', 'item_id_25', 'customer_id_8', 'customer_id_7', 'completed', 2, 35.00, 70.00, STRUCT('any_columns'), TIMESTAMP('2020-04-06 10:00:00'), TIMESTAMP('2020-04-06 10:00:00'), NULL),
('order_id_26', 'item_id_26', 'customer_id_11', 'customer_id_2', 'completed', 1, 1099.00, 1099.00, STRUCT('any_columns'), TIMESTAMP('2020-04-13 11:00:00'), TIMESTAMP('2020-04-13 11:00:00'), NULL),
('order_id_27', 'item_id_27', 'customer_id_13', 'customer_id_3', 'completed', 3, 999.00, 2997.00, STRUCT('any_columns'), TIMESTAMP('2020-04-20 12:00:00'), TIMESTAMP('2020-04-20 12:00:00'), NULL),
('order_id_28', 'item_id_28', 'customer_id_15', 'customer_id_2', 'completed', 1, 129.00, 129.00, STRUCT('any_columns'), TIMESTAMP('2020-04-24 13:00:00'), TIMESTAMP('2020-04-24 13:00:00'), NULL),
('order_id_29', 'item_id_29', 'customer_id_1', 'customer_id_3', 'cancelled', 2, 99.00, 198.00, STRUCT('any_columns'), TIMESTAMP('2020-04-01 14:00:00'), TIMESTAMP('2020-04-01 14:00:00'), TIMESTAMP('2020-04-01 14:00:00')),
('order_id_30', 'item_id_30', 'customer_id_4', 'customer_id_6', 'completed', 1, 22.00, 22.00, STRUCT('any_columns'), TIMESTAMP('2020-04-08 15:00:00'), TIMESTAMP('2020-04-08 15:00:00'), NULL),
('order_id_31', 'item_id_1', 'customer_id_5', 'customer_id_10', 'completed', 4, 799.00, 3196.00, STRUCT('any_columns'), TIMESTAMP('2020-04-15 16:00:00'), TIMESTAMP('2020-04-15 16:00:00'), NULL),
('order_id_32', 'item_id_2', 'customer_id_8', 'customer_id_12', 'completed', 1, 899.00, 899.00, STRUCT('any_columns'), TIMESTAMP('2020-04-22 17:00:00'), TIMESTAMP('2020-04-22 17:00:00'), NULL),
('order_id_33', 'item_id_3', 'customer_id_11', 'customer_id_2', 'completed', 2, 999.00, 1998.00, STRUCT('any_columns'), TIMESTAMP('2020-05-04 10:00:00'), TIMESTAMP('2020-05-04 10:00:00'), NULL),
('order_id_34', 'item_id_4', 'customer_id_13', 'customer_id_2', 'completed', 1, 29.99, 29.99, STRUCT('any_columns'), TIMESTAMP('2020-05-11 11:00:00'), TIMESTAMP('2020-05-11 11:00:00'), NULL),
('order_id_35', 'item_id_5', 'customer_id_15', 'customer_id_3', 'completed', 3, 19.99, 59.97, STRUCT('any_columns'), TIMESTAMP('2020-05-18 12:00:00'), TIMESTAMP('2020-05-18 12:00:00'), NULL),
('order_id_36', 'item_id_6', 'customer_id_1', 'customer_id_6', 'completed', 1, 25.00, 25.00, STRUCT('any_columns'), TIMESTAMP('2020-05-25 13:00:00'), TIMESTAMP('2020-05-25 13:00:00'), NULL),
('order_id_37', 'item_id_7', 'customer_id_4', 'customer_id_7', 'cancelled', 2, 50.00, 100.00, STRUCT('any_columns'), TIMESTAMP('2020-05-02 14:00:00'), TIMESTAMP('2020-05-02 14:00:00'), TIMESTAMP('2020-05-02 14:00:00')),
('order_id_38', 'item_id_8', 'customer_id_5', 'customer_id_2', 'completed', 1, 699.00, 699.00, STRUCT('any_columns'), TIMESTAMP('2020-05-09 15:00:00'), TIMESTAMP('2020-05-09 15:00:00'), NULL),
('order_id_39', 'item_id_9', 'customer_id_8', 'customer_id_3', 'completed', 4, 799.00, 3196.00, STRUCT('any_columns'), TIMESTAMP('2020-05-16 16:00:00'), TIMESTAMP('2020-05-16 16:00:00'), NULL),
('order_id_40', 'item_id_10', 'customer_id_11', 'customer_id_10', 'completed', 1, 599.00, 599.00, STRUCT('any_columns'), TIMESTAMP('2020-05-23 17:00:00'), TIMESTAMP('2020-05-23 17:00:00'), NULL),
('order_id_41', 'item_id_11', 'customer_id_13', 'customer_id_10', 'completed', 2, 24.99, 49.98, STRUCT('any_columns'), TIMESTAMP('2020-06-01 10:00:00'), TIMESTAMP('2020-06-01 10:00:00'), NULL),
('order_id_42', 'item_id_12', 'customer_id_15', 'customer_id_12', 'completed', 1, 19.99, 19.99, STRUCT('any_columns'), TIMESTAMP('2020-06-08 11:00:00'), TIMESTAMP('2020-06-08 11:00:00'), NULL),
('order_id_43', 'item_id_13', 'customer_id_1', 'customer_id_6', 'completed', 3, 20.00, 60.00, STRUCT('any_columns'), TIMESTAMP('2020-06-15 12:00:00'), TIMESTAMP('2020-06-15 12:00:00'), NULL),
('order_id_44', 'item_id_14', 'customer_id_4', 'customer_id_7', 'completed', 1, 40.00, 40.00, STRUCT('any_columns'), TIMESTAMP('2020-06-22 13:00:00'), TIMESTAMP('2020-06-22 13:00:00'), NULL),
('order_id_45', 'item_id_15', 'customer_id_5', 'customer_id_10', 'cancelled', 2, 499.00, 998.00, STRUCT('any_columns'), TIMESTAMP('2020-06-29 14:00:00'), TIMESTAMP('2020-06-29 14:00:00'), TIMESTAMP('2020-06-29 14:00:00')),
('order_id_46', 'item_id_16', 'customer_id_8', 'customer_id_12', 'completed', 1, 699.00, 699.00, STRUCT('any_columns'), TIMESTAMP('2020-06-05 15:00:00'), TIMESTAMP('2020-06-05 15:00:00'), NULL),
('order_id_47', 'item_id_17', 'customer_id_11', 'customer_id_2', 'completed', 4, 399.00, 1596.00, STRUCT('any_columns'), TIMESTAMP('2020-06-12 16:00:00'), TIMESTAMP('2020-06-12 16:00:00'), NULL),
('order_id_48', 'item_id_18', 'customer_id_13', 'customer_id_2', 'completed', 1, 24.99, 24.99, STRUCT('any_columns'), TIMESTAMP('2020-06-19 17:00:00'), TIMESTAMP('2020-06-19 17:00:00'), NULL),
('order_id_49', 'item_id_19', 'customer_id_15', 'customer_id_12', 'completed', 2, 19.99, 39.98, STRUCT('any_columns'), TIMESTAMP('2020-07-02 10:00:00'), TIMESTAMP('2020-07-02 10:00:00'), NULL),
('order_id_50', 'item_id_20', 'customer_id_1', 'customer_id_6', 'completed', 1, 15.00, 15.00, STRUCT('any_columns'), TIMESTAMP('2020-07-09 11:00:00'), TIMESTAMP('2020-07-09 11:00:00'), NULL),
('order_id_51', 'item_id_21', 'customer_id_4', 'customer_id_7', 'completed', 3, 30.00, 90.00, STRUCT('any_columns'), TIMESTAMP('2020-07-16 12:00:00'), TIMESTAMP('2020-07-16 12:00:00'), NULL),
('order_id_52', 'item_id_22', 'customer_id_5', 'customer_id_3', 'completed', 1, 149.00, 149.00, STRUCT('any_columns'), TIMESTAMP('2020-07-23 13:00:00'), TIMESTAMP('2020-07-23 13:00:00'), NULL),
('order_id_53', 'item_id_23', 'customer_id_8', 'customer_id_2', 'cancelled', 2, 249.00, 498.00, STRUCT('any_columns'), TIMESTAMP('2020-07-30 14:00:00'), TIMESTAMP('2020-07-30 14:00:00'), TIMESTAMP('2020-07-30 14:00:00')),
('order_id_54', 'item_id_24', 'customer_id_11', 'customer_id_6', 'completed', 1, 70.00, 70.00, STRUCT('any_columns'), TIMESTAMP('2020-07-07 15:00:00'), TIMESTAMP('2020-07-07 15:00:00'), NULL),
('order_id_55', 'item_id_25', 'customer_id_13', 'customer_id_7', 'completed', 4, 35.00, 140.00, STRUCT('any_columns'), TIMESTAMP('2020-07-14 16:00:00'), TIMESTAMP('2020-07-14 16:00:00'), NULL),
('order_id_56', 'item_id_26', 'customer_id_15', 'customer_id_2', 'completed', 1, 1099.00, 1099.00, STRUCT('any_columns'), TIMESTAMP('2020-07-21 17:00:00'), TIMESTAMP('2020-07-21 17:00:00'), NULL),
('order_id_57', 'item_id_27', 'customer_id_1', 'customer_id_3', 'completed', 2, 999.00, 1998.00, STRUCT('any_columns'), TIMESTAMP('2020-08-03 10:00:00'), TIMESTAMP('2020-08-03 10:00:00'), NULL),
('order_id_58', 'item_id_28', 'customer_id_4', 'customer_id_2', 'completed', 1, 129.00, 129.00, STRUCT('any_columns'), TIMESTAMP('2020-08-10 11:00:00'), TIMESTAMP('2020-08-10 11:00:00'), NULL),
('order_id_59', 'item_id_29', 'customer_id_5', 'customer_id_3', 'completed', 3, 99.00, 297.00, STRUCT('any_columns'), TIMESTAMP('2020-08-17 12:00:00'), TIMESTAMP('2020-08-17 12:00:00'), NULL),
('order_id_60', 'item_id_30', 'customer_id_8', 'customer_id_6', 'completed', 1, 22.00, 22.00, STRUCT('any_columns'), TIMESTAMP('2020-08-24 13:00:00'), TIMESTAMP('2020-08-24 13:00:00'), NULL),
('order_id_61', 'item_id_1', 'customer_id_11', 'customer_id_10', 'cancelled', 2, 799.00, 1598.00, STRUCT('any_columns'), TIMESTAMP('2020-08-31 14:00:00'), TIMESTAMP('2020-08-31 14:00:00'), TIMESTAMP('2020-08-31 14:00:00')),
('order_id_62', 'item_id_2', 'customer_id_13', 'customer_id_12', 'completed', 1, 899.00, 899.00, STRUCT('any_columns'), TIMESTAMP('2020-08-07 15:00:00'), TIMESTAMP('2020-08-07 15:00:00'), NULL),
('order_id_63', 'item_id_3', 'customer_id_15', 'customer_id_2', 'completed', 4, 999.00, 3996.00, STRUCT('any_columns'), TIMESTAMP('2020-08-14 16:00:00'), TIMESTAMP('2020-08-14 16:00:00'), NULL),
('order_id_64', 'item_id_4', 'customer_id_1', 'customer_id_2', 'completed', 1, 29.99, 29.99, STRUCT('any_columns'), TIMESTAMP('2020-08-21 17:00:00'), TIMESTAMP('2020-08-21 17:00:00'), NULL),
('order_id_65', 'item_id_5', 'customer_id_4', 'customer_id_3', 'completed', 2, 19.99, 39.98, STRUCT('any_columns'), TIMESTAMP('2020-09-02 10:00:00'), TIMESTAMP('2020-09-02 10:00:00'), NULL),
('order_id_66', 'item_id_6', 'customer_id_5', 'customer_id_6', 'completed', 1, 25.00, 25.00, STRUCT('any_columns'), TIMESTAMP('2020-09-09 11:00:00'), TIMESTAMP('2020-09-09 11:00:00'), NULL),
('order_id_67', 'item_id_7', 'customer_id_8', 'customer_id_7', 'completed', 3, 50.00, 150.00, STRUCT('any_columns'), TIMESTAMP('2020-09-16 12:00:00'), TIMESTAMP('2020-09-16 12:00:00'), NULL),
('order_id_68', 'item_id_8', 'customer_id_11', 'customer_id_2', 'completed', 1, 699.00, 699.00, STRUCT('any_columns'), TIMESTAMP('2020-09-23 13:00:00'), TIMESTAMP('2020-09-23 13:00:00'), NULL),
('order_id_69', 'item_id_9', 'customer_id_13', 'customer_id_3', 'cancelled', 2, 799.00, 1598.00, STRUCT('any_columns'), TIMESTAMP('2020-09-30 14:00:00'), TIMESTAMP('2020-09-30 14:00:00'), TIMESTAMP('2020-09-30 14:00:00')),
('order_id_70', 'item_id_10', 'customer_id_15', 'customer_id_10', 'completed', 1, 599.00, 599.00, STRUCT('any_columns'), TIMESTAMP('2020-09-07 15:00:00'), TIMESTAMP('2020-09-07 15:00:00'), NULL),
('order_id_71', 'item_id_11', 'customer_id_1', 'customer_id_10', 'completed', 4, 24.99, 99.96, STRUCT('any_columns'), TIMESTAMP('2020-09-14 16:00:00'), TIMESTAMP('2020-09-14 16:00:00'), NULL),
('order_id_72', 'item_id_12', 'customer_id_4', 'customer_id_12', 'completed', 1, 19.99, 19.99, STRUCT('any_columns'), TIMESTAMP('2020-09-21 17:00:00'), TIMESTAMP('2020-09-21 17:00:00'), NULL),
('order_id_73', 'item_id_13', 'customer_id_5', 'customer_id_6', 'completed', 2, 20.00, 40.00, STRUCT('any_columns'), TIMESTAMP('2020-10-05 10:00:00'), TIMESTAMP('2020-10-05 10:00:00'), NULL),
('order_id_74', 'item_id_14', 'customer_id_8', 'customer_id_7', 'completed', 1, 40.00, 40.00, STRUCT('any_columns'), TIMESTAMP('2020-10-12 11:00:00'), TIMESTAMP('2020-10-12 11:00:00'), NULL),
('order_id_75', 'item_id_15', 'customer_id_11', 'customer_id_10', 'completed', 3, 499.00, 1497.00, STRUCT('any_columns'), TIMESTAMP('2020-10-19 12:00:00'), TIMESTAMP('2020-10-19 12:00:00'), NULL),
('order_id_76', 'item_id_16', 'customer_id_13', 'customer_id_12', 'completed', 1, 699.00, 699.00, STRUCT('any_columns'), TIMESTAMP('2020-10-26 13:00:00'), TIMESTAMP('2020-10-26 13:00:00'), NULL),
('order_id_77', 'item_id_17', 'customer_id_15', 'customer_id_2', 'cancelled', 2, 399.00, 798.00, STRUCT('any_columns'), TIMESTAMP('2020-10-02 14:00:00'), TIMESTAMP('2020-10-02 14:00:00'), TIMESTAMP('2020-10-02 14:00:00')),
('order_id_78', 'item_id_18', 'customer_id_1', 'customer_id_2', 'completed', 1, 24.99, 24.99, STRUCT('any_columns'), TIMESTAMP('2020-10-09 15:00:00'), TIMESTAMP('2020-10-09 15:00:00'), NULL),
('order_id_79', 'item_id_19', 'customer_id_4', 'customer_id_12', 'completed', 4, 19.99, 79.96, STRUCT('any_columns'), TIMESTAMP('2020-10-16 16:00:00'), TIMESTAMP('2020-10-16 16:00:00'), NULL),
('order_id_80', 'item_id_20', 'customer_id_5', 'customer_id_6', 'completed', 1, 15.00, 15.00, STRUCT('any_columns'), TIMESTAMP('2020-10-23 17:00:00'), TIMESTAMP('2020-10-23 17:00:00'), NULL),
('order_id_81', 'item_id_21', 'customer_id_8', 'customer_id_7', 'completed', 2, 30.00, 60.00, STRUCT('any_columns'), TIMESTAMP('2020-11-03 10:00:00'), TIMESTAMP('2020-11-03 10:00:00'), NULL),
('order_id_82', 'item_id_22', 'customer_id_11', 'customer_id_3', 'completed', 1, 149.00, 149.00, STRUCT('any_columns'), TIMESTAMP('2020-11-10 11:00:00'), TIMESTAMP('2020-11-10 11:00:00'), NULL),
('order_id_83', 'item_id_23', 'customer_id_13', 'customer_id_2', 'completed', 3, 249.00, 747.00, STRUCT('any_columns'), TIMESTAMP('2020-11-17 12:00:00'), TIMESTAMP('2020-11-17 12:00:00'), NULL),
('order_id_84', 'item_id_24', 'customer_id_15', 'customer_id_6', 'completed', 1, 70.00, 70.00, STRUCT('any_columns'), TIMESTAMP('2020-11-24 13:00:00'), TIMESTAMP('2020-11-24 13:00:00'), NULL),
('order_id_85', 'item_id_25', 'customer_id_1', 'customer_id_7', 'cancelled', 2, 35.00, 70.00, STRUCT('any_columns'), TIMESTAMP('2020-11-02 14:00:00'), TIMESTAMP('2020-11-02 14:00:00'), TIMESTAMP('2020-11-02 14:00:00')),
('order_id_86', 'item_id_26', 'customer_id_4', 'customer_id_2', 'completed', 1, 1099.00, 1099.00, STRUCT('any_columns'), TIMESTAMP('2020-11-09 15:00:00'), TIMESTAMP('2020-11-09 15:00:00'), NULL),
('order_id_87', 'item_id_27', 'customer_id_5', 'customer_id_3', 'completed', 4, 999.00, 3996.00, STRUCT('any_columns'), TIMESTAMP('2020-11-16 16:00:00'), TIMESTAMP('2020-11-16 16:00:00'), NULL),
('order_id_88', 'item_id_28', 'customer_id_8', 'customer_id_2', 'completed', 1, 129.00, 129.00, STRUCT('any_columns'), TIMESTAMP('2020-11-23 17:00:00'), TIMESTAMP('2020-11-23 17:00:00'), NULL),
('order_id_89', 'item_id_29', 'customer_id_11', 'customer_id_3', 'completed', 2, 99.00, 198.00, STRUCT('any_columns'), TIMESTAMP('2020-12-01 10:00:00'), TIMESTAMP('2020-12-01 10:00:00'), NULL),
('order_id_90', 'item_id_30', 'customer_id_13', 'customer_id_6', 'completed', 1, 22.00, 22.00, STRUCT('any_columns'), TIMESTAMP('2020-12-08 11:00:00'), TIMESTAMP('2020-12-08 11:00:00'), NULL),
('order_id_91', 'item_id_1', 'customer_id_15', 'customer_id_10', 'completed', 3, 799.00, 2397.00, STRUCT('any_columns'), TIMESTAMP('2020-12-15 12:00:00'), TIMESTAMP('2020-12-15 12:00:00'), NULL),
('order_id_92', 'item_id_2', 'customer_id_1', 'customer_id_12', 'completed', 1, 899.00, 899.00, STRUCT('any_columns'), TIMESTAMP('2020-12-22 13:00:00'), TIMESTAMP('2020-12-22 13:00:00'), NULL),
('order_id_93', 'item_id_3', 'customer_id_4', 'customer_id_2', 'cancelled', 2, 999.00, 1998.00, STRUCT('any_columns'), TIMESTAMP('2020-12-29 14:00:00'), TIMESTAMP('2020-12-29 14:00:00'), TIMESTAMP('2020-12-29 14:00:00')),
('order_id_94', 'item_id_4', 'customer_id_5', 'customer_id_2', 'completed', 1, 29.99, 29.99, STRUCT('any_columns'), TIMESTAMP('2020-12-06 15:00:00'), TIMESTAMP('2020-12-06 15:00:00'), NULL),
('order_id_95', 'item_id_5', 'customer_id_8', 'customer_id_3', 'completed', 4, 19.99, 79.96, STRUCT('any_columns'), TIMESTAMP('2020-12-13 16:00:00'), TIMESTAMP('2020-12-13 16:00:00'), NULL),
('order_id_96', 'item_id_6', 'customer_id_11', 'customer_id_6', 'completed', 1, 25.00, 25.00, STRUCT('any_columns'), TIMESTAMP('2020-12-20 17:00:00'), TIMESTAMP('2020-12-20 17:00:00'), NULL);