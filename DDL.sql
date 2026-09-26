DROP SCHEMA IF EXISTS raw CASCADE;
-- 1. buat schema
CREATE SCHEMA IF NOT EXISTS raw;
SET search_path TO raw;

-- 2.buat table
CREATE TABLE if NOT EXISTS products (
    product_id BIGINT PRIMARY KEY,
    product_name varchar(150),
    category varchar(150),
    brand varchar(150),
    price decimal(22,2),
    mrp decimal(22,2),
    margin_percentage numeric(10,1),
    shelf_life_days bigint,
    min_stock_level bigint,
    max_stock_level bigint,
    created_timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    order_id BIGINT,
    customer_id BIGINT,
    order_date TIMESTAMP,
    promised_delivery_time TIMESTAMP,
    actual_delivery_time TIMESTAMP,
    delivery_status VARCHAR(100),
    order_total decimal(22,2),
    payment_method VARCHAR(100),
    delivery_partner_id bigint,
    store_id bigint,
    created_timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id bigint GENERATED ALWAYS AS IDENTITY,
    order_id bigint,
    product_id bigint,
    quantity bigint,
    unit_price decimal(22,2),
    created_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS marketing_performance (
    campaign_id bigint,
    campaign_name varchar(150),
    date date,
    target_audience varchar(150),
    channel varchar(150),
    impressions bigint,
    clicks bigint,
    conversions bigint,
    spend decimal(22,2),
    revenue_generated decimal(22,2),
    roas decimal(22,2),
    created_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS inventory (
    inventory_id bigint GENERATED ALWAYS AS IDENTITY,
    product_id bigint,
    date text,
    stock_received bigint,
    damaged_stock bigint,
    created_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS delivery_performance (
    order_id bigint,
    delivery_partner_id bigint,
    promised_time timestamp,
    actual_time timestamp,
    delivery_time_minutes numeric(10,1),
    distance_km DECIMAL(22,2),
    delivery_status varchar(50),
    reasons_if_delayed VARCHAR(255),
    created_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id bigint,
    customer_name varchar(200),
    email varchar(200),
    phone varchar(200),
    address varchar(200),
    area varchar(200),
    pincode bigint,
    registration_date timestamp,
    customer_segment varchar(200),
    total_orders bigint,
    avg_order_value decimal(22,2),
    created_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS customer_feedback (
    feedback_id bigint,
    order_id bigint,
    customer_id bigint,
    rating smallint,
    feedback_text varchar(255),
    feedback_category varchar(150),
    sentiment varchar(150),
    feedback_date timestamp,
    created_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP,
    updated_timestamp timestamptz DEFAULT CURRENT_TIMESTAMP
);
-- 3.buat trigger function
CREATE OR REPLACE FUNCTION raw.update_updated_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_timestamp = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    tbl RECORD;
BEGIN
    FOR tbl IN
        SELECT table_name
        FROM information_schema.columns
        WHERE table_schema = 'raw'
          AND column_name = 'updated_timestamp'
    LOOP
        EXECUTE format(
            'CREATE TRIGGER trg_%I_updated_timestamp
             BEFORE UPDATE ON raw.%I
             FOR EACH ROW
             EXECUTE FUNCTION raw.update_updated_timestamp();',
            tbl.table_name,
            tbl.table_name
        );
    END LOOP;
END $$;
SET statement_timeout = 0;
\copy products (product_id, product_name, category, brand, price, mrp, margin_percentage, shelf_life_days, min_stock_level, max_stock_level) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_products.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy customers (customer_id,customer_name,email,phone,address,area,pincode,registration_date,customer_segment,total_orders,avg_order_value) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_customers.csv' WITH (FORMAT CSV, HEADER TRUE, QUOTE '"');

\copy orders (order_id,customer_id,order_date,promised_delivery_time,actual_delivery_time,delivery_status,order_total,payment_method,delivery_partner_id,store_id) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_orders.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy order_items (order_id,product_id,quantity,unit_price) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_order_items.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy marketing_performance (campaign_id,campaign_name,date,target_audience,channel,impressions,clicks,conversions,spend,revenue_generated,roas) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_marketing_performance.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy inventory (product_id,date,stock_received,damaged_stock) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_inventory.csv' WITH (FORMAT CSV, HEADER TRUE,QUOTE '"');

\copy inventory (product_id,date,stock_received,damaged_stock) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_inventoryNew.csv' WITH (FORMAT CSV, HEADER TRUE,QUOTE '"');

\copy delivery_performance (order_id,delivery_partner_id,promised_time,actual_time,delivery_time_minutes,distance_km,delivery_status,reasons_if_delayed) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_delivery_performance.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy customer_feedback (feedback_id,order_id,customer_id,rating,feedback_text,feedback_category,sentiment,feedback_date) FROM '/mnt/c/Users/user/Downloads/archive (20)/blinkit_customer_feedback.csv' WITH (FORMAT CSV, HEADER TRUE,QUOTE '"');