**Telecom Churn Analysis (SQL Project)**
**Project Overview:** 
This project provides a data-driven analysis of customer churn behavior within a telecommunications company. By utilizing SQL, I identified key patterns, segmented high-risk customer groups, and uncovered the primary factors leading to service cancellations.

**📂 Dataset**
Source: Telco Customer Churn Dataset (Public Resource)
Data Points: Includes customer demographics, account information (contract type, payment method, monthly charges), and service usage metrics.

**Tools & Skills**
Language: SQL (PostgreSQL/Standard SQL)
Techniques: Common Table Expressions (CTEs), Aggregate Functions, Conditional Logic (CASE statements), and Data Segmentation.
Platform: DB Fiddle

**Live SQL Demo**
You can execute the full analysis script in a live environment without any setup:
👉 Run Live SQL Queries on DB Fiddle

**SQL Query Dictionary**
_1. Churn Rate Calculation_
What it does: Calculates the total percentage of customers who have churned.

Business Value: Provides the primary KPI to measure the health of the customer base.

SQL
WITH churned AS (
    SELECT COUNT(*) AS churned_count
    FROM customers
    WHERE churn = 'Yes'
),
total AS (
    SELECT COUNT(*) AS total_count
    FROM customers
)
SELECT 
    ROUND(churned_count * 100.0 / total_count, 2) AS churn_rate_percentage
FROM churned, total;

_2. Tenure-Based Cohort Analysis_
What it does: Breaks down churned vs. active customers based on how many months they have been with the company.

Business Value: Identifies the "Danger Zone"—the specific time frame when new customers are most likely to leave.

SQL
SELECT 
    tenure,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM customers
GROUP BY tenure
ORDER BY tenure;

_3. Customer Risk Segmentation_
What it does: Categories customers into 'High', 'Medium', and 'Low' risk based on their monthly spending.

Business Value: Allows marketing teams to prioritize high-value retention offers.

SQL
SELECT 
    customer_id,
    monthly_charges,
    CASE 
        WHEN monthly_charges > 80 THEN 'High Risk'
        WHEN monthly_charges BETWEEN 50 AND 80 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level
FROM customers;

**Key Insights**
The Tenure Trap: Customers are at the highest risk of churning within their first 6 months.
Pricing Sensitivity: Customers with monthly charges exceeding $80 show a significantly higher churn rate compared to lower-paying tiers.
Contract Friction: Month-to-month contracts are the leading predictor of churn, while 1-year and 2-year contracts show high loyalty.

**Business Recommendations**
Early Engagement: Target new customers with "check-in" offers during their first 90 days.
Incentivize Commitment: Offer small discounts to transition "Month-to-Month" users into annual contracts.
Value Protection: Proactively reach out to "High Risk" (high-paying) segments with loyalty rewards before they churn.

**Project Structure**
├── sql_queries/        # Individual .sql files for different analysis stages
├── data/               # Documentation on the dataset source
├── README.md           # Project documentation and summary

**License**
This project is licensed under the MIT License. Feel free to use the queries for your own analysis!
