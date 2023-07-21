SELECT * FROM Employee;

SELECT FirstName, LastName, Salary, Dep_ID FROM Employee;

SELECT d.Dep_ID, d.Dep_Name AS DepartmentName
FROM Department d
JOIN Employee e ON d.Dep_ID = e.Dep_ID
WHERE e.Manager_ID = 1;


SELECT Emp_ID, FirstName, Salary
FROM Employee
WHERE Dep_ID = 1;

SELECT 
    FirstName + ' ' + MiddleName + ' ' + LastName AS FullName,
    Salary * 0.1 AS ANNUAL_COMM
FROM Employee;

SELECT d.Dep_Name AS DepartmentName, d.IsActiveDep, e.Manager_ID AS ResponsibleEmployee
FROM Department d
LEFT JOIN Employee e ON d.Dep_ID = e.Dep_ID;

SELECT Emp_ID, SSN, FirstName
FROM Employee
WHERE Salary > 10000 / 12; 

SELECT Emp_ID, SSN, FirstName
FROM Employee
WHERE Salary > 1000;

SELECT 
   ( FirstName + ' ' +
    MiddleName + ' ' +
    LastName ) AS StudentFullName,
    Salary
FROM Employee
WHERE Gender = 'F'; 


