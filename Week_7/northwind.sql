DROP SCHEMA IF EXISTS northwind_dwh CASCADE;
CREATE SCHEMA northwind_dwh;
SET search_path TO northwind_dwh;

CREATE TABLE dim_country (
    country_key   INT GENERATED ALWAYS AS IDENTITY,
    country_name  VARCHAR(15)  NOT NULL,
    CONSTRAINT pk_dim_country PRIMARY KEY (country_key),
    CONSTRAINT uq_dim_country_name UNIQUE (country_name)
);

CREATE TABLE dim_city (
    city_key      INT GENERATED ALWAYS AS IDENTITY,
    city_name     VARCHAR(20)  NOT NULL,
    country_key   INT          NOT NULL,
    CONSTRAINT pk_dim_city PRIMARY KEY (city_key),
    CONSTRAINT uq_dim_city UNIQUE (city_name, country_key),
    CONSTRAINT fk_city_country FOREIGN KEY (country_key) REFERENCES dim_country (country_key)
);

CREATE TABLE dim_category (
    category_key   INT GENERATED ALWAYS AS IDENTITY,
    category_id    INT           NOT NULL,
    category_name  VARCHAR(25)   NOT NULL,
    description    VARCHAR(255)  NULL,
    CONSTRAINT pk_dim_category PRIMARY KEY (category_key),
    CONSTRAINT uq_dim_category_bk UNIQUE (category_id)
);

CREATE TABLE dim_supplier (
    supplier_key   INT GENERATED ALWAYS AS IDENTITY,
    supplier_id    INT          NOT NULL,
    supplier_name  VARCHAR(50)  NOT NULL,
    contact_name   VARCHAR(50)  NULL,
    address        VARCHAR(50)  NULL,
    postal_code    VARCHAR(10)  NULL,
    phone          VARCHAR(15)  NULL,
    city_key       INT          NOT NULL,
    CONSTRAINT pk_dim_supplier PRIMARY KEY (supplier_key),
    CONSTRAINT uq_dim_supplier_bk UNIQUE (supplier_id),
    CONSTRAINT fk_supplier_city FOREIGN KEY (city_key) REFERENCES dim_city (city_key)
);

CREATE TABLE dim_product (
    product_key    INT GENERATED ALWAYS AS IDENTITY,
    product_id     INT           NOT NULL,
    product_name   VARCHAR(50)   NOT NULL,
    unit           VARCHAR(25)   NULL,
    price          NUMERIC(10,2) NOT NULL,
    category_key   INT           NOT NULL,
    supplier_key   INT           NOT NULL,
    CONSTRAINT pk_dim_product PRIMARY KEY (product_key),
    CONSTRAINT uq_dim_product_bk UNIQUE (product_id),
    CONSTRAINT fk_product_category FOREIGN KEY (category_key) REFERENCES dim_category (category_key),
    CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_key) REFERENCES dim_supplier (supplier_key)
);

CREATE TABLE dim_customer (
    customer_key   INT GENERATED ALWAYS AS IDENTITY,
    customer_id    INT          NOT NULL,
    customer_name  VARCHAR(50)  NOT NULL,
    contact_name   VARCHAR(50)  NULL,
    address        VARCHAR(50)  NULL,
    postal_code    VARCHAR(10)  NULL,
    city_key       INT          NOT NULL,
    CONSTRAINT pk_dim_customer PRIMARY KEY (customer_key),
    CONSTRAINT uq_dim_customer_bk UNIQUE (customer_id),
    CONSTRAINT fk_customer_city FOREIGN KEY (city_key) REFERENCES dim_city (city_key)
);

CREATE TABLE dim_employee (
    employee_key  INT GENERATED ALWAYS AS IDENTITY,
    employee_id   INT          NOT NULL,
    first_name    VARCHAR(15)  NOT NULL,
    last_name     VARCHAR(15)  NOT NULL,
    birth_date    DATE         NULL,
    CONSTRAINT pk_dim_employee PRIMARY KEY (employee_key),
    CONSTRAINT uq_dim_employee_bk UNIQUE (employee_id)
);

CREATE TABLE dim_shipper (
    shipper_key   INT GENERATED ALWAYS AS IDENTITY,
    shipper_id    INT          NOT NULL,
    shipper_name  VARCHAR(25)  NOT NULL,
    phone         VARCHAR(15)  NULL,
    CONSTRAINT pk_dim_shipper PRIMARY KEY (shipper_key),
    CONSTRAINT uq_dim_shipper_bk UNIQUE (shipper_id)
);

CREATE TABLE dim_date (
    date_key      INT          NOT NULL,
    full_date     DATE         NOT NULL,
    day_of_month  SMALLINT     NOT NULL,
    day_of_week   SMALLINT     NOT NULL,
    day_name      VARCHAR(10)  NOT NULL,
    week_of_year  SMALLINT     NOT NULL,
    month_num     SMALLINT     NOT NULL,
    month_name    VARCHAR(10)  NOT NULL,
    quarter_num   SMALLINT     NOT NULL,
    year_num      SMALLINT     NOT NULL,
    is_weekend    BOOLEAN      NOT NULL,
    CONSTRAINT pk_dim_date PRIMARY KEY (date_key),
    CONSTRAINT uq_dim_date_full UNIQUE (full_date)
);

CREATE TABLE fact_order_detail (
    order_detail_key  BIGINT GENERATED ALWAYS AS IDENTITY,
    order_detail_id   INT            NOT NULL,
    order_id          INT            NOT NULL,
    order_date_key    INT            NOT NULL,
    customer_key      INT            NOT NULL,
    product_key       INT            NOT NULL,
    employee_key      INT            NULL,
    shipper_key       INT            NULL,
    quantity          INT            NOT NULL,
    unit_price        NUMERIC(10,2)  NOT NULL,
    line_amount       NUMERIC(12,2)  NOT NULL,
    CONSTRAINT pk_fact_order_detail PRIMARY KEY (order_detail_key),
    CONSTRAINT uq_fact_order_detail_bk UNIQUE (order_detail_id),
    CONSTRAINT fk_fod_date     FOREIGN KEY (order_date_key) REFERENCES dim_date (date_key),
    CONSTRAINT fk_fod_customer FOREIGN KEY (customer_key)   REFERENCES dim_customer (customer_key),
    CONSTRAINT fk_fod_product  FOREIGN KEY (product_key)    REFERENCES dim_product (product_key),
    CONSTRAINT fk_fod_employee FOREIGN KEY (employee_key)   REFERENCES dim_employee (employee_key),
    CONSTRAINT fk_fod_shipper  FOREIGN KEY (shipper_key)    REFERENCES dim_shipper (shipper_key)
);

CREATE INDEX ix_fod_date     ON fact_order_detail (order_date_key);
CREATE INDEX ix_fod_customer ON fact_order_detail (customer_key);
CREATE INDEX ix_fod_product  ON fact_order_detail (product_key);
CREATE INDEX ix_fod_employee ON fact_order_detail (employee_key);
CREATE INDEX ix_fod_shipper  ON fact_order_detail (shipper_key);
CREATE INDEX ix_fod_order    ON fact_order_detail (order_id);
