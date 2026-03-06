USE hr_analystics;
SHOW TABLES;
SELECT *
FROM `wa_fn-usec_-hr-employee-attrition`
LIMIT 5;
RENAME TABLE `wa_fn-usec_-hr-employee-attrition`
TO employee_attrition;
SELECT * FROM employee_attrition LIMIT 5;
SELECT COUNT(*) FROM employee_attrition;
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS leavers,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS attrition_rate_percent
FROM employee_attrition;
SELECT 
    JobRole,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY JobRole
ORDER BY attrition_rate_percent DESC;
SELECT 
    OverTime,
    COUNT(*) AS total,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY OverTime;
SELECT 
    CASE 
        WHEN YearsAtCompany <= 2 THEN '0-2'
        WHEN YearsAtCompany <= 5 THEN '2-5'
        WHEN YearsAtCompany <= 10 THEN '5-10'
        ELSE '10+'
    END AS tenure_group,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY tenure_group
ORDER BY attrition_rate_percent DESC;
SELECT 
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END),2) AS avg_income_leavers,
    ROUND(AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END),2) AS avg_income_stayers
FROM employee_attrition;
SELECT 
    JobSatisfaction,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;
SELECT 
    COUNT(*) AS leavers,
    ROUND(AVG(MonthlyIncome) * 12,2) AS avg_annual_salary,
    ROUND(COUNT(*) * AVG(MonthlyIncome) * 12 * 0.5,2) AS estimated_replacement_cost
FROM employee_attrition
WHERE Attrition = 'Yes';
SELECT 
    COUNT(*) AS leavers,
    ROUND(AVG(MonthlyIncome) * 12,2) AS avg_annual_salary,
    ROUND(COUNT(*) * AVG(MonthlyIncome) * 12 * 0.5,2) AS estimated_replacement_cost
FROM employee_attrition
WHERE Attrition = 'Yes';
USE hr_analystics;
RENAME TABLE `wa_fn-usec_-hr-employee-attrition` TO employee_attrition;
SELECT 
  COUNT(*) total,
  SUM(Attrition='Yes') leavers,
  ROUND(SUM(Attrition='Yes')/COUNT(*)*100,2) attrition_rate
FROM employee_attrition;