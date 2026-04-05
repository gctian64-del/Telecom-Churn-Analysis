-- ============================================================
-- FILE    : 05_churn_by_contract.sql
-- PROJECT : Telecom Customer Churn Analysis
-- AUTHOR  : Pavithra Panneerselvam
-- ============================================================
--
-- BUSINESS QUESTION
-- -----------------
-- Which contract type is driving the most churn?
-- Where should the retention team focus its effort and budget?
--
-- WHY THIS QUERY MATTERS
-- ----------------------
-- Not all churn is equal. A company may have an overall churn
-- rate of 26%, but if 90% of that churn comes from one
-- contract segment, the solution is targeted — not company-wide.
--
-- Contract type is one of the most actionable levers a telecom
-- business has. Unlike age or location, the company can
-- directly influence which contract a customer is on through
-- pricing, promotions, and sales incentives.
--
-- This query identifies whether the churn problem is:
--   a) Concentrated in month-to-month (fixable with incentives)
--   b) Spread across all contract types (systemic issue)
--   c) Driven by annual contracts (suggests a value/service gap)
--
-- HOW IT WORKS
-- ------------
-- Standard GROUP BY aggregation on Contract. The ORDER BY
-- churn_rate_pct DESC surfaces the highest-risk contract type
-- at the top — making the output immediately readable without
-- needing to scan the full result set.
--
-- EXPECTED OUTPUT (on sample data)
-- ---------------------------------
--   Contract         | total | churned | churn_rate_pct
--   -----------------+-------+---------+---------------
--   Month-to-month   |   6   |    5    |     83.33
--   One year         |   4   |    0    |      0.00
--
-- BUSINESS INTERPRETATION
-- -----------------------
-- Month-to-month customers show dramatically higher churn.
-- This validates the standard industry finding and directly
-- supports the recommendation to offer contract upgrade
-- incentives at the 6-month mark (see README recommendations).
-- ============================================================

SELECT
    Contract,
    COUNT(*)                                AS total_customers,
    SUM(churn_status)                       AS churned_customers,
    ROUND(AVG(churn_status) * 100, 2)       AS churn_rate_pct
FROM v_telecom_clean
GROUP BY Contract
ORDER BY churn_rate_pct DESC;
