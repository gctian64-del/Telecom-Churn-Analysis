-- ============================================================
-- FILE    : 03_create_view.sql
-- PROJECT : Telecom Customer Churn Analysis
-- AUTHOR  : Pavithra Panneerselvam
-- ============================================================
--
-- PURPOSE
-- -------
-- Creates v_telecom_clean — a reusable analytical view that
-- sits on top of raw_churn_data and handles all data quality
-- and type conversion issues in one place.
--
-- All analysis queries (04 through 09) are built on top of
-- this view, never directly on the raw table. This is a
-- core data engineering best practice: separate raw storage
-- from analytical consumption.
--
-- WHAT THIS VIEW DOES
-- -------------------
-- 1. FIXES TotalCharges
--    Raw source stores TotalCharges as VARCHAR to accommodate
--    blank values for brand-new customers. This view safely
--    casts it to NUMERIC using NULLIF + TRIM to handle:
--      - Empty strings ('')
--      - Strings with only whitespace ('  ')
--    Rows with blank TotalCharges receive NULL — they are
--    included in all analysis but excluded from revenue sums.
--
-- 2. ENCODES Churn AS 0/1
--    Converts 'Yes'/'No' string to a binary integer.
--    This enables AVG(churn_status) to directly return the
--    churn rate as a decimal (e.g. 0.2653 = 26.53%) without
--    any additional CASE logic in every downstream query.
--    It also enables SUM(churn_status) to count churned
--    customers without a subquery or filter.
--
-- 3. EXPOSES ONLY NEEDED COLUMNS
--    The view surfaces only the 6 columns used across all
--    analysis queries. This keeps downstream SQL clean and
--    makes the analytical intent of each query obvious.
--
-- WHY A VIEW AND NOT A TABLE?
-- ---------------------------
-- A view reflects the latest raw data automatically — if more
-- rows are inserted into raw_churn_data, all analysis queries
-- immediately reflect the update with no manual refresh step.
-- For a production pipeline, this would be a materialised
-- view or a dbt model; a standard view is appropriate here
-- for a portfolio demonstration.
--
-- NEXT STEP
-- ---------
-- After running this script, execute any of the analysis
-- queries (04 through 09) in any order.
-- ============================================================

CREATE VIEW v_telecom_clean AS
SELECT
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    CAST(
        NULLIF(TRIM(TotalCharges), '')
        AS NUMERIC(10, 2)
    )                                               AS TotalCharges,
    CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END       AS churn_status
FROM raw_churn_data;
