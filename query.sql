CREATE TABLE IF NOT EXISTS TITLES (
	title_id VARCHAR UNIQUE NOT NULL,
	title VARCHAR NOT NULL,
	PRIMARY KEY(title_id)
);

CREATE TABLE IF NOT EXISTS EMPLOYEES (
	emp_no INT UNIQUE NOT NULL,
	emp_title VARCHAR NOT NULL,
	birthdate VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date VARCHAR NOT NULL,
	PRIMARY KEY(emp_no),
	FOREIGN KEY(emp_title) REFERENCES TITLES(title_id)
);

CREATE TABLE IF NOT EXISTS SALARIES (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	PRIMARY KEY(emp_no),
	FOREIGN KEY(emp_no) REFERENCES EMPLOYEES(emp_no)
);

CREATE TABLE IF NOT EXISTS DEPARTMENTS (
	department_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY(department_no)
);

CREATE TABLE IF NOT EXISTS DEPT_MANAGER (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY(emp_no),
	FOREIGN KEY(dept_no) REFERENCES DEPARTMENTS(department_no),
	FOREIGN KEY(emp_no) REFERENCES EMPLOYEES(emp_no)
);

CREATE TABLE IF NOT EXISTS DEPT_EMPLOYEE (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	PRIMARY KEY(emp_no, dept_no),
	FOREIGN KEY(emp_no) REFERENCES EMPLOYEES(emp_no),
	FOREIGN KEY(dept_no) REFERENCES DEPARTMENTS(department_no)
);

--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM SALARIES as s
LEFT JOIN EMPLOYEES as e
ON e.emp_no = s.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date FROM EMPLOYEES
WHERE hire_date LIKE '%/1986';

--List the manager of each department with the following information: 
	--department number, department name, the manager's employee number, last name, first name
SELECT d.department_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM DEPT_MANAGER as dm
LEFT JOIN DEPARTMENTS as d ON dm.dept_no = d.department_no
LEFT JOIN EMPLOYEES as e ON dm.emp_no = e.emp_no;

--List the department of each employee with the following information: 
	--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM DEPT_EMPLOYEE as de
	LEFT JOIN EMPLOYEES as e 
		ON de.emp_no = e.emp_no
	LEFT JOIN DEPARTMENTS as d
		ON de.dept_no = d.department_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B.
SELECT first_name, last_name, sex FROM EMPLOYEES 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their 
	--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM DEPT_EMPLOYEE as de
	INNER JOIN EMPLOYEES as e
		ON de.emp_no = e.emp_no
	INNER JOIN DEPARTMENTS as d
		ON de.dept_no = d.department_no
		WHERE d.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their 
	--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM DEPT_EMPLOYEE as de
	INNER JOIN EMPLOYEES as e
		ON de.emp_no = e.emp_no
	INNER JOIN DEPARTMENTS as d
		ON de.dept_no = d.department_no
		WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS ln_total
FROM EMPLOYEES GROUP BY last_name ORDER BY ln_total;