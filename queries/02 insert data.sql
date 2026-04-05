-- ============================================================
-- FILE    : 02_insert_data.sql
-- PROJECT : Telecom Customer Churn Analysis
-- AUTHOR  : Pavithra Panneerselvam
-- ============================================================
--
-- PURPOSE
-- -------
-- Loads 10 representative sample rows into raw_churn_data.
-- These records are hand-picked from the full Kaggle dataset
-- to cover all key analytical scenarios used in this project:
--
--   - Churned vs. non-churned customers
--   - Month-to-month vs. annual contract holders
--   - Low, mid, and high monthly charge tiers
--   - Short tenure (< 12 months) and long tenure (> 24 months)
--   - DSL vs. Fiber optic internet service types
--
-- WHY SAMPLE DATA?
-- ----------------
-- The full Kaggle dataset contains 7,043 rows. For a GitHub
-- portfolio project, a clean 10-row sample lets any recruiter
-- or reviewer run the queries instantly in DB Fiddle without
-- needing to upload a CSV file. The SQL logic is identical
-- whether run on 10 rows or 7,000.
--
-- TO USE THE FULL DATASET
-- -----------------------
-- 1. Download telco_churn.csv from:
--    https://www.kaggle.com/datasets/blastchar/telco-customer-churn
-- 2. Use a bulk load tool (e.g. \COPY in psql, or the DB
--    import wizard in pgAdmin) to load all rows into
--    raw_churn_data before running the analysis queries.
--
-- NEXT STEP
-- ---------
-- After running this script, execute 03_create_view.sql.
-- ============================================================

INSERT INTO raw_churn_data VALUES
--  customerID      gender   Sr  Part  Dep  ten  Phone  MultiLines         Internet       OnlineSec  OnlineBack DevProt    TechSup    StreamTV   StreamMov  Contract          PaperBill  PayMethod            Monthly  Total      Churn
('7590-VHVEG', 'Female', 0, 'Yes', 'No',  1,  'No',  'No phone service', 'DSL',         'No',  'Yes', 'No',  'No',  'No',  'No',  'Month-to-month', 'Yes', 'Electronic check',  29.85, '29.85',    'No'),
('5575-GNVDE', 'Male',   0, 'No',  'No',  34, 'Yes', 'No',               'DSL',         'Yes', 'No',  'Yes', 'No',  'No',  'No',  'One year',        'No',  'Mailed check',      56.95, '1889.5',   'No'),
('3668-QPYBK', 'Male',   0, 'No',  'No',  2,  'Yes', 'No',               'DSL',         'Yes', 'Yes', 'No',  'No',  'No',  'No',  'Month-to-month',  'Yes', 'Mailed check',      53.85, '108.15',   'Yes'),
('7795-CFOCW', 'Male',   0, 'No',  'No',  45, 'No',  'No phone service', 'DSL',         'Yes', 'No',  'Yes', 'Yes', 'No',  'No',  'One year',        'No',  'Bank transfer',     42.30, '1840.75',  'No'),
('9305-CDSKC', 'Female', 0, 'No',  'No',  2,  'Yes', 'Yes',              'Fiber optic', 'No',  'No',  'No',  'No',  'No',  'Yes', 'Month-to-month',  'Yes', 'Electronic check',  70.70, '151.65',   'Yes'),
('1452-KIOVK', 'Male',   0, 'No',  'Yes', 8,  'Yes', 'Yes',              'Fiber optic', 'No',  'No',  'No',  'No',  'Yes', 'Yes', 'Month-to-month',  'Yes', 'Credit card',       99.65, '820.50',   'Yes'),
('6713-OKOMC', 'Female', 0, 'No',  'No',  22, 'No',  'No phone service', 'DSL',         'Yes', 'No',  'No',  'No',  'No',  'No',  'One year',        'No',  'Mailed check',      29.75, '643.30',   'No'),
('7892-POOKP', 'Female', 0, 'Yes', 'No',  28, 'Yes', 'Yes',              'Fiber optic', 'No',  'No',  'No',  'No',  'Yes', 'Yes', 'Month-to-month',  'Yes', 'Electronic check', 104.80, '3046.05',  'Yes'),
('6388-TABGU', 'Male',   0, 'No',  'Yes', 49, 'Yes', 'No',               'DSL',         'Yes', 'Yes', 'No',  'Yes', 'No',  'No',  'One year',        'No',  'Bank transfer',     56.15, '2702.70',  'No'),
('9763-GRSKD', 'Male',   0, 'Yes', 'Yes', 25, 'Yes', 'No',               'DSL',         'Yes', 'No',  'No',  'No',  'No',  'No',  'Month-to-month',  'Yes', 'Mailed check',      49.95, '1225.45',  'No');
