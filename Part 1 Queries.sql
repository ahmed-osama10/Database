-- Display the Department id, name, and id, and the first name of its manager.
SELECT d.Dep_ID, d.Dep_Name , m.Emp_ID , m.FirstName 
FROM Department d
INNER JOIN Employee m ON d.ManagerId = m.Emp_ID;

-- Retrieve a list of all courses along with their corresponding topics, displaying the course name and topic name for each record.
SELECT c.Crs_Name, t.Topic_Name
FROM Course c
INNER JOIN Topic t ON c.Crs_ID = t.Crs_ID;

-- Display the full data about all the dependence associated with the name (first, last) as "EmployeeFullName" of the employee they depend on him/her.
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeFullName, d.*
FROM Dependant d
INNER JOIN Employee e ON d.Emp_ID = e.Emp_ID;

-- Display the Id, name, and address of the employees in Cairo or Alex city.
SELECT Emp_ID, FirstName, LastName, Address
FROM Employee
WHERE Address IN ('Cairo', 'Alex');

-- Display the employees' full data with a name that starts with the letter "a."
SELECT *
FROM Employee
WHERE FirstName LIKE 'a%';

-- Display all the employees in department 1 whose salary is between 1000 to 5000 LE monthly (using AND).
SELECT *
FROM Employee
WHERE Dep_ID = 1 AND Salary BETWEEN 1000 AND 5000;

-- Retrieve the Ids, first and last names of all students who have a grade greater than or equal to 80 and a course duration greater than or equal to 80.
SELECT s.St_ID, s.FirstName, s.LastName
FROM Student s
INNER JOIN Student_Course sc ON s.St_ID = sc.St_ID
INNER JOIN Course c ON sc.Crs_ID = c.Crs_ID
WHERE sc.Grade >= 20 AND c.Duration >= 20;

-- Find the names (first, middle, last) of the students who directly supervised with Noha Mohamed.
SELECT s.FirstName, s.MiddleName, s.LastName
FROM Student s
INNER JOIN Student s_supervisor ON s.Supervisor_ID = s_supervisor.St_ID
INNER JOIN Student noha ON s_supervisor.Supervisor_ID = noha.St_ID
WHERE noha.FirstName = 'noha' AND noha.LastName = 'Mohamed';

Select * FROM Instructor_Course

-- Retrieve the names (first, middle, last), hour rate, and EvolutionGrade of all instructors and the names of the courses they are teaching, sorted by the course name
SELECT i.FirstName, i.MiddleName, i.LastName, i.HourRate, ic.EvoultionGrade
FROM Instructor i
LEFT JOIN Instructor_Course ic ON i.Ins_ID = ic.Ins_ID
ORDER BY i.FirstName, i.MiddleName, i.LastName;

-- Retrieve a list of all employees, including those who are assigned to a department and those who are not. 
SELECT e.FirstName, e.MiddleName, e.LastName, e.Dep_ID, d.Dep_Name 
FROM Employee e
LEFT JOIN Department d ON e.Dep_ID = d.Dep_ID;

-- Display All Data of the managers and direct employees
SELECT m.*, e.*
FROM Employee m
LEFT JOIN Employee e ON m.Emp_ID = e.Manager_ID
ORDER BY m.Emp_ID, e.Emp_ID;

-- Display All Employees data and the data of their dependents even if they have no dependents 
SELECT e.*, d.*
FROM Employee e
LEFT JOIN Dependant d ON e.Emp_ID = d.Emp_ID;

-- Insert your personal data to the employee table as a new employee in department number 10, SSN = 1000, manager id = 1, salary=3000.
INSERT INTO Employee (FirstName, LastName, Dep_ID, SSN, Manager_ID, Salary)
VALUES ('Ahmed', 'Osama', 10, 1000, 1, 3000);

-- Insert another employee with personal data your friend as new employee in department number 10, SSN = 1010, but don’t enter any value for salary or supervisor number to him.
INSERT INTO Employee (FirstName, LastName, Dep_ID, SSN)
VALUES ('Ahmed', 'Abdellatef', 10, 1010);

-- Upgrade your salary by 20 % of its last value.
UPDATE Employee
SET Salary = Salary * 1.2
WHERE FirstName = 'Ahmed' AND LastName = 'Osama';






