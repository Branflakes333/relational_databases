-- 1. Write a query to return number of employees in each department.
SELECT department_id, COUNT(DISTINCT employee_id) 
FROM department_employee
GROUP BY department_id
HAVING COUNT(DISTINCT employee_id) > 1
ORDER BY department_id DESC;

-- 2. Write a query to find all the employees who have had more than 2 titles.
SELECT employee_id, COUNT(DISTINCT title)
FROM title
GROUP BY employee_id
HAVING COUNT(DISTINCT title) > 2;

-- 3. Write a query to return all the titles for those employees who have more than 2 titles.
SELECT title, (
    SELECT employee_id
    FROM title
    GROUP BY employee_id
    HAVING COUNT(DISTINCT title) > 2
) AS emp_id
FROM title
WHERE employee_id = emp_id;

-- 4. By department return the minimum, average and maximum salary.

-- 5. Write a query to return departments in descending order of various job titles in those departments.

-- 6. Find all the departments where there are more female employees than males.

-- 7. Find all the hires by month. So we get all the employees hired in each month.

SHOW DATA_DIRECTORY;