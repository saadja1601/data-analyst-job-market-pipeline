-- Query 1 — Which skills appear most in DA job postings?

SELECT 
    'SQL' as skill, SUM(sql_skill) as mentions FROM da_jobs
UNION ALL SELECT 'Python', SUM(python_skill) FROM da_jobs
UNION ALL SELECT 'Excel', SUM(excel_skill) FROM da_jobs
UNION ALL SELECT 'Power BI', SUM(power_bi) FROM da_jobs
UNION ALL SELECT 'Tableau', SUM(tableau) FROM da_jobs
UNION ALL SELECT 'ETL', SUM(etl) FROM da_jobs
UNION ALL SELECT 'Azure', SUM(azure) FROM da_jobs
UNION ALL SELECT 'Snowflake', SUM(snowflake) FROM da_jobs
UNION ALL SELECT 'Machine Learning', SUM(machine_learning) FROM da_jobs
UNION ALL SELECT 'Databricks', SUM(databricks) FROM da_jobs
UNION ALL SELECT 'Spark', SUM(spark) FROM da_jobs
UNION ALL SELECT 'AWS', SUM(aws) FROM da_jobs
UNION ALL SELECT 'R', SUM(r_skill) FROM da_jobs
ORDER BY mentions DESC;

----------------------------------------------------------------

-- Query 2 — Which cities in Texas have the most DA job postings?

SELECT 
    city,
    COUNT(*) as job_count,
    ROUND(AVG(avg_salary), 0) as avg_salary
FROM da_jobs
WHERE city != 'Texas'
GROUP BY city
ORDER BY job_count DESC
LIMIT 10;

-----------------------------------------------------

-- Query 3 — What percentage of jobs mention each skill?

SELECT 
    'Excel' as skill,
    SUM(excel_skill) as mentions,
    ROUND(SUM(excel_skill) * 100.0 / COUNT(*), 1) as pct_of_jobs
FROM da_jobs
UNION ALL SELECT 'SQL', SUM(sql_skill), ROUND(SUM(sql_skill) * 100.0 / COUNT(*), 1) FROM da_jobs
UNION ALL SELECT 'Python', SUM(python_skill), ROUND(SUM(python_skill) * 100.0 / COUNT(*), 1) FROM da_jobs
UNION ALL SELECT 'ETL', SUM(etl), ROUND(SUM(etl) * 100.0 / COUNT(*), 1) FROM da_jobs
UNION ALL SELECT 'Power BI', SUM(power_bi), ROUND(SUM(power_bi) * 100.0 / COUNT(*), 1) FROM da_jobs
UNION ALL SELECT 'Tableau', SUM(tableau), ROUND(SUM(tableau) * 100.0 / COUNT(*), 1) FROM da_jobs
UNION ALL SELECT 'Azure', SUM(azure), ROUND(SUM(azure) * 100.0 / COUNT(*), 1) FROM da_jobs
UNION ALL SELECT 'Snowflake', SUM(snowflake), ROUND(SUM(snowflake) * 100.0 / COUNT(*), 1) FROM da_jobs
ORDER BY mentions DESC;

-- Query 4 — What are the most common job titles?

SELECT 
    title,
    COUNT(*) as job_count
FROM da_jobs
GROUP BY title
ORDER BY job_count DESC
LIMIT 10;

----------------------------------------------

-- Query 5 — Jobs posted in the last 3 days, 7 days, 30 days vs older

SELECT 
    CASE 
        WHEN STR_TO_DATE(date_posted, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 3 DAY)
        THEN 'Last 3 days'
        WHEN STR_TO_DATE(date_posted, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
        THEN 'Last 4-7 days'
        WHEN STR_TO_DATE(date_posted, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        THEN 'Last 8-30 days'
        ELSE 'Older than 30 days'
    END as posting_age,
    COUNT(*) as job_count
FROM da_jobs
GROUP BY posting_age
ORDER BY job_count DESC;
