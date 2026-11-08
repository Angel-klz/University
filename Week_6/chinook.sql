
DROP SCHEMA IF EXISTS chinook_dwh CASCADE;
CREATE SCHEMA chinook_dwh;
SET search_path TO chinook_dwh;

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

CREATE TABLE dim_customer (
    customer_key  INT GENERATED ALWAYS AS IDENTITY,
    customer_id   INT          NOT NULL,
    first_name    VARCHAR(40)  NOT NULL,
    last_name     VARCHAR(20)  NOT NULL,
    company       VARCHAR(80)  NULL,
    address       VARCHAR(70)  NULL,
    city          VARCHAR(40)  NULL,
    state         VARCHAR(40)  NULL,
    country       VARCHAR(40)  NULL,
    postal_code   VARCHAR(10)  NULL,
    phone         VARCHAR(24)  NULL,
    fax           VARCHAR(24)  NULL,
    email         VARCHAR(60)  NOT NULL,
    CONSTRAINT pk_dim_customer PRIMARY KEY (customer_key),
    CONSTRAINT uq_dim_customer_bk UNIQUE (customer_id)
);

CREATE TABLE dim_track (
    track_key        INT GENERATED ALWAYS AS IDENTITY,
    track_id         INT           NOT NULL,
    track_name       VARCHAR(200)  NOT NULL,
    composer         VARCHAR(220)  NULL,
    milliseconds     INT           NOT NULL,
    bytes            INT           NULL,
    list_price       NUMERIC(10,2) NOT NULL,
    album_id         INT           NULL,
    album_title      VARCHAR(160)  NULL,
    artist_id        INT           NULL,
    artist_name      VARCHAR(120)  NULL,
    genre_id         INT           NULL,
    genre_name       VARCHAR(120)  NULL,
    media_type_id    INT           NOT NULL,
    media_type_name  VARCHAR(120)  NOT NULL,
    CONSTRAINT pk_dim_track PRIMARY KEY (track_key),
    CONSTRAINT uq_dim_track_bk UNIQUE (track_id)
);

CREATE TABLE dim_employee (
    employee_key     INT GENERATED ALWAYS AS IDENTITY,
    employee_id      INT          NOT NULL,
    first_name       VARCHAR(20)  NOT NULL,
    last_name        VARCHAR(20)  NOT NULL,
    title            VARCHAR(30)  NULL,
    reports_to_name  VARCHAR(41)  NULL,
    hire_date        DATE         NULL,
    city             VARCHAR(40)  NULL,
    state            VARCHAR(40)  NULL,
    country          VARCHAR(40)  NULL,
    email            VARCHAR(60)  NULL,
    CONSTRAINT pk_dim_employee PRIMARY KEY (employee_key),
    CONSTRAINT uq_dim_employee_bk UNIQUE (employee_id)
);

CREATE TABLE dim_billing_location (
    billing_location_key  INT GENERATED ALWAYS AS IDENTITY,
    billing_address       VARCHAR(70)  NULL,
    billing_city          VARCHAR(40)  NULL,
    billing_state         VARCHAR(40)  NULL,
    billing_country       VARCHAR(40)  NULL,
    billing_postal_code   VARCHAR(10)  NULL,
    CONSTRAINT pk_dim_billing_location PRIMARY KEY (billing_location_key)
);

CREATE TABLE fact_invoice_line (
    invoice_line_key      BIGINT GENERATED ALWAYS AS IDENTITY,
    invoice_line_id       INT            NOT NULL,
    invoice_id            INT            NOT NULL,
    invoice_date_key      INT            NOT NULL,
    customer_key          INT            NOT NULL,
    track_key             INT            NOT NULL,
    employee_key          INT            NULL,
    billing_location_key  INT            NULL,
    quantity              INT            NOT NULL,
    unit_price            NUMERIC(10,2)  NOT NULL,
    line_amount           NUMERIC(12,2)  NOT NULL,
    CONSTRAINT pk_fact_invoice_line PRIMARY KEY (invoice_line_key),
    CONSTRAINT uq_fact_invoice_line_bk UNIQUE (invoice_line_id),
    CONSTRAINT fk_fil_date     FOREIGN KEY (invoice_date_key)     REFERENCES dim_date (date_key),
    CONSTRAINT fk_fil_customer FOREIGN KEY (customer_key)         REFERENCES dim_customer (customer_key),
    CONSTRAINT fk_fil_track    FOREIGN KEY (track_key)            REFERENCES dim_track (track_key),
    CONSTRAINT fk_fil_employee FOREIGN KEY (employee_key)         REFERENCES dim_employee (employee_key),
    CONSTRAINT fk_fil_billing  FOREIGN KEY (billing_location_key) REFERENCES dim_billing_location (billing_location_key)
);

CREATE INDEX ix_fil_date     ON fact_invoice_line (invoice_date_key);
CREATE INDEX ix_fil_customer ON fact_invoice_line (customer_key);
CREATE INDEX ix_fil_track    ON fact_invoice_line (track_key);
CREATE INDEX ix_fil_employee ON fact_invoice_line (employee_key);
CREATE INDEX ix_fil_billing  ON fact_invoice_line (billing_location_key);
CREATE INDEX ix_fil_invoice  ON fact_invoice_line (invoice_id);
