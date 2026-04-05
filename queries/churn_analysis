-- ============================================================
-- TELECOM CHURN ANALYSIS
-- Author  : Pavithra Panneerselvam
-- Role    : Business Analyst Portfolio Project
-- Dataset : Telco Customer Churn (Kaggle / IBM Sample)
-- Tool    : DB Fiddle (PostgreSQL)
-- ============================================================
-- CONTENTS
--   01. Create table
--   02. Insert sample data
--   03. Create cleaned view
--   04. KPI  — Overall churn rate
--   05. KPI  — Churn by contract type
--   06. KPI  — Tenure-based churn cohort
--   07. KPI  — Revenue at risk
--   08. KPI  — Customer risk segmentation
--   09. KPI  — Combined churn drivers
-- ============================================================


-- ============================================================
-- 01. CREATE TABLE
-- ============================================================

CREATE TABLE raw_churn_data (
    customerID       VARCHAR(20),
    gender           VARCHAR(10),
    SeniorCitizen    INT,
    Partner          VARCHAR(5),
    Dependents       VARCHAR(5),
    tenure           INT,
    PhoneService     VARCHAR(5),
    MultipleLines    VARCHAR(20),
    InternetService  VARCHAR(20),
    OnlineSecurity   VARCHAR(20),
    OnlineBackup     VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport      VARCHAR(20),
    StreamingTV      VARCHAR(20),
    StreamingMovies  VARCHAR(20),
    Contract         VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod    VARCHAR(40),
    MonthlyCharges   NUMERIC(10, 2),
    TotalCharges     VARCHAR(20),
    Churn            VARCHAR(5)
);


-- ============================================================
-- 02. INSERT SAMPLE DATA
-- ============================================================

INSERT INTO raw_churn_data VALUES
('7590-VHVEG', 'Female', 0, 'Yes', 'No',  1,  'No',  'No phone service', 'DSL', 'No',  'Yes', 'No',  'No',  'No',  'No',  'Month-to-month', 'Yes', 'Electronic check', 29.85, '29.85',   'No'),
('5575-GNVDE', 'Male',   0, 'No',  'No',  34, 'Yes', 'No',               'DSL', 'Yes', 'No',  'Yes', 'No',  'No',  'No',  'One year',        'No',  'Mailed check',     56.95, '1889.5',  'No'),
('3668-QPYBK', 'Male',   0, 'No',  'No',  2,  'Yes', 'No',               'DSL', 'Yes', 'Yes', 'No',  'No',  'No',  'No',  'Month-to-month',  'Yes', 'Mailed check',     53.85, '108.15',  'Yes'),
('7795-CFOCW', 'Male',   0, 'No',  'No',  45, 'No',  'No phone service', 'DSL', 'Yes', 'No',  'Yes', 'Yes', 'No',  'No',  'One year',        'No',  'Bank transfer',    42.30, '1840.75', 'No'),
('9305-CDSKC', 'Female', 0, 'No',  'No',  2,  'Yes', 'Yes',              'Fiber optic', 'No', 'No', 'No',  'No',  'No',  'Yes', 'Month-to-month', 'Yes', 'Electronic check', 70.70, '151.65', 'Yes'),
('1452-KIOVK', 'Male',   0, 'No',  'Yes', 8,  'Yes', 'Yes',              'Fiber optic', 'No', 'No', 'No',  'No',  'Yes', 'Yes', 'Month-to-month', 'Yes', 'Credit card',      99.65, '820.50', 'Yes'),
('6713-OKOMC', 'Female', 0, 'No',  'No',  22, 'No',  'No phone service', 'DSL', 'Yes', 'No',  'No',  'No',  'No',  'No',  'One year',        'No',  'Mailed check',     29.75, '643.30', 'No'),
('7892-POOKP', 'Female', 0, 'Yes', 'No',  28, 'Yes', 'Yes',              'Fiber optic', 'No', 'No', 'No',  'No',  'Yes', 'Yes', 'Month-to-month', 'Yes', 'Electronic check', 104.80,'3046.05','Yes'),
('6388-TABGU', 'Male',   0, 'No',  'Yes', 49, 'Yes', 'No',               'DSL', 'Yes', 'Yes', 'No',  'Yes', 'No',  'No',  'One year',        'No',  'Bank transfer',    56.15, '2702.70','No'),
('9763-GRSKD', 'Male',   0, 'Yes', 'Yes', 25, 'Yes', 'No',               'DSL', 'Yes', 'No',  'No',  'No',  'No',  'No',  'Month-to-month',  'Yes', 'Mailed check',     49.95, '1225.45','No');


-- ============================================================
-- 03. CREATE CLEANED VIEW
-- Standardises data types; encodes Churn as 0/1 integer.
-- TotalCharges stored as VARCHAR in source to handle blanks.
-- ============================================================

CREATE VIEW v_telecom_clean AS
SELECT
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    CAST(NULLIF(TRIM(TotalCharges), '') AS NUMERIC(10, 2))  AS TotalCharges,
    CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END               AS churn_status
FROM raw_churn_data;


