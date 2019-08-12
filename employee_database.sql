
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

DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
 	emp_id int   NOT NULL,
	FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
	title varchar NOT NULL,
    from_date varchar NOT NULL,
    to_date  varchar not null 
);









