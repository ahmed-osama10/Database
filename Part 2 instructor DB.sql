USE Instructors;

-- Create the "Instructor" table
CREATE TABLE Instructor (
    ID INT IDENTITY(1, 1) PRIMARY KEY,
    Address VARCHAR(50) CHECK (Address IN ('cairo', 'alex')),
    Hiredate DATE DEFAULT GETDATE(),
    Salary DECIMAL(10, 2) DEFAULT 3000 CHECK (Salary BETWEEN 1000 AND 5000),
    Overtime DECIMAL(10, 2) UNIQUE,
    Birthdate DATE,
    Firstname VARCHAR(50),
    Lastname VARCHAR(50),
    Age AS (YEAR(GETDATE()) - YEAR(Birthdate)),
    Netsalary AS (Salary + Overtime)
);

-- Create the "course" table
CREATE TABLE course (
    CID INT IDENTITY(1, 1) PRIMARY KEY,
    Cname VARCHAR(100),
    Duration INT UNIQUE CHECK (Duration > 0)
);

-- Create the "Lab" table
CREATE TABLE Lab (
    LID INT IDENTITY(1, 1) PRIMARY KEY,
    Location VARCHAR(100),
    Capacity INT CHECK (Capacity < 20),
    CID INT,
    CONSTRAINT FK_Lab_Course FOREIGN KEY (CID) REFERENCES course(CID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the "teach" table
CREATE TABLE teach (
    ID INT,
    CID INT,
    PRIMARY KEY (ID, CID),
    CONSTRAINT FK_teach_Instructor FOREIGN KEY (ID) REFERENCES instructor(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_teach_Course FOREIGN KEY (CID) REFERENCES course(CID) ON DELETE CASCADE ON UPDATE CASCADE
);
