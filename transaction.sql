-- ===============================
-- DATABASE CREATION
-- ===============================

CREATE DATABASE IF NOT EXISTS BankDB;
USE BankDB;

-- ===============================
-- ACCOUNTS TABLE
-- ===============================

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(20),
    balance DECIMAL(10,2)
);

-- Insert sample records
INSERT INTO accounts VALUES
(1, 'Ram', 50000),
(2, 'Shyam', 30000),
(3, 'Sita', 20000);

-- View records
SELECT * FROM accounts;

-- ===============================
-- TRANSACTION 1 (COMMIT)
-- Transfer Rs.5000 from Ram to Shyam
-- ===============================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

COMMIT;

-- ===============================
-- TRANSACTION 2 (ROLLBACK)
-- Transfer Rs.10000 from Shyam to Sita
-- ===============================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 10000
WHERE account_id = 2;

UPDATE accounts
SET balance = balance + 10000
WHERE account_id = 3;

ROLLBACK;

-- ===============================
-- TRANSACTION 3 (SAVEPOINT)
-- ===============================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 1;

SAVEPOINT sp1;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 2;

ROLLBACK TO sp1;

COMMIT;

-- ===============================
-- EMPLOYEES TABLE
-- ===============================

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

-- ===============================
-- SALARY LOG TABLE
-- ===============================

CREATE TABLE salary_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- TRIGGER 1 (CHECK SALARY)
-- ===============================

DELIMITER $$

CREATE TRIGGER check_salary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 10000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 10000';
    END IF;
END$$

DELIMITER ;

-- ===============================
-- TRIGGER 2 (LOG SALARY UPDATE)
-- ===============================

DELIMITER $$

CREATE TRIGGER log_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_log(emp_id, old_salary, new_salary)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary);
END$$

DELIMITER ;

-- ===============================
-- STORED PROCEDURE 1
-- GET EMPLOYEES
-- ===============================

DELIMITER $$

CREATE PROCEDURE getEmployees()
BEGIN
    SELECT * FROM employees;
END$$

DELIMITER ;

-- Call procedure
CALL getEmployees();

-- ===============================
-- STORED PROCEDURE 2
-- ADD EMPLOYEE
-- ===============================

DELIMITER $$

CREATE PROCEDURE addEmployee(
IN p_id INT,
IN p_name VARCHAR(100),
IN p_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO employees VALUES(p_id, p_name, p_salary);
END$$

DELIMITER ;

-- Call procedure
CALL addEmployee(5, 'Hari', 20000);

-- ===============================
-- STORED PROCEDURE 3
-- UPDATE SALARY
-- ===============================

DELIMITER $$

CREATE PROCEDURE updateSalary(
IN p_id INT,
IN new_salary DECIMAL(10,2)
)
BEGIN
    UPDATE employees
    SET salary = new_salary
    WHERE emp_id = p_id;
END$$

DELIMITER ;

-- Call procedure
CALL updateSalary(5, 30000);

-- ===============================
-- CHECK RESULTS
-- ===============================

SELECT * FROM employees;
SELECT * FROM salary_log;
Delimiter $$
create procedure transferMoney(in from_account int, in to_account int, in to_account int,
in amount decimal(10,2))
begin
start transaction;
update accounts
set balance = balance-amount
where account_id = from_account;
update accounts
set balance = balance+ amount
where account_id = to_accountant;
commit;
end$$
Delimiter ;
call transferMoney(1,2,5000);


end
$$
Delimiter  ;