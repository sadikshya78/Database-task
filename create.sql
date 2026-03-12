-- Create Database
CREATE DATABASE IF NOT EXISTS TechSolutionDB;
USE TechSolutionDB;

-- Department Table
CREATE TABLE IF NOT EXISTS Department (
    DepID INT PRIMARY KEY,
    DepName VARCHAR(20),
    Location VARCHAR(20)
);

-- Employee Table
CREATE TABLE IF NOT EXISTS Employee (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    Gender CHAR(1),
    Salary INT,
    HireDate DATE,
    DepID INT,
    FOREIGN KEY (DepID) REFERENCES Department(DepID)
);

-- Project Table
CREATE TABLE IF NOT EXISTS Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(20),
    StartDate DATE,
    EndDate DATE,
    Budget INT
);

-- Works_on Table
CREATE TABLE IF NOT EXISTS Works_on (
    EmpID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- Insert Departments
INSERT INTO Department (DepID, DepName, Location) VALUES
(1, 'IT', 'Kathmandu'),
(2, 'HR', 'Pokhara'),
(3, 'Finance', 'Lalitpur'),
(4, 'Marketing', 'Bhaktapur'),
(5, 'Support', 'Biratnagar');

-- Insert Employees
INSERT INTO Employee (EmpID, FirstName, LastName, Gender, Salary, HireDate, DepID) VALUES
(101, 'Ram', 'Sharma', 'M', 50000, '2022-01-10', 1),
(102, 'Sita', 'Khadka', 'F', 45000, '2021-03-15', 2),
(103, 'Hari', 'Thapa', 'M', 55000, '2020-07-20', 1),
(104, 'Gita', 'Adhikari', 'F', 48000, '2023-02-05', 3),
(105, 'Bikash', 'Rai', 'M', 47000, '2022-09-18', 4);

-- Insert Projects
INSERT INTO Project (ProjectID, ProjectName, StartDate, EndDate, Budget) VALUES
(201, 'WebsiteDev', '2023-01-01', '2023-06-01', 200000),
(202, 'MobileApp', '2023-02-15', '2023-08-30', 300000),
(203, 'DatabaseSys', '2023-03-10', '2023-07-25', 150000),
(204, 'NetworkSetup', '2023-04-01', '2023-09-01', 250000),
(205, 'SecurityAudit', '2023-05-20', '2023-10-10', 180000);

-- Insert Works_on
INSERT INTO Works_on (EmpID, ProjectID, HoursWorked) VALUES
(101, 201, 120),
(102, 202, 90),
(103, 203, 150),
(104, 204, 110),
(105, 205, 80);

-- Update salary of EmpID = 102 by 10%
UPDATE Employee
SET Salary = Salary * 1.10
WHERE EmpID = 102;

-- Delete project 205 (and associated works_on record)
DELETE FROM Works_on WHERE ProjectID = 205;
DELETE FROM Project WHERE ProjectID = 205;

-- Queries
-- 1. Employees earning more than 50,000
SELECT * FROM Employee WHERE Salary > 50000;

-- 2. Employees sorted by salary descending
SELECT FirstName, LastName, Salary FROM Employee ORDER BY Salary DESC;

-- 3. Employees in IT department
SELECT E.EmpID, E.FirstName, E.LastName, D.DepName
FROM Employee E
JOIN Department D ON E.DepID = D.DepID
WHERE D.DepName = 'IT';

-- 4. Total number of employees per department
SELECT D.DepName, COUNT(E.EmpID) AS TotalEmployees
FROM Department D
LEFT JOIN Employee E ON D.DepID = E.DepID
GROUP BY D.DepName;

-- 5. Employees hired after 2022-01-01
SELECT FirstName, LastName, HireDate FROM Employee WHERE HireDate > '2022-01-01';
# join Question
# Display employee names along with their department names.
SELECT E.FirstName, E.LastName, D.DepName
FROM Employee E
JOIN Department D
ON E.DepID = D.DepID;
# Show employees and the project they are working on
SELECT E.FirstName, E.LastName, P.ProjectName, W.HoursWorked
FROM Employee E
JOIN Works_on W ON E.EmpID = W.EmpID
JOIN Project P ON W.ProjectID = P.ProjectID;
#Display project names with the total hours worked by employees
SELECT P.ProjectName, SUM(W.HoursWorked) AS TotalHoursWorked
FROM Project P
JOIN Works_on W ON P.ProjectID = W.ProjectID
GROUP BY P.ProjectName;
# Aggregate and Advanced question
# find the average salary of employees in each department
SELECT D.DepName, AVG(E.Salary) AS AvgSalary
FROM Department D
JOIN Employee E ON D.DepID = E.DepID
GROUP BY D.DepName;
# Display the department with the highest number of employees
SELECT D.DepName, COUNT(E.EmpID) AS TotalEmployees
FROM Department D
JOIN Employee E ON D.DepID = E.DepID
GROUP BY D.DepName
ORDER BY TotalEmployees DESC
LIMIT 1;
SELECT FirstName, LastName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

# find employees whose salary is greater than the average salary of all employees
SELECT EmpID, FirstName, LastName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);
#part f 
# create a view named HighSalaryEmployees that shows employees with salary greater than 60,000
CREATE VIEW HighSalaryEmployees AS
SELECT EmpID, FirstName, LastName, Salary, DepID
FROM Employee
WHERE Salary > 60000;
#create an index on the LastName column of the Employee table
CREATE INDEX idx_LastName
ON Employee (LastName);










-- 6. View all tables
SELECT * FROM Department;
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM Works_on;