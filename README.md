# Telecom Customer Churn Analysis

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue?style=flat-square)
![Domain](https://img.shields.io/badge/Domain-Telecommunications-teal?style=flat-square)
![Type](https://img.shields.io/badge/Type-BA%20Portfolio%20Project-purple?style=flat-square)

---

## Business Problem

A telecom company is experiencing significant customer churn — every lost customer represents recurring monthly revenue that costs far more to replace through acquisition than to retain. Leadership needs to understand **who is churning, when, why, and what it is costing the business**, so the retention team can act before customers leave.

This project answers those four questions using SQL on the Telco Customer Churn dataset.

---

## Key Findings

| # | Finding | Business Impact |
|---|---------|----------------|
| 1 | **50% of customers** in the high-risk segment have churned | 1 in 2 customers is at risk — this is a P1 retention problem |
| 2 | **Month-to-month customers** churn at 3–4× the rate of annual contract holders | Contract type is the single most actionable churn lever |
| 3 | **Churn peaks in months 0–12** of the customer lifecycle | New customers need immediate engagement, not just onboarding emails |
| 4 | **~43% of monthly revenue** is exposed to churn risk | Reframes churn from a % metric into a financial business case |
| 5 | **Month-to-month + tenure < 12 months** is the highest-risk combined segment | Enables targeted, prioritised outreach rather than broad campaigns |

---

## Recommendations

**1. Launch a 90-day early engagement programme**
New customers on month-to-month contracts should receive a structured check-in sequence at days 7, 30, and 90. This directly addresses the tenure danger zone identified in Query 06.

**2. Offer contract upgrade incentives at month 6**
A small discount on an annual plan offered at the 6-month mark converts high-risk customers into loyal ones. The revenue lost on the discount is far smaller than the revenue lost to churn.

**3. Build a weekly retention priority list**
Using the risk score model from Query 08, the retention team can focus calls on customers with `risk_score = 75` and `value_tier = High` — the segment with both the highest churn probability and the highest revenue at stake.

**4. Report revenue at risk as a board-level KPI**
Query 07 translates churn rate into a monthly revenue figure. This metric gets budget approved for retention programmes far more effectively than a percentage alone.

---

## SQL Query Dictionary

### Query 01 — Overall churn rate (headline KPI)
**Business question:** What percentage of our customers have churned?

```sql
SELECT
    COUNT(*)                          AS total_customers,
    SUM(churn_status)                 AS churned_customers,
    ROUND(AVG(churn_status)*100, 2)   AS churn_rate_pct
FROM v_telecom_clean;
```

---

### Query 02 — Churn by contract type
**Business question:** Which contract type is driving the most churn?

```sql
SELECT
    Contract,
    COUNT(*)                          AS total_customers,
    SUM(churn_status)                 AS churned_customers,
    ROUND(AVG(churn_status)*100, 2)   AS churn_rate_pct
FROM v_telecom_clean
GROUP BY Contract
ORDER BY churn_rate_pct DESC;
```

---

### Query 03 — Tenure-based cohort analysis
**Business question:** At what point in the customer lifecycle does churn spike?

```sql
SELECT
    tenure,
    COUNT(*)                          AS total_customers,
    SUM(churn_status)                 AS churned_customers,
    ROUND(AVG(churn_status)*100, 2)   AS churn_rate_pct
FROM v_telecom_clean
GROUP BY tenure
ORDER BY tenure;
```

---

### Query 04 — Revenue at risk
**Business question:** How much monthly revenue is at risk from churned customers?

```sql
SELECT
    ROUND(SUM(MonthlyCharges), 2)     AS total_monthly_revenue,
    ROUND(SUM(CASE
        WHEN churn_status = 1 THEN MonthlyCharges ELSE 0
    END), 2)                          AS revenue_at_risk,
    ROUND(SUM(CASE
        WHEN churn_status = 1 THEN MonthlyCharges ELSE 0
    END) * 100.0 / SUM(MonthlyCharges), 2) AS revenue_at_risk_pct
FROM v_telecom_clean;
```

---

### Query 05 — Customer risk segmentation
**Business question:** Which individual customers should the retention team call first?

Scoring logic: `+50` for month-to-month contract · `+25` for tenure under 12 months · max score = 75

```sql
SELECT
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    (
        CASE WHEN Contract = 'Month-to-month' THEN 50 ELSE 0 END +
        CASE WHEN tenure < 12 THEN 25 ELSE 0 END
    )                                 AS risk_score,
    CASE
        WHEN MonthlyCharges > 80              THEN 'High value'
        WHEN MonthlyCharges BETWEEN 50 AND 80 THEN 'Mid value'
        ELSE                                       'Low value'
    END                               AS value_tier
FROM v_telecom_clean
ORDER BY risk_score DESC, MonthlyCharges DESC;
```

---

### Query 06 — Combined churn drivers
**Business question:** Which combination of contract type and tenure band produces the highest churn concentration?

```sql
SELECT
    Contract,
    CASE
        WHEN tenure < 12              THEN '0–12 months'
        WHEN tenure BETWEEN 12 AND 24 THEN '12–24 months'
        ELSE                               '24+ months'
    END                               AS tenure_band,
    COUNT(*)                          AS total_customers,
    SUM(churn_status)                 AS churned_customers,
    ROUND(AVG(churn_status)*100, 2)   AS churn_rate_pct
FROM v_telecom_clean
GROUP BY Contract, tenure_band
ORDER BY churn_rate_pct DESC;
```

> **Insight:** Month-to-month + 0–12 months is the highest-risk segment by a wide margin. All retention resources should prioritise this cohort first.

---

## Dataset

| Property | Detail |
|----------|--------|
| Source | [Telco Customer Churn — Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn) |
| Origin | IBM Sample Dataset |
| Rows | 7,043 customers |
| Key fields | Contract type, tenure, monthly charges, internet service, churn status |

---

## Tools & Skills

| Area | Detail |
|------|--------|
| Language | SQL (PostgreSQL) |
| Techniques | CTEs, aggregate functions, CASE logic, cohort analysis, risk scoring, multi-dimensional GROUP BY |
| Platform | DB Fiddle (no setup needed) |

---

## Live Demo

Run all queries instantly — no installation required:

**[▶ Open in DB Fiddle](https://www.db-fiddle.com/f/cDAyFBSbijnDFhxcb4sdm9/5)**

---

## Project Structure

```
Telecom-Churn-Analysis/
├── queries/
│   └── telecom_churn_analysis.sql   ← All queries with inline business commentary
├── data/
│   └── telco_churn_sample.csv       ← Sample dataset (10 rows for live demo)
├── reports/
│   └── insights_summary.md          ← Written findings and recommendations
├── README.md
└── LICENSE
```

---

## Skills Demonstrated

- Translating a business problem into structured SQL analysis
- Building a reusable cleaned view to standardise raw data
- Designing a weighted risk scoring model with CASE logic
- Multi-dimensional cohort analysis (contract type × tenure band)
- Quantifying churn as a revenue impact, not just a percentage
- Writing BA-standard documentation with findings and recommendations

---

*Part of my Business Analyst portfolio — [[LinkedIn](https://www.linkedin.com/in/ps-p-322700240/)](#) · [GitHub Profile]https://github.com/gctian64-del/Telecom-Churn-Analysis(#)*
