\c olist_dwh

CREATE TABLE dim_product (
    product_id VARCHAR PRIMARY KEY,
    category_name VARCHAR,
    weight_g INT,
    length_cm INT,
    height_cm INT,
    width_cm INT
);

--Changes add valid_from, valid_to, is_current
CREATE TABLE dim_customer (
  customer_id VARCHAR PRIMARY KEY,
  customer_unique_id VARCHAR,
  zip_code_prefix VARCHAR,
  city VARCHAR,
  state VARCHAR,
  valid_from TIMESTAMP,
  valid_to TIMESTAMP,
  is_current BOOLEAN
);

--Changes add valid_from, valid_to, is_current
CREATE TABLE dwh.dim_seller (
  seller_id VARCHAR PRIMARY KEY,
  zip_code_prefix VARCHAR,
  city VARCHAR,
  state VARCHAR,
  valid_from TIMESTAMP,
  valid_to TIMESTAMP,
  is_current BOOLEAN
);


CREATE TABLE dim_order_date (
    date_id DATE PRIMARY KEY,
    day INT,
    month INT,
    year INT
);

CREATE TABLE dim_payment_type (
    payment_type VARCHAR PRIMARY KEY
);

CREATE TABLE dim_review_score (
    review_score INT PRIMARY KEY,
    sentiment VARCHAR
);

-- ========================
-- FACT TABLES
-- ========================

-- 1. Transaction Fact Table: Sales
CREATE TABLE fact_sales (
    order_id VARCHAR,
    order_item_id INT,
    customer_id VARCHAR,
    seller_id VARCHAR,
    product_id VARCHAR,
    order_date DATE,
    payment_type VARCHAR,
    price NUMERIC,
    freight_value NUMERIC,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (seller_id) REFERENCES dim_seller(seller_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (order_date) REFERENCES dim_order_date(date_id),
    FOREIGN KEY (payment_type) REFERENCES dim_payment_type(payment_type)
);

-- 2. Periodic Snapshot Fact Table: Reviews
CREATE TABLE fact_reviews (
    review_id VARCHAR PRIMARY KEY,
    order_id VARCHAR,
    customer_id VARCHAR,
    product_id VARCHAR,
    review_date DATE,
    review_score INT,
    has_comment BOOLEAN,
    comment_length INT,
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (review_date) REFERENCES dim_order_date(date_id),
    FOREIGN KEY (review_score) REFERENCES dim_review_score(review_score)
);

-- 3. Accumulating Snapshot Fact Table: Delivery
CREATE TABLE fact_delivery (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR,
    seller_id VARCHAR,
    purchase_date DATE,
    delivered_date DATE,
    estimated_delivery_date DATE,
    delivery_days_actual INT,
    delivery_days_estimated INT,
    delay_days INT,
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (seller_id) REFERENCES dim_seller(seller_id),
    FOREIGN KEY (purchase_date) REFERENCES dim_order_date(date_id),
    FOREIGN KEY (delivered_date) REFERENCES dim_order_date(date_id),
    FOREIGN KEY (estimated_delivery_date) REFERENCES dim_order_date(date_id)
);
