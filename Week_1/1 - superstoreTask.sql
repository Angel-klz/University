
CREATE DATABASE superstore;

CREATE TABLE customers(
    customer_id VARCHAR(30) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE products(
    product_id VARCHAR(30) PRIMARY KEY,
    category VARCHAR(30),
    sub_category VARCHAR(50),
    product_name VARCHAR(100)
);

CREATE TABLE orders(
    order_id VARCHAR(30) PRIMARY KEY, 
    customer_id VARCHAR(30),
    product_id VARCHAR(30),
    order_date DATE,
    ship_date DATE,
    sales DECIMAL(10, 2),
    quantity INT,
    discount DECIMAL(10, 2),
    profit DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--The data loading was done through the terminal using commands such as:
--1).& "C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -d superstore
--2).superstore=# \copy customers FROM 'C:\Users\profi\Downloads\customers.csv' DELIMITER ',' CSV HEADER  
--Result: COPY 30
--superstore=# \copy products FROM 'C:\Users\profi\Downloads\products.csv' DELIMITER ',' CSV HEADER;
--Result: COPY 30
--superstore=# \copy orders FROM 'C:\Users\profi\Downloads\orders.csv' DELIMITER ',' CSV HEADER;
--Result: COPY 30

