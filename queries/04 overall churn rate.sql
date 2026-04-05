-- ============================================================
-- FILE    : 04_overall_churn_rate.sql
-- PROJECT : Telecom Customer Churn Analysis
-- AUTHOR  : Pavithra Panneerselvam
-- ============================================================
--
-- BUSINESS QUESTION
-- -----------------
-- What is our overall customer churn rate, and how many
-- customers have we lost in absolute terms?
--
-- WHY THIS QUERY MATTERS
-- ----------------------
-- This is the headline KPI for any churn analysis. Before
-- drilling into causes (contract type, tenure, pricing), a
-- business needs to know the scale of the problem. A 5% churn
-- rate demands a different response than a 30% churn rate.
--
-- In a BA deliverable, this number goes on the executive
-- summary slide or the top of the report — it is the single
-- metric that answers "how bad is it?"
--
-- HOW IT WORKS
-- ------------
-- AVG(churn_status) works because churn_status is 0 or 1.
-- The average of a binary column equals the proportion of 1s,
-- which is the churn rate. Multiplying by 100 converts it
-- to a percentage. This is cleaner than the traditional
-- COUNT(WHERE churn='Yes') / COUNT(*) pattern because it
-- requires no subquery or CTE.
--
-- EXPECTED OUTPUT (on sample data)
-- ----------------------------------
--   total_customers | churned_customers | churn_rate_pct
--   ----------------+------------------+---------------
--        10         |        5         |     50.00
--
-- BUSINESS INTERPRETATION
-- -----------------------
-- An industry-average churn rate for telecom is ~20–25%.
-- Anything above 30% is considered a critical retention
-- problem requiring immediate executive action.
-- ============================================================

SELECT
    COUNT(*)                                AS total_customers,
    SUM(churn_status)                       AS churned_customers,
    ROUND(AVG(churn_status) * 100, 2)       AS churn_rate_pct
FROM v_telecom_clean;
