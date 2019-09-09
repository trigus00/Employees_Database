# Employees_Database

Background

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, you will perform:


Data Modeling
Data Engineering
Data Analysis




# Data Modeling

See Data Modeling:Employee Database .png

# Data Engineering 
```
--creating employees table

DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
    emp_id int primary key NOT NULL,
    birth_date varchar NOT NULL,
	first_name character varying(45) NOT NULL,
 	last_name character varying(45) NOT NULL,
	gender varchar not null,
	hire_date varchar NOT NULL  
	);
	
-- creating department table

DROP TABLE IF EXISTS department;
CREATE TABLE department (
  dept_no varchar primary key NOT NULL,
  dept_name varchar NOT NULL
 
);

-- creating dept_emp table

DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp (
	emp_id int NOT NULL,
	FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    dept_no varchar NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES department(dept_no),
	from_date varchar NOT NULL,
    to_date  varchar not null 
	);
	

--creating dept_manager


DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
	dept_no varchar not null,
	FOREIGN KEY (dept_no) REFERENCES department(dept_no),
	emp_id int NOT NULL,
	FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    from_date varchar NOT NULL,
    to_date  varchar  not null 
	);


--creating salaries table

DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
	emp_id int  NOT NULL,
	FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
	salary integer NOT NULL,
    from_date varchar NOT NULL,
    to_date  varchar not null 
);

--creating titles table 
'''
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
 	emp_id int   NOT NULL,
	FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
	title varchar NOT NULL,
    from_date varchar NOT NULL,
    to_date  varchar not null 
);
```

# Data Analysis 
```

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
```
# Bonus 
```
# Dependencies and Setup
# SQL Alchemy
from sqlalchemy import create_engine

# Pandas
import pandas as pd

# Matplotlib
import matplotlib.pyplot as plt

# NumPy
import numpy as np

#config
from config import database_uri 
engine = create_engine(database_uri)
conn = engine.connect()
# Query All Records in the Salaries Table
salaries_data = pd.read_sql("SELECT * FROM salaries",conn) 
salaries_data.head()
emp_id	salary	from_date	to_date
0	10001	60117	1986-06-26	1987-06-26
1	10002	65828	1996-08-03	1997-08-03
2	10003	40006	1995-12-03	1996-12-02
3	10004	40054	1986-12-01	1987-12-01
4	10005	78228	1989-09-12	1990-09-12
# Query All Records in the Titles Table
titles_data = pd.read_sql("SELECT * FROM titles", conn)
titles_data.head()
emp_id	title	from_date	to_date
0	10001	Senior Engineer	1986-06-26	9999-01-01
1	10002	Staff	1996-08-03	9999-01-01
2	10003	Senior Engineer	1995-12-03	9999-01-01
3	10004	Engineer	1986-12-01	1995-12-01
4	10004	Senior Engineer	1995-12-01	9999-01-01
#Merging Salaries and Title with emp_id as a join
combined_date = pd.merge(salaries_data,titles_data , how = 'inner',on ='emp_id')
combined_date.head()
emp_id	salary	from_date_x	to_date_x	title	from_date_y	to_date_y
0	10001	60117	1986-06-26	1987-06-26	Senior Engineer	1986-06-26	9999-01-01
1	10002	65828	1996-08-03	1997-08-03	Staff	1996-08-03	9999-01-01
2	10003	40006	1995-12-03	1996-12-02	Senior Engineer	1995-12-03	9999-01-01
3	10004	40054	1986-12-01	1987-12-01	Engineer	1986-12-01	1995-12-01
4	10004	40054	1986-12-01	1987-12-01	Senior Engineer	1995-12-01	9999-01-01
#Grouping titles 
group_by_title = combined_date.groupby("title").mean()
group_by_title.head()
emp_id	salary
title		
Assistant Engineer	251495.398533	48493.204786
Engineer	252943.159987	48539.781423
Manager	110780.833333	51531.041667
Senior Engineer	253034.375949	48506.751806
Senior Staff	253423.367183	58503.286614
#droping emp_id from the data frame 
salary_mean = group_by_title.drop(columns = 'emp_id')
salary_mean.head()
salary
title	
Assistant Engineer	48493.204786
Engineer	48539.781423
Manager	51531.041667
Senior Engineer	48506.751806
Senior Staff	58503.286614
#creating a bar chart 
#salary_mean.plot.bar(y='salary')
# Reset Index
salary_mean = salary_mean.reset_index()
salary_mean.head()
title	salary
0	Assistant Engineer	48493.204786
1	Engineer	48539.781423
2	Manager	51531.041667
3	Senior Engineer	48506.751806
4	Senior Staff	58503.286614
#creating a neat/organized bar graph 
career = salary_mean["title"]
ticks = np.arange(len(career))
salary = salary_mean["salary"]

# Create Bar Chart Based on Above Data
plt.bar(career, salary, align="center", alpha=0.5, color=["red", "orange", "yellow", "green", "blue", "violet", "navy"])

# Create Ticks for Bar Chart's x_axis
plt.xticks(ticks, career, rotation="vertical")

# Set Labels & Title
plt.ylabel("Salaries ($)")
plt.xlabel("Employee Titles")
plt.title("Average Employee Salary by Title")


# Show plot
plt.show()

 ```
