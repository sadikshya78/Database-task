-- 1️⃣ Create DEPARTMENT table FIRST
CREATE TABLE DEPARTMENT (
    DNO NUMBER PRIMARY KEY,
    Dname VARCHAR2(20),
    Mgrstartdate NUMBER,
    MgrSSN NUMBER
);

-- 2️⃣ Insert department data
INSERT INTO DEPARTMENT VALUES (1, 'HR', 2020, 101);
INSERT INTO DEPARTMENT VALUES (2, 'Finance', 2021, 102);
INSERT INTO DEPARTMENT VALUES (3, 'IT', 2019, 103);
INSERT INTO DEPARTMENT VALUES (4, 'Marketing', 2022, 104);

-- 3️⃣ Create employee2 table AFTER department
CREATE TABLE employee2 (
    Fname VARCHAR2(20),
    LName VARCHAR2(20),
    SSN NUMBER PRIMARY KEY,
    Address VARCHAR2(20),
    sex CHAR(1),
    salary NUMBER,
    superSSN NUMBER,
    DNO NUMBER,
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO)
);

-- 4️⃣ Insert employee data
INSERT INTO employee2 
(Fname, LName, SSN, Address, sex, salary, superSSN, DNO)
VALUES ('Amit', 'Shrestha', 115, 'Chitwan', 'M', 48000, 113, 4);

INSERT INTO employee2 
(Fname, LName, SSN, Address, sex, salary, superSSN, DNO)
VALUES ('Ram', 'Thapa', 117, 'Pokhara', 'M', 55000, 115, 1);

INSERT INTO employee2 
(Fname, LName, SSN, Address, sex, salary, superSSN, DNO)
VALUES ('Gita', 'Rai', 118, 'Lalitpur', 'F', 47000, 117, 2);

INSERT INTO employee2 
(Fname, LName, SSN, Address, sex, salary, superSSN, DNO)
VALUES ('Hari', 'Gurung', 119, 'Bhaktapur', 'M', 60000, 117, 3);

-- DNO 5 removed because department 5 does not exist
INSERT INTO employee2 
(Fname, LName, SSN, Address, sex, salary, superSSN, DNO)
VALUES ('Nita', 'Sharma', 120, 'Biratnagar', 'F', 52000, 118, 4);

COMMIT;

-- 5️⃣ Query with corrected department name
SELECT E.Fname, E.LName,
E.salary * 1.10 AS increased_salary
FROM employee2 E
JOIN DEPARTMENT D
ON E.DNO = D.DNO
WHERE D.Dname = 'Marketing';

-- 6️⃣ Aggregate query
SELECT SUM(E.salary) AS total_salary,
       MAX(E.salary) AS max_salary,
       MIN(E.salary) AS min_salary,
       AVG(E.salary) AS avg_salary
FROM employee2 E
JOIN DEPARTMENT D
ON E.DNO = D.DNO
WHERE D.Dname = 'HR';

-- 7️⃣ Select employees by department
SELECT Fname, LName
FROM employee2
WHERE DNO = 4;

-- EXISTS Query
SELECT Fname, Lname
FROM employee2 E
WHERE EXISTS (
    SELECT 1
    FROM employee2
    WHERE DNO = 4
    AND SSN = E.SSN
);

-- Department wise employee count
SELECT D.DNO,
       D.Dname,
       COUNT(E.SSN) AS total_employees
FROM DEPARTMENT D
JOIN employee2 E
ON D.DNO = E.DNO
GROUP BY D.DNO, D.Dname
HAVING COUNT(E.SSN) >= 2;

-- Add DOB column
ALTER TABLE employee2
ADD DOB DATE;

-- Update DOB values
UPDATE employee2
SET DOB = TO_DATE('1995-06-15','YYYY-MM-DD')
WHERE SSN = 115;

UPDATE employee2
SET DOB = TO_DATE('1992-03-10','YYYY-MM-DD')
WHERE SSN = 117;

UPDATE employee2
SET DOB = TO_DATE('1988-01-20','YYYY-MM-DD')
WHERE SSN = 118;

COMMIT;

-- Select employees by DOB range
SELECT Fname, LName, DOB
FROM employee2
WHERE DOB BETWEEN 
TO_DATE('1990-01-01','YYYY-MM-DD')
AND 
TO_DATE('1999-12-31','YYYY-MM-DD');

-- Join query
SELECT E.Fname,
       E.LName,
       D.Dname AS Department_Name
FROM employee2 E
JOIN DEPARTMENT D
ON E.DNO = D.DNO;