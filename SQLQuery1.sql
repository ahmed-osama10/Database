USE Student_ITI;

CREATE TABLE Department (
    Dep_ID INT PRIMARY KEY,
    Code CHAR(1),
    Name NVARCHAR(20)
);
USE Student_ITI;

CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    MiddleName NVARCHAR(50),
    LastName NVARCHAR(50),
    Dep_ID INT,
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

