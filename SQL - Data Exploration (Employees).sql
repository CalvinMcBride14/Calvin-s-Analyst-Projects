Goals of the Analysis are as follows:

1. Average salary of current employees with their associated job titles.
2. Average salaries held by department managers distinguished by department.
3. Number of employees in each department.
4. Employees that are active and previous employees who have left the company.
5. Which employees are making over a specified salary amount.
6. List employees that hold the title of Assistant Manager.
7. Managers with their manager status provided in a seperate column.
8. List employees that were hired bewteen a specified range of dates.

This Dataset found at: https://www.dropbox.com/s/znmjrtlae6vt4zi/employees.sql?dl=0


/* Perform Data Exploration */
------------------------------


/* Find the average salary of all CURRENT employees by job title. */

WITH cte AS
	(SELECT  t.*, s.salary
	FROM titles t
	JOIN salaries s 
	ON t.emp_no = s.emp_no
	WHERE s.to_date = '9999-01-01')
SELECT 
title,
AVG(salary) AS avg_salary
FROM cte
GROUP BY 1
ORDER BY 2 DESC;

----------------------------------------------------------------------------------------------------------------------------------------------------

/* Find the average salaries greater than $60,000 of department managers seperated by department. */

SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC
;

----------------------------------------------------------------------------------------------------------------------------------------------------

/* Find the total number of employees in each department. (List associated department number and department name). */

SELECT d.dept_no, de.dept_name, count(e.emp_no) AS num_of_employees
FROM employees e
JOIN dept_emp d
ON d.emp_no = e.emp_no
JOIN departments de
ON de.dept_no = d.dept_no
GROUP BY 1
ORDER BY 3 DESC;


----------------------------------------------------------------------------------------------------------------------------------------------------

/* Write a query that shows which employees are currently active and which are no longer employeed with the company. */

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 1000;


----------------------------------------------------------------------------------------------------------------------------------------------------

/* Find which employees by their full name, has been given a salary increase greater than $30,000. */

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000, 'Salary was raised by more then $30,000', 'Salary was NOT raised by more then $30,000') AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;


----------------------------------------------------------------------------------------------------------------------------------------------------

/* Retrieve a list of all employees and any all other relevant information regarding them, who hold the title of "Assistant Engineer". */

SELECT 
    e.*, t.title
FROM
    employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE
    t.title IN ( SELECT 
          	  title
        	FROM
         	   titles
        	WHERE
           	 title = 'Assistant Engineer')
ORDER BY emp_no
LIMIT 500;


----------------------------------------------------------------------------------------------------------------------------------------------------

/* Retrieve a list of all managers with an output contaning employee number, first name, last name, and a new coulumn indicating manager status. */


SELECT
	e.emp_no,
	e.first_name, 
	e.last_name,
CASE 
	WHEN dm.emp_no IS NOT NULL THEN 'Manager'
	ELSE 'Employee' 
END AS is_manager
FROM
 employees e
JOIN 
dept_manager dm 
ON dm.emp_no = e.emp_no
ORDER BY dm.emp_no;


----------------------------------------------------------------------------------------------------------------------------------------------------

/* Obtain the total number of employees that were hired before, between, and after the dates of 1990 and 1995. */

SELECT a.employeed_date, COUNT(*) AS Counts
 FROM 
	(SELECT 
    emp_no, 
    hire_date, 
    SUBSTRING(hire_date FROM 1 FOR 4) AS hire_date_year,
	CASE 
		WHEN SUBSTRING(hire_date FROM 1 FOR 4) < '1990' THEN 'Employeed before 1990'
		WHEN SUBSTRING(hire_date FROM 1 FOR 4) >= '1990' AND SUBSTRING(hire_date FROM 1 FOR 4) <= 1995 THEN 'Employeed between 1990 and 1995'
		ELSE 'Employeed after 1995' 
	END AS employeed_date
	FROM employees) a 
GROUP BY a.employeed_date;

