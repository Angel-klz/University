DROP SCHEMA IF EXISTS pagila_dwh CASCADE;
CREATE SCHEMA pagila_dwh;
SET search_path TO pagila_dwh;

CREATE TABLE dim_country (
    country_key   INT GENERATED ALWAYS AS IDENTITY,
    country_id    INT          NOT NULL,
    country       VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_dim_country PRIMARY KEY (country_key),
    CONSTRAINT uq_dim_country_bk UNIQUE (country_id)
);

CREATE TABLE dim_city (
    city_key      INT GENERATED ALWAYS AS IDENTITY,
    city_id       INT          NOT NULL,
    city          VARCHAR(50)  NOT NULL,
    country_key   INT          NOT NULL,
    CONSTRAINT pk_dim_city PRIMARY KEY (city_key),
    CONSTRAINT uq_dim_city_bk UNIQUE (city_id),
    CONSTRAINT fk_city_country FOREIGN KEY (country_key) REFERENCES dim_country (country_key)
);

CREATE TABLE dim_address (
    address_key   INT GENERATED ALWAYS AS IDENTITY,
    address_id    INT          NOT NULL,
    address       VARCHAR(50)  NOT NULL,
    address2      VARCHAR(50)  NULL,
    district      VARCHAR(50)  NOT NULL,
    postal_code   VARCHAR(10)  NULL,
    phone         VARCHAR(20)  NULL,
    city_key      INT          NOT NULL,
    CONSTRAINT pk_dim_address PRIMARY KEY (address_key),
    CONSTRAINT uq_dim_address_bk UNIQUE (address_id),
    CONSTRAINT fk_address_city FOREIGN KEY (city_key) REFERENCES dim_city (city_key)
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

CREATE TABLE dim_time (
    time_key      INT          NOT NULL,
    hour_num      SMALLINT     NOT NULL,
    minute_num    SMALLINT     NOT NULL,
    day_part      VARCHAR(10)  NOT NULL,
    CONSTRAINT pk_dim_time PRIMARY KEY (time_key)
);

CREATE TABLE dim_language (
    language_key  INT GENERATED ALWAYS AS IDENTITY,
    language_id   INT          NOT NULL,
    name          VARCHAR(20)  NOT NULL,
    CONSTRAINT pk_dim_language PRIMARY KEY (language_key),
    CONSTRAINT uq_dim_language_bk UNIQUE (language_id)
);

CREATE TABLE dim_category (
    category_key  INT GENERATED ALWAYS AS IDENTITY,
    category_id   INT          NOT NULL,
    name          VARCHAR(25)  NOT NULL,
    CONSTRAINT pk_dim_category PRIMARY KEY (category_key),
    CONSTRAINT uq_dim_category_bk UNIQUE (category_id)
);

CREATE TABLE dim_actor (
    actor_key     INT GENERATED ALWAYS AS IDENTITY,
    actor_id      INT          NOT NULL,
    first_name    VARCHAR(45)  NOT NULL,
    last_name     VARCHAR(45)  NOT NULL,
    CONSTRAINT pk_dim_actor PRIMARY KEY (actor_key),
    CONSTRAINT uq_dim_actor_bk UNIQUE (actor_id)
);

CREATE TABLE dim_film (
    film_key          INT GENERATED ALWAYS AS IDENTITY,
    film_id           INT           NOT NULL,
    title             VARCHAR(255)  NOT NULL,
    description       TEXT          NULL,
    release_year      SMALLINT      NULL,
    language_key      INT           NOT NULL,
    rental_duration   SMALLINT      NOT NULL,
    rental_rate       NUMERIC(4,2)  NOT NULL,
    length            SMALLINT      NULL,
    replacement_cost  NUMERIC(5,2)  NOT NULL,
    rating            DOUBLE PRECISION NULL,
    special_features  TEXT          NULL,
    CONSTRAINT pk_dim_film PRIMARY KEY (film_key),
    CONSTRAINT uq_dim_film_bk UNIQUE (film_id),
    CONSTRAINT fk_film_language FOREIGN KEY (language_key) REFERENCES dim_language (language_key)
);

CREATE TABLE bridge_film_category (
    film_key       INT           NOT NULL,
    category_key   INT           NOT NULL,
    weight_factor  NUMERIC(5,4)  NOT NULL DEFAULT 1.0000,
    CONSTRAINT pk_bridge_film_category PRIMARY KEY (film_key, category_key),
    CONSTRAINT fk_bfc_film     FOREIGN KEY (film_key)     REFERENCES dim_film (film_key),
    CONSTRAINT fk_bfc_category FOREIGN KEY (category_key) REFERENCES dim_category (category_key)
);

CREATE TABLE bridge_film_actor (
    film_key       INT           NOT NULL,
    actor_key      INT           NOT NULL,
    weight_factor  NUMERIC(5,4)  NOT NULL DEFAULT 1.0000,
    CONSTRAINT pk_bridge_film_actor PRIMARY KEY (film_key, actor_key),
    CONSTRAINT fk_bfa_film  FOREIGN KEY (film_key)  REFERENCES dim_film (film_key),
    CONSTRAINT fk_bfa_actor FOREIGN KEY (actor_key) REFERENCES dim_actor (actor_key)
);

CREATE TABLE dim_store (
    store_key            INT GENERATED ALWAYS AS IDENTITY,
    store_id             INT          NOT NULL,
    address_key          INT          NOT NULL,
    manager_staff_id     INT          NULL,
    manager_first_name   VARCHAR(50)  NULL,
    manager_last_name    VARCHAR(50)  NULL,
    CONSTRAINT pk_dim_store PRIMARY KEY (store_key),
    CONSTRAINT uq_dim_store_bk UNIQUE (store_id),
    CONSTRAINT fk_store_address FOREIGN KEY (address_key) REFERENCES dim_address (address_key)
);

CREATE TABLE dim_staff (
    staff_key     INT GENERATED ALWAYS AS IDENTITY,
    staff_id      INT          NOT NULL,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(50)  NULL,
    username      VARCHAR(16)  NOT NULL,
    active        SMALLINT     NOT NULL,
    address_key   INT          NOT NULL,
    store_key     INT          NOT NULL,
    CONSTRAINT pk_dim_staff PRIMARY KEY (staff_key),
    CONSTRAINT uq_dim_staff_bk UNIQUE (staff_id),
    CONSTRAINT fk_staff_address FOREIGN KEY (address_key) REFERENCES dim_address (address_key),
    CONSTRAINT fk_staff_store   FOREIGN KEY (store_key)   REFERENCES dim_store (store_key)
);

CREATE TABLE dim_customer (
    customer_key    INT GENERATED ALWAYS AS IDENTITY,
    customer_id     INT          NOT NULL,
    first_name      VARCHAR(45)  NOT NULL,
    last_name       VARCHAR(45)  NOT NULL,
    email           VARCHAR(50)  NULL,
    active          SMALLINT     NOT NULL,
    created_at      DATE         NULL,
    home_store_key  INT          NOT NULL,
    address_key     INT          NOT NULL,
    CONSTRAINT pk_dim_customer PRIMARY KEY (customer_key),
    CONSTRAINT uq_dim_customer_bk UNIQUE (customer_id),
    CONSTRAINT fk_customer_store   FOREIGN KEY (home_store_key) REFERENCES dim_store (store_key),
    CONSTRAINT fk_customer_address FOREIGN KEY (address_key)    REFERENCES dim_address (address_key)
);

CREATE TABLE fact_rental (
    rental_key            BIGINT GENERATED ALWAYS AS IDENTITY,
    rental_id             INT           NOT NULL,
    inventory_id          INT           NOT NULL,
    rental_date_key       INT           NOT NULL,
    rental_time_key       INT           NOT NULL,
    return_date_key       INT           NULL,
    return_time_key       INT           NULL,
    customer_key          INT           NOT NULL,
    film_key              INT           NOT NULL,
    staff_key             INT           NOT NULL,
    store_key             INT           NOT NULL,
    rental_count          SMALLINT      NOT NULL DEFAULT 1,
    rental_amount         NUMERIC(6,2)  NOT NULL,
    replacement_cost      NUMERIC(5,2)  NOT NULL,
    rental_duration_days  NUMERIC(8,2)  NULL,
    days_overdue          NUMERIC(8,2)  NULL,
    is_returned           BOOLEAN       NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_fact_rental PRIMARY KEY (rental_key),
    CONSTRAINT uq_fact_rental_id UNIQUE (rental_id),
    CONSTRAINT fk_fr_rental_date FOREIGN KEY (rental_date_key) REFERENCES dim_date (date_key),
    CONSTRAINT fk_fr_rental_time FOREIGN KEY (rental_time_key) REFERENCES dim_time (time_key),
    CONSTRAINT fk_fr_return_date FOREIGN KEY (return_date_key) REFERENCES dim_date (date_key),
    CONSTRAINT fk_fr_return_time FOREIGN KEY (return_time_key) REFERENCES dim_time (time_key),
    CONSTRAINT fk_fr_customer    FOREIGN KEY (customer_key)    REFERENCES dim_customer (customer_key),
    CONSTRAINT fk_fr_film        FOREIGN KEY (film_key)        REFERENCES dim_film (film_key),
    CONSTRAINT fk_fr_staff       FOREIGN KEY (staff_key)       REFERENCES dim_staff (staff_key),
    CONSTRAINT fk_fr_store       FOREIGN KEY (store_key)       REFERENCES dim_store (store_key)
);

CREATE INDEX ix_fr_rental_date ON fact_rental (rental_date_key);
CREATE INDEX ix_fr_customer    ON fact_rental (customer_key);
CREATE INDEX ix_fr_film        ON fact_rental (film_key);
CREATE INDEX ix_fr_staff       ON fact_rental (staff_key);
CREATE INDEX ix_fr_store       ON fact_rental (store_key);
