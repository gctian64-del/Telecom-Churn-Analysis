-- ============================================================
-- FILE    : 06_tenure_cohort.sql
-- PROJECT : Telecom Customer Churn Analysis
-- AUTHOR  : Pavithra Panneerselvam
-- ============================================================
--
-- BUSINESS QUESTION
-- -----------------
-- At what point in the customer lifecycle is churn most likely
-- to occur? Is there a specific "danger window" that the
-- business should target with retention interventions?
--
-- WHY THIS QUERY MATTERS
-- ----------------------
-- Knowing the overall churn rate (Query 04) tells you the
-- scale of the problem. Knowing WHEN churn happens tells you
-- WHERE to invest in prevention.
--
-- If churn spikes in months 1–6, the business has an
-- onboarding problem — customers are not finding value quickly
-- enough. If it spikes at month 12, it may be a contract
-- renewal problem — customers are leaving when their annual
-- plan expires. Each pattern requires a completely different
-- retention strategy.
--
-- This is cohort analysis: grouping customers by a shared
-- characteristic (their tenure month) and measuring behaviour
-- across those groups. It is one of the most common and
-- high-value analytical techniques in BA work.
--
-- HOW IT WORKS
-- ------------
-- Each unique value of tenure (0, 1, 2, ... 72) becomes its
-- own group. For each group we count total customers, sum
-- churned customers, and calculate the churn rate. Ordering
-- by tenure ASC creates a timeline view — you can read the
-- output top to bottom as months 0 through 72 and see exactly
-- where churn concentrates.
--
-- NOTE: On the 10-row sample, each tenure value will have
-- very few customers, so individual rates will be 0% or 100%.
-- This query produces its most meaningful output on the full
-- 7,043-row dataset from Kaggle.
--
-- EXPECTED PATTERN (on full dataset)
-- ------------------------------------
-- Churn rate is highest in months 1–12, drops significantly
-- from month 13 onwards, and approaches near-zero by month 48.
-- This creates a clear "engagement cliff" in the first year.
--
-- BUSINESS INTERPRETATION
-- -----------------------
-- The first 12 months are the critical window. A proactive
-- check-in programme (calls or personalised offers at months
-- 1, 3, 6, and 12) can meaningfully reduce the early-tenure
-- churn rate and extend average customer lifetime value.
-- ============================================================

SELECT
    tenure,
    COUNT(*)                                AS total_customers,
    SUM(churn_status)                       AS churned_customers,
    ROUND(AVG(churn_status) * 100, 2)       AS churn_rate_pct
FROM v_telecom_clean
GROUP BY tenure
ORDER BY tenure;
