SELECT id, first_name, last_name
FROM employees.employee
LIMIT 5;

SELECT * FROM employees.salary WHERE  employee_id = 10001;

SELECT AVG(amount)
FROM employees.salary
WHERE employee_id = 10001;

SELECT employee_id, AVG(amount)
FROM employees.salary
GROUP BY employee_id
HAVING AVG(amount) > 50000;

SELECT employee_id, COUNT(from_date), AVG(amount)
FROM employees.salary
GROUP BY employee_id
HAVING AVG(amount) > 50000;

SELECT site_id, MIN(daily_mean_pm10_concentration), AVG(daily_mean_pm10_concentration),  MAX(daily_mean_pm10_concentration)
FROM epa_air_quality
GROUP BY site_id
HAVING COUNT(*) > 30;

SELECT  employee_id, first_name, last_name, title.title
FROM employees.employee
JOIN employees.title ON employees.employee.id = employees.title.employee_id;

-- Performance Comparison Queries
-- 1. Scan
EXPLAIN SELECT * FROM epa_test.epa_air_quality_no_index;
EXPLAIN SELECT * FROM epa_test.epa_air_quality_clustered;
-- The same sequential scan

-- 2. Search with Equality Selection
EXPLAIN SELECT * FROM epa_test.epa_air_quality_no_index WHERE site_id = 60070008;
EXPLAIN SELECT * FROM epa_test.epa_air_quality_clustered WHERE site_id = 60070008;
-- Here, the index scan is used for the indexed table
EXPLAIN SELECT * FROM epa_test.epa_air_quality_primary_index WHERE site_id = 60070008;
-- Used Sequential Scan again because index is on primary key (date, site_id)

-- 3. Search with Range Selection
EXPLAIN ANALYZE SELECT * FROM epa_test.epa_air_quality_primary_index WHERE site_id = 60070008 AND date = '2020-08-01';
-- Used Index Scan because the index is on primary key (date, site_id)
EXPLAIN SELECT * FROM epa_test.epa_air_quality_no_index WHERE daily_mean_pm10_concentration > 50 AND daily_mean_pm10_concentration < 100;
EXPLAIN SELECT * FROM epa_test.epa_air_quality_clustered WHERE daily_mean_pm10_concentration > 50 AND daily_mean_pm10_concentration < 100;

-- 4. Insert a new record
EXPLAIN INSERT INTO epa_test.epa_air_quality_no_index VALUES ('2020-08-01', 60070008, 29, 20);
EXPLAIN INSERT INTO epa_test.epa_air_quality_clustered VALUES ('2020-08-01', 60070008, 29, 20);

-- 5. Delete a record
EXPLAIN DELETE FROM epa_test.epa_air_quality_no_index WHERE site_id = 60070008 AND date = '2020-08-01';
EXPLAIN DELETE FROM epa_test.epa_air_quality_clustered WHERE site_id = 60070008 AND date = '2020-08-01';
