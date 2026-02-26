show databases;
use dbemp;
create table Dept(
DEPNO INT PRIMARY KEY,
DNAME Varchar(10),
LOC Varchar(10)
);
#1.
Rename table Dept to DEPARTMENT;
#q2.
Alter table DEPARTMENT
add column PINCODE int not null default 0;
#q3
Alter table DEPARTMENT
change DNAME DEPT_NAME varchar(20);
#q5
alter table DEPARTMENT
modify LOC char(20);
#q6
Drop table DEPARTMENT;

