-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_id, e.last_name, e.first_name, e.gender, s.salary
FROM salaries AS s
INNER JOIN employees AS e ON
e.emp_id = s.emp_id;

-- 2. List employees who were hired in 1986.

SELECT * FROM employees
WHERE hire_date LIKE '1986%';

--3.List the manager of each department with the following information:
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT d.dept_name,  m.dept_no,m.emp_id ,e.first_name, e.last_name,e.hire_date
FROM department AS d
INNER JOIN dept_manager AS m ON
d.dept_no = m.dept_no
JOIN employees as e on
e.emp_id = m.emp_id;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_id, e.first_name, e.last_name,dp.dept_name
from employees as e
inner join dept_emp as d on
d.emp_id = e.emp_id
inner join department as dp on
dp.dept_no = d.dept_no;  

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT e.emp_id, e.first_name, e.last_name,dp.dept_name
from employees as e
inner join dept_emp as d on
d.emp_id = e.emp_id
inner join department as dp on
dp.dept_no = d.dept_no  
where dp.dept_name like 'Sales' ;

--7List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT e.emp_id, e.first_name, e.last_name,dp.dept_name
from employees as e
inner join dept_emp as d on
d.emp_id = e.emp_id
inner join department as dp on
dp.dept_no = d.dept_no  
where dp.dept_name like 'Sales' or 
dp.dept_name like 'Development' ;

-- 8. In descending order, 
--list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(*) as frequency 
from employees 
group by last_name
order by frequency desc;




