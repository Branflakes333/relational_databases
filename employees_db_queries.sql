-- Active: 1757107452919@@127.0.0.1@5432@msds691


-- 1. Write a query to return number of employees in each department.
SELECT department_id, COUNT(DISTINCT employee_id) 
FROM employees.department_employee
GROUP BY department_id
HAVING COUNT(DISTINCT employee_id) > 1
ORDER BY department_id DESC;


-- 2. Write a query to find all the employees who have had more than 2 titles.
SELECT employee_id, COUNT(DISTINCT title)
FROM employees.title
GROUP BY employee_id
HAVING COUNT(DISTINCT title) > 2;


-- 3. Write a query to return all the titles for those employees who have more than 2 titles.
SELECT DISTINCT title
FROM employees.title INNER JOIN (
    SELECT employee_id
    FROM employees.title
    GROUP BY employee_id
    HAVING COUNT(DISTINCT title) > 2
    ) AS dist_title ON title.employee_id=dist_title.employee_id;


-- 4. By department return the minimum, average and maximum salary.
SELECT MIN(amount), AVG(amount), MAX(amount)
FROM employees.salary JOIN employees.department_employee ON salary.employee_id = department_employee.employee_id
GROUP BY department_id;


-- 5. Write a query to return departments in descending order of various job titles in those departments.
SELECT department_id, title
FROM title JOIN department_employee ON title.employee_id = department_employee.employee_id
GROUP BY department_id, title
ORDER BY COUNT(DISTINCT title) DESC;








-- 6. Find all the departments where there are more female employees than males.
SELECT department_id
FROM employees.department_employee AS de JOIN employees.employees AS e ON de.employee_id = e.employee_id
GROUP BY department_id
HAVING -- GET the num gender compare


-- 7. Find all the hires by month. So we get all the employees hired in each month.
SELECT EXTRACT(MONTH FROM hire_date) AS hire_month, COUNT(employee_id)
FROM employees
GROUP BY hire_month
HAVING COUNT(employee_id) > 1
ORDER BY hire_month;