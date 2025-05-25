\c olist_src


-- Table: products
CREATE TABLE products (
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR,
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);


COPY products FROM '/data/olist_products_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Table: product_category_name_translation
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR PRIMARY KEY,
    product_category_name_english VARCHAR
);



COPY product_category_name_translation FROM '/data/product_category_name_translation.csv'
DELIMITER ',' CSV HEADER;


-- Table: sellers
CREATE TABLE sellers (
    seller_id VARCHAR PRIMARY KEY,
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR,
    seller_state VARCHAR
);


COPY sellers FROM '/data/olist_sellers_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Table: customers
CREATE TABLE customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR,
    customer_state VARCHAR
);

COPY customers FROM '/data/olist_customers_dataset.csv'
DELIMITER ',' CSV HEADER;


-- Table: geolocation
CREATE TABLE geolocation (
    geolocation_zip_code_prefix INTEGER,
    geolocation_lat DECIMAL,
    geolocation_lng DECIMAL,
    geolocation_city VARCHAR,
    geolocation_state VARCHAR
);

COPY geolocation FROM '/data/olist_geolocation_dataset.csv'
DELIMITER ',' CSV HEADER;


-- Table: orders
CREATE TABLE orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR REFERENCES customers(customer_id),
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);



COPY orders FROM '/data/olist_orders_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Table: order_items
CREATE TABLE order_items (
    order_id VARCHAR REFERENCES orders(order_id),
    order_item_id INTEGER,
    product_id VARCHAR REFERENCES products(product_id),
    seller_id VARCHAR REFERENCES sellers(seller_id),
    shipping_limit_date TIMESTAMP,
    price DECIMAL,
    freight_value DECIMAL,
    PRIMARY KEY (order_id, order_item_id)
);


COPY order_items FROM '/data/olist_order_items_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Table: order_payments
CREATE TABLE order_payments (
    order_id VARCHAR REFERENCES orders(order_id),
    payment_sequential INTEGER,
    payment_type VARCHAR,
    payment_installments INTEGER,
    payment_value DECIMAL,
    PRIMARY KEY (order_id, payment_sequential)
);

COPY order_payments FROM '/data/olist_order_payments_dataset.csv'
DELIMITER ',' CSV HEADER;


-- Table: order_reviews
CREATE TABLE order_reviews (
    review_id VARCHAR,
    order_id VARCHAR REFERENCES orders(order_id),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    PRIMARY KEY (review_id, order_id)
);

COPY order_reviews FROM '/data/olist_order_reviews_dataset.csv'
DELIMITER ',' CSV HEADER;



--- Import data csv to table





