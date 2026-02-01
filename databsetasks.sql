#1.	Create a database named dbemp and switch to it.
create database dbemp;
use dbemp;
#2.	Create an employee table with appropriate data types 
#and constraints for employee details.
create table employee(
		EmployeeID varchar(20) NOT NULL PRIMARY KEY,
        FirstName varchar(20),
        LastName varchar(20),
        Gender char(1),
        DateofBirth DATE,
        Designation varchar(50),
        DepartmentName varchar(20),
        ManagerId varchar(20),
        JoinedDate DATE,
        Salary decimal(10,0)
);
#3.	Insert at least two employee records into the employee table.
insert into employee (
EmployeeID,FirstName,LastName,Gender,DateofBirth,Designation,
DepartmentName,ManagerId,JoinedDate,Salary)
values (
'0009','Season','Maharjan','M','1996-04-02','Engineer',
'Software Engineering', '0005','2022-04-02','5000000'
),(
'0010','Ramesh','Rai','M','2000-04-02','Manager',
'Software Engineering', '0003','2022-04-02','1000000'
);
select * from employee;
use dbemp;
update employee 
set Gender ='M'
where EmployeeID='003';
select Firstname, curdate() as CurrentDate,
DateofBirth,
timestampdiff(YEAR, DateofBirth,CURDATE())as Age 
from employee where timestampdiff(YEAR,DateofBirth,CURDATE()) >25;
select *
FROM employee
WHERE DateofBirth = (SELECT MIN(DateofBirth) FROM employee);
select *
FROM employee
WHERE DateofBirth = (SELECT MAX(DateofBirth) FROM employee);
select DepartmentName, MAX(Salary) as Maxsalary
FROM employee group by DepartmentName;
select * from employee;
select FirstName from employee where
EmployeeID in (select ManagerID FROM employee);
select * from employee
where JoinedDate=(select Max(JoinedDate) from employee);
