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