-- ============================================================
-- FILE    : 01_create_table.sql
-- PROJECT : Telecom Customer Churn Analysis
-- AUTHOR  : Pavithra Panneerselvam
-- ============================================================
--
-- PURPOSE
-- -------
-- Creates the raw staging table that holds all customer data
-- exactly as it arrives from the source system (Kaggle /
-- IBM Telco dataset). No transformations are applied here —
-- this table is intentionally "raw" so that the original
-- data is preserved and auditable at all times.
--
-- DESIGN DECISIONS
-- ----------------
-- 1. TotalCharges is stored as VARCHAR(20), not NUMERIC.
--    The source dataset contains blank strings ('') for new
--    customers who have not yet been billed a full month.
--    Casting directly to NUMERIC at ingestion would cause an
--    error or silent NULL on those rows. We handle the cast
--    cleanly in the view (see 03_create_view.sql).
--
-- 2. All Yes/No columns (Partner, Dependents, Churn, etc.)
--    are stored as VARCHAR(5). This matches the raw source
--    format. The Churn column is encoded as 0/1 integer in
--    the view layer, not here.
--
-- 3. SeniorCitizen is stored as INT (0 or 1) because the
--    source dataset already provides it in binary format.
--
-- NEXT STEP
-- ---------
-- After running this script, execute 02_insert_data.sql to
-- load the sample records into this table.
-- ============================================================

CREATE TABLE raw_churn_data (
    customerID       VARCHAR(20),   -- Unique customer identifier
    gender           VARCHAR(10),   -- Male / Female
    SeniorCitizen    INT,           -- 1 = senior citizen, 0 = not
    Partner          VARCHAR(5),    -- Yes / No
    Dependents       VARCHAR(5),    -- Yes / No
    tenure           INT,           -- Months with the company
    PhoneService     VARCHAR(5),    -- Yes / No
    MultipleLines    VARCHAR(20),   -- Yes / No / No phone service
    InternetService  VARCHAR(20),   -- DSL / Fiber optic / No
    OnlineSecurity   VARCHAR(20),   -- Yes / No / No internet service
    OnlineBackup     VARCHAR(20),   -- Yes / No / No internet service
    DeviceProtection VARCHAR(20),   -- Yes / No / No internet service
    TechSupport      VARCHAR(20),   -- Yes / No / No internet service
    StreamingTV      VARCHAR(20),   -- Yes / No / No internet service
    StreamingMovies  VARCHAR(20),   -- Yes / No / No internet service
    Contract         VARCHAR(20),   -- Month-to-month / One year / Two year
    PaperlessBilling VARCHAR(5),    -- Yes / No
    PaymentMethod    VARCHAR(40),   -- Electronic check / Mailed check / etc.
    MonthlyCharges   NUMERIC(10,2), -- Current monthly bill amount
    TotalCharges     VARCHAR(20),   -- Cumulative charges (VARCHAR — see note above)
    Churn            VARCHAR(5)     -- Yes / No — target variable
);
