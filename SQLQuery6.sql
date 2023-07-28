-- Part 1: Using Ranking Function and CTE
-- 1. Retrieve the rank of each employee based on their salary, with ties given the same rank and no gaps in the ranking. 
-- (Display Emp_Id, Names, Salaries)
SELECT Emp_Id,FirstName,LastName, Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM HR.Employee; 

-- 2. Retrieve the rank of each employee based on their salary, with ties given the same rank and no gaps in the ranking portioned by Department id 
-- (Display Emp_Id, Names, Salaries, Dep_Id)
SELECT Emp_Id, FirstName, LastName, Salary, Dep_Id,
       RANK() OVER (PARTITION BY Dep_Id ORDER BY Salary DESC) AS Rank
FROM HR.Employee; 

-- 3. Retrieve the rank of each employee based on their age, with sequential/Serial rank in the ranking. 
-- (Display Emp_Id, Names, Age)
SELECT Emp_Id,FirstName,LastName, Age,
       ROW_NUMBER() OVER (ORDER BY Age) AS Rank
FROM HR.Employee; 

-- 4. Retrieve the rank of each employee based on their age, with sequential/Serial rank in the ranking portioned by Address 
-- (Display Emp_Id, Names, Age, Address)
SELECT Emp_Id, FirstName,LastName, Age, Address,
       ROW_NUMBER() OVER (PARTITION BY Address ORDER BY Age) AS Rank
FROM HR.Employee; 

-- 5. Retrieve the grouping of each employee based on their department id, into 3 Groups (Display Emp_Id, Names, Dep_Id)
SELECT Emp_Id, FirstName,LastName, Dep_Id,
       NTILE(3) OVER (PARTITION BY Dep_Id ORDER BY Salary DESC) AS GroupNumber
FROM HR.Employee; 

-- 6. From Query(3) Try to delete actual last employee ranked and make sure that table actually affected.
WITH RankedEmployees AS (
    SELECT Emp_Id,FirstName,LastName, Age,
           ROW_NUMBER() OVER (ORDER BY Age) AS Rank
    FROM HR.Employee
)
DELETE FROM RankedEmployees
WHERE Rank = (SELECT MAX(Rank) FROM RankedEmployees);

--Part 2: Using Schema & IF EXISTS
--7. Create a new schema named "HR" if it doesn't already exist, using the "IF NOT EXISTS" keyword to avoid errors if the schema already exists.

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'HR')
BEGIN
    EXEC('CREATE SCHEMA HR');
END

-- 8. Transfer the tables "Student," "Instructor," and "Employee" to the new "HR" schema.
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HR.Student') AND type IN (N'U'))
BEGIN
    ALTER SCHEMA HR TRANSFER dbo.Student;
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HR.Instructor') AND type IN (N'U'))
BEGIN
    ALTER SCHEMA HR TRANSFER dbo.Instructor;
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HR.Employee') AND type IN (N'U'))
BEGIN
    ALTER SCHEMA HR TRANSFER dbo.Employee;
END


-- Part 3: Case, IIF
-- 9. Display Employee data , Genger in case of ‘M’ Display Male , ‘F’ Display Female.
SELECT Emp_Id, FirstName, LastName, Age,
       IIF(Gender = 'M', 'Male','Female') AS Gender
FROM HR.Employee;

-- 10. Using Case Statement to update Instuctor salary data Whithin value salary less than 500  updated it by updated it by  10 %
-- salary Between 500 and 1000  updated it by updated it by  20 % others updated it by 30 %

UPDATE HR.Instructor 
SET Salary = 
    CASE 
        WHEN Salary < 500 THEN Salary * 1.1
        WHEN Salary BETWEEN 500 AND 1000 THEN Salary * 1.2
        ELSE Salary * 1.3
    END;



-- Part 5: Variables, Select Into, Insert Based On Select
-- 11. Declare TempEmp Table Variable with EID , ESalary, FName
DECLARE @TempEmp TABLE (
    EID INT,
    ESalary DECIMAL(10, 2),
    FName VARCHAR(50)
);

-- 12. Insert Data on it From Employee Table
INSERT INTO @TempEmp (EID, ESalary, FName)
SELECT Emp_Id, Salary, FirstName FROM HR.Employee; -- Replace HR.Employee with the actual name of your Employee table

-- 13. Try To Copy Department Table With All (Stucture and Data) With Named New_Department_Data
SELECT *
INTO New_Department_Data
FROM Department; 

-- 14. Try To Copy Department Table With (Structure ONLY) With Named New_Department
SELECT TOP 0 *
INTO New_Department
FROM Department; -- Replace HR.Department with the actual name of your Department table

-- Part 6: Try Date Function
-- Format the current date as 'yyyy-MM-dd'
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd') AS FormattedDate;
-- Format the current date and time as 'MM/dd/yyyy hh:mm:ss tt'
SELECT FORMAT(GETDATE(), 'MM/dd/yyyy hh:mm:ss tt') AS FormattedDateTime;










