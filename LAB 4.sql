-- Part 1: Using Aggregate Functions
-- 1. List the course name and average Hour_Rate for each course, but only if Hour_Rate is not NULL.
SELECT Crs_Name, AVG(HourRate) AS average_hour_rate
FROM Course
JOIN Instructor_Course ON Course.Crs_Id = Instructor_Course.Crs_Id
WHERE HourRate IS NOT NULL
GROUP BY Crs_Name;


-- 2. Retrieve the department name, maximum, minimum, and average salary of its employees, and the number of employees in each department.
SELECT Dep_Name, MAX(Salary) AS max_salary, MIN(Salary) AS min_salary, 
       AVG(Salary) AS avg_salary, COUNT(*) AS num_employees
FROM Department
JOIN Employee ON Department.Dep_Id = Employee.Dep_Id
GROUP BY Dep_Name;


-- 3. Retrieve the total salaries for employees over 50 years old in a department, but only if the total salaries exceed 3,500.
SELECT Dep_Name, SUM(Salary) AS total_salaries
FROM Employee
JOIN Department ON Employee.Dep_Id = Department.Dep_Id
WHERE age > 50
GROUP BY Dep_Name
HAVING SUM(Salary) > 3500;


-- Part 2: Using Subqueries
-- 4. Display all employee data if their salary is less than the average salary of all employees.
SELECT *
FROM Employee
WHERE salary < (SELECT AVG(salary) FROM Employee);

-- 5. Display employee addresses where the average salary for that address is less than the average salary for all employees. 
SELECT address
FROM Employee
GROUP BY address
HAVING AVG(salary) < (SELECT AVG(salary) FROM Employee);

-- Part 3: Using Transaction 
-- 6. Insert employees’ data with valid and invalid department IDs, and handle any errors that occur during the transaction. 
-- The data should be logged in the Employee Table, and all errors should be displayed.
BEGIN TRANSACTION;

BEGIN TRY
    -- Insert employees' data with valid and invalid department IDs
    INSERT INTO Employee (FirstName, Dep_ID, salary)
    VALUES ('John', 5, 45000),
           ('Jane', 2, 55000),
           ('InvalidEm', 999, 48000); -- Invalid department_id

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

SELECT * 
FROM Employee;

-- Part 4: Using Union Operations
-- 7. Combine salary data for employees and instructors over 25 years old using 
-- a. Union, 
-- b. Union All, 
-- c. Intersect, 
-- d. and except.

-- a. Union The UNION operator selects only distinct values by default.
SELECT Emp_ID, FirstName, age, salary FROM Employee WHERE age > 25
UNION
SELECT Ins_ID, FirstName, age, salary FROM Instructor WHERE age > 25;

-- b. Union All To allow duplicate values
SELECT Emp_ID, FirstName, age, salary FROM Employee WHERE age > 25
UNION ALL
SELECT Ins_ID, FirstName, age, salary FROM Instructor WHERE age > 25;

-- c. Intersect (This will give records that exist in both tables with age > 25)
SELECT Emp_ID, FirstName, age, salary FROM Employee WHERE age > 25
INTERSECT
SELECT Ins_ID, FirstName, age, salary FROM Instructor WHERE age > 25;

-- d. Except (This will give records from employees that are not present in instructors with age > 25)
SELECT Emp_ID, FirstName, age, salary FROM Employee WHERE age > 25
EXCEPT
SELECT Ins_ID, FirstName, age, salary FROM Instructor WHERE age > 25;

-- Part 5: Using Built-in Functions and Global Variables
-- 8. Use at least 5 SQL built-in functions or global variables, such as CONCAT(), GETDATE(), LEN(), @@VERSION, and SUBSTRING(), 
-- and describe their functionality.

-- 1. CONCAT(): Concatenates two or more strings into a single string.
SELECT CONCAT(FirstName, ' ', LastName) AS full_name FROM Employee;

-- 2. GETDATE(): Returns the current date and time from the system.
SELECT GETDATE() AS current_datetime;

-- 3. LEN(): Returns the length (number of characters) of a string.
SELECT LEN(FirstName) AS first_name_length FROM Employee;

-- 4. @@VERSION: Returns the version and edition information of the SQL Server.
SELECT @@VERSION AS sql_server_version;

-- 5. SUBSTRING(): Extracts a substring from a string based on the starting position and length.
SELECT SUBSTRING(Crs_Name, 1, 3) AS short_course_name FROM Course;


-- Part 6: Bonus
-- 9. Display the employee payslip by combining the salary, bonus, and HourRate columns 
-- from the Bonus table into a single column called "EmployeePayslip".

SELECT Salary, Bouns, HourRate
FROM Bouns;

SELECT 
  CASE 
    WHEN Salary IS NOT NULL THEN CONCAT(Salary, ' NULL NULL')
    WHEN Bouns IS NOT NULL THEN CONCAT('NULL ', Bouns, ' NULL')
    WHEN HourRate IS NOT NULL THEN CONCAT('NULL NULL ', HourRate)
  END AS EmployeePayslip
FROM Bouns;

SELECT 
  SUM(COALESCE(Salary, Bouns, HourRate)) AS Result
FROM Bouns;




