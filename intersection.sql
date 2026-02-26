DROP DATABASE IF EXISTS employees;
CREATE DATABASE employees;
USE employees;

CREATE TABLE departments(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255)
);

CREATE TABLE Employee(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'Human Resource'),
(4, 'Customer Service'),
(5, 'Research and Development');

INSERT INTO Employee VALUES 
(1, 'Homer Simpson', 4), 
(2, 'Ned Flanders', 1),
(3, 'Barney Gamble', 5),
(4, 'Clancy Wiggum', 3),
(5, 'Sambridhi Neupane', 2);

SELECT emp.employee_name, dep.department_name
FROM Employee emp
INNER JOIN departments dep 
ON emp.department_id = dep.department_id;


SELECT * 
FROM Employee emp
LEFT JOIN departments dep 
ON emp.department_id = dep.department_id;


SELECT * 
FROM Employee emp
cross join departments