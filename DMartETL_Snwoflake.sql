-- ============================================================
-- DMART ETL - Snowflake RAW Layer Setup & Validation
-- ============================================================
-- Purpose:
-- 1. Create the database and RAW_DATA schema.
-- 2. Create raw tables for incoming D-Mart data.
-- 3. Create the CSV file format and internal stage.
-- 4. Run basic validation checks after loading data.
-- ============================================================


-- ============================================================
-- 1. DATABASE & SCHEMA
-- ============================================================

CREATE DATABASE IF NOT EXISTS DMART_ETL;

CREATE SCHEMA IF NOT EXISTS DMART_ETL.RAW_DATA;


-- ============================================================
-- 2. RAW TABLES
-- ============================================================

-- Raw Sales Transactions
CREATE OR REPLACE TABLE DMART_ETL.RAW_DATA.SALES_TRANSACTIONS (
    INVOICE_ID STRING,
    STORE_ID STRING,
    PRODUCT_ID STRING,
    DATE DATE,
    QUANTITY NUMBER,
    PRICE NUMBER(10,2),
    DISCOUNT NUMBER(10,2),
    PAYMENT_MODE STRING,
    CUSTOMER_ID STRING,
    SALES_CHANNEL STRING,
    CASHIER_ID STRING,
    INVOICE_AMOUNT NUMBER(10,2),
    GST_AMOUNT NUMBER(10,2),
    RETURN_FLAG BOOLEAN
);


-- Raw Store Information
CREATE OR REPLACE TABLE DMART_ETL.RAW_DATA.STORE_INFO (
    STORE_ID STRING,
    STORE_NAME STRING,
    CITY STRING,
    DISTRICT STRING,
    STATE STRING,
    OPENING_DATE DATE,
    STORE_TYPE STRING,
    AREA_SQFT NUMBER,
    MANAGER_ID STRING,
    LATITUDE FLOAT,
    LONGITUDE FLOAT
);


-- Raw Product Information
CREATE OR REPLACE TABLE DMART_ETL.RAW_DATA.PRODUCTS (
    PRODUCT_ID STRING,
    CATEGORY STRING,
    SUBCATEGORY STRING,
    BRAND STRING,
    UNIT_SIZE STRING,
    UNIT_MEASURE STRING,
    MRP NUMBER(10,2),
    SUPPLIER_ID STRING,
    SHELF_LIFE_DAYS NUMBER,
    IMPORT_FLAG STRING
);


-- Raw Calendar / Date Information
CREATE OR REPLACE TABLE DMART_ETL.RAW_DATA.CALENDAR (
    DATE DATE,
    MONTH NUMBER,
    YEAR NUMBER,
    DAY_OF_WEEK STRING,
    QUARTER STRING,
    HOLIDAY_FLAG BOOLEAN,
    FESTIVAL_NAME STRING,
    SEASON STRING
);


-- ============================================================
-- 3. CSV FILE FORMAT
-- ============================================================
-- Defines how CSV files should be interpreted during loading.

CREATE OR REPLACE FILE FORMAT DMART_ETL.RAW_DATA.MY_CSV_FORMAT
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    EMPTY_FIELD_AS_NULL = TRUE
    TRIM_SPACE = TRUE;


-- ============================================================
-- 4. INTERNAL STAGE
-- ============================================================
-- Stage used to hold files before loading them into RAW tables.

CREATE OR REPLACE STAGE DMART_ETL.RAW_DATA.DMART_STAGE
    FILE_FORMAT = DMART_ETL.RAW_DATA.MY_CSV_FORMAT;


-- ============================================================
-- 5. VALIDATION - DATABASE OBJECTS
-- ============================================================

-- Check that RAW tables were created successfully.
SHOW TABLES IN SCHEMA DMART_ETL.RAW_DATA;

-- Check that the file format exists.
SHOW FILE FORMATS IN SCHEMA DMART_ETL.RAW_DATA;

-- Check that the stage exists.
SHOW STAGES IN SCHEMA DMART_ETL.RAW_DATA;


-- ============================================================
-- 6. VALIDATION - STAGE CONTENTS
-- ============================================================
-- Lists files currently available in the internal stage.

LIST @DMART_ETL.RAW_DATA.DMART_STAGE;


-- ============================================================
-- 7. VALIDATION - ROW COUNTS
-- ============================================================
-- Quick check to confirm that data has been loaded into
-- each RAW table.

SELECT COUNT(*) AS SALES_TRANSACTION_COUNT
FROM DMART_ETL.RAW_DATA.SALES_TRANSACTIONS;

SELECT COUNT(*) AS STORE_COUNT
FROM DMART_ETL.RAW_DATA.STORE_INFO;

SELECT COUNT(*) AS PRODUCT_COUNT
FROM DMART_ETL.RAW_DATA.PRODUCTS;

SELECT COUNT(*) AS CALENDAR_COUNT
FROM DMART_ETL.RAW_DATA.CALENDAR;


-- ============================================================
-- 8. VALIDATION - SAMPLE DATA
-- ============================================================
-- Inspect a few records from each RAW table.

SELECT *
FROM DMART_ETL.RAW_DATA.SALES_TRANSACTIONS
LIMIT 10;

SELECT *
FROM DMART_ETL.RAW_DATA.STORE_INFO
LIMIT 10;

SELECT *
FROM DMART_ETL.RAW_DATA.PRODUCTS
LIMIT 10;

SELECT *
FROM DMART_ETL.RAW_DATA.CALENDAR
LIMIT 10;