-- ============================================================
-- 04. OVERALL CHURN RATE  —  Headline KPI
-- Business question: What percentage of our customers have
-- churned, and how much of our base does that represent?
-- ============================================================

SELECT
    COUNT(*)                                    AS total_customers,
    SUM(churn_status)                           AS churned_customers,
    ROUND(AVG(churn_status) * 100, 2)           AS churn_rate_pct
FROM v_telecom_clean;

/*
  EXPECTED INSIGHT:
  A churn rate above 25% is a critical retention risk.
  Use this as the headline number in your README / report.
*/


-- ============================================================
-- 05. CHURN BY CONTRACT TYPE  —  Biggest churn driver
-- Business question: Which contract type produces the most
-- churn? Where should retention spend be focused?
-- ============================================================

SELECT
    Contract,
    COUNT(*)                                    AS total_customers,
    SUM(churn_status)                           AS churned_customers,
    ROUND(AVG(churn_status) * 100, 2)           AS churn_rate_pct
FROM v_telecom_clean
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

/*
  EXPECTED INSIGHT:
  Month-to-month customers churn at 3-4x the rate of annual
  contract customers. Recommendation: offer discounted
  annual plans to month-to-month customers at the 3-month mark.
*/


-- ============================================================
-- 06. TENURE-BASED CHURN COHORT  —  When does churn happen?
-- Business question: At what point in the customer lifecycle
-- is churn most likely to occur?
-- ============================================================

SELECT
    tenure,
    COUNT(*)                                    AS total_customers,
    SUM(churn_status)                           AS churned_customers,
    ROUND(AVG(churn_status) * 100, 2)           AS churn_rate_pct
FROM v_telecom_clean
GROUP BY tenure
ORDER BY tenure;

/*
  EXPECTED INSIGHT:
  Churn peaks in months 1-12. Customers who survive past
  month 24 are significantly more loyal. Recommendation:
  invest in onboarding and early engagement programmes
  for the first 12 months.
*/


-- ============================================================
-- 07. REVENUE AT RISK  —  Business impact in currency
-- Business question: How much monthly revenue is at risk
-- from churned or high-risk customers?
-- ============================================================

SELECT
    ROUND(SUM(MonthlyCharges), 2)               AS total_monthly_revenue,
    ROUND(SUM(
        CASE WHEN churn_status = 1
             THEN MonthlyCharges ELSE 0
        END), 2)                                AS revenue_at_risk,
    ROUND(
        SUM(CASE WHEN churn_status = 1
                 THEN MonthlyCharges ELSE 0 END)
        * 100.0 / SUM(MonthlyCharges), 2)       AS revenue_at_risk_pct
FROM v_telecom_clean;

/*
  EXPECTED INSIGHT:
  Translates churn from a % metric into a currency business problem.
  This is the number that gets executive attention and budget.
  Always include a revenue impact figure in BA deliverables.
*/


-- ============================================================
-- 08. CUSTOMER RISK SEGMENTATION  —  Prioritise retention
-- Business question: Which individual customers should the
-- retention team contact first?
--
-- Risk scoring logic:
--   +50  Month-to-month contract  (no loyalty commitment)
--   +25  Tenure < 12 months       (early-stage, at-risk window)
--   Max score = 75 (highest risk)
-- ============================================================

SELECT
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    (
        CASE WHEN Contract = 'Month-to-month' THEN 50 ELSE 0 END +
        CASE WHEN tenure < 12                 THEN 25 ELSE 0 END
    )                                           AS risk_score,
    CASE
        WHEN MonthlyCharges > 80              THEN 'High value'
        WHEN MonthlyCharges BETWEEN 50 AND 80 THEN 'Mid value'
        ELSE                                       'Low value'
    END                                         AS value_tier
FROM v_telecom_clean
ORDER BY risk_score DESC, MonthlyCharges DESC;

/*
  EXPECTED INSIGHT:
  Customers with risk_score = 75 AND value_tier = 'High value'
  are the top retention priority: high churn probability AND
  high revenue impact if lost.
*/


-- ============================================================
-- 09. COMBINED CHURN DRIVERS  —  Multi-dimensional analysis
-- Business question: Which combination of contract type and
-- tenure band produces the highest churn concentration?
-- This query separates junior analysts from senior ones.
-- ============================================================

SELECT
    Contract,
    CASE
        WHEN tenure < 12                  THEN '0-12 months'
        WHEN tenure BETWEEN 12 AND 24     THEN '12-24 months'
        ELSE                                   '24+ months'
    END                                         AS tenure_band,
    COUNT(*)                                    AS total_customers,
    SUM(churn_status)                           AS churned_customers,
    ROUND(AVG(churn_status) * 100, 2)           AS churn_rate_pct
FROM v_telecom_clean
GROUP BY Contract, tenure_band
ORDER BY churn_rate_pct DESC;

/*
  EXPECTED INSIGHT:
  Month-to-month + 0-12 months is the highest-risk segment
  by a large margin. Recommended retention actions:
    1. Early onboarding calls at month 1-3
    2. Discounted annual contract upgrade offer at month 6
    3. Loyalty reward at the 12-month milestone
*/
