CREATE DATABASE CHURNANALYSIS;
USE churnanalysis;

# Overall churn rate
SELECT 
COUNT(*) AS total_customers,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*),2) AS churn_rate
FROM churn_data;

# Churn rate by contract type
SELECT 
  Contract,
  COUNT(*) AS total,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM churn_data
GROUP BY Contract;

#High-risk segment
SELECT
tenure,
AVG(MonthlyCharges) AS avg_charge,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_count
FROM churn_data
GROUP BY tenure
ORDER BY tenure;

# Churn by Tenure
SELECT 
  CASE 
    WHEN tenure <= 12 THEN '0-12'
    WHEN tenure <= 24 THEN '12-24'
    ELSE '24+'
  END AS tenure_group,
  COUNT(*) AS total,
  SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM churn_data
GROUP BY tenure_group;