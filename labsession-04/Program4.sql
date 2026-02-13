CREATE DATABASE Company;

USE Company;

CREATE TABLE EMPLOYEE (
    Fname VARCHAR(10) NOT NULL,
    Lname VARCHAR(10) NOT NULL,
    SSN VARCHAR(10) NOT NULL,
    DOB DATE,
    Address VARCHAR(30),
    Sex ENUM('Male','Female'),
    Salary DECIMAL(10,2),
    Super_ssn VARCHAR(10),
    Dnumber VARCHAR(10),
    PRIMARY KEY (SSN),
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(SSN)
);

CREATE TABLE DEPARTMENT (Dname VARCHAR(10) NOT NULL, Dnumber VARCHAR(10) NOT NULL, Mgr_ssn VARCHAR(10), Mgr_start_date DATE, PRIMARY KEY (Dnumber), UNIQUE (Dname), FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(SSN));

CREATE TABLE DEPT_LOCATIONS (Dnumber VARCHAR(10) NOT NULL, Dlocation VARCHAR(10) NOT NULL, PRIMARY KEY (Dnumber, Dlocation), FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber));

CREATE TABLE PROJECT (
    Pname VARCHAR(10) NOT NULL,
    Pnumber VARCHAR(10) NOT NULL,
    Plocation VARCHAR(10),
    Dnumber VARCHAR(10) NOT NULL,
    Cost DECIMAL(12,2),
    Start_Date DATE,
    End_Date DATE,
    PRIMARY KEY (Pnumber),
    UNIQUE (Pname),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE WORKS_ON (Essn VARCHAR(10) NOT NULL, Pno VARCHAR(10) NOT NULL, Hours DECIMAL(3,1), PRIMARY KEY (Essn, Pno), FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn), FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber));

CREATE TABLE DEPENDENT (Essn VARCHAR(10) NOT NULL, Dependent_name VARCHAR(10) NOT NULL, Sex enum('Male', 'Female'), DOB DATE, Relationship VARCHAR(10), PRIMARY KEY (Essn, Dependent_name), FOREIGN KEY (Essn) REFERENCES EMPLOYEE(SSN));

INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES
('Finance', 'D100', NULL, NULL),
('R&D', 'D200', NULL, NULL),
('Marketing', 'D300', NULL, NULL),
('Operations', 'D400', NULL, NULL);

INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES
-- Finance Department Employees
('Yaswanth', 'Gudivada', 'E100', '1985-05-15', 'MG Road, Bengaluru', 'Male', 75000.00, NULL, 'D100'),
('Jatin', 'Bansal', 'E101', '1988-08-20', 'Anna Nagar, Chennai', 'Male', 55000.00, 'E100', 'D100'),
('Siri', 'E', 'E103', '1992-11-08', 'Connaught Place, Delhi', 'Female', 42000.00, 'E100', 'D100'),
('Harshini', 'Gunturi', 'E102', '1990-03-12', 'Bandra, Mumbai', 'Female', 48000.00, 'E100', 'D100');

-- -- R&D Department Employees
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Mahesh', 'Babu', 'E200', '1983-01-25', 'Koramangala, Bengaluru', 'Male', 95000.00, NULL, 'D200');
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Suresh', 'Nair', 'E201', '1987-06-30', 'T Nagar, Chennai', 'Male', 68000.00, 'E200', 'D200');
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Kavya', 'Menon', 'E202', '1991-09-14', 'Andheri, Mumbai', 'Female', 62000.00, 'E200', 'D200');
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Arjun', 'Singh', 'E203', '1989-04-22', 'Rohini, Delhi', 'Male', 58000.00, 'E200', 'D200');
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Deepak', 'Rao', 'E204', '1993-12-05', 'Whitefield, Bengaluru', 'Male', 52000.00, 'E200', 'D200');

-- Marketing Department Employees
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Anand', 'Verma', 'E300', '1984-07-18', 'Jayanagar, Bengaluru', 'Male', 72000.00, NULL, 'D300');
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Sneha', 'Iyer', 'E301', '1990-02-28', 'Velachery, Chennai', 'Female', 54000.00, 'E300', 'D300');
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Kiran', 'Desai', 'E302', '1992-10-10', 'Powai, Mumbai', 'Male', 49000.00, 'E300', 'D300');

-- Operations Department Employees
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Vikram', 'Joshi', 'E400', '1986-03-05', 'Indiranagar, Bengaluru', 'Male', 68000.00, NULL, 'D400');
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Pooja', 'Gupta', 'E401', '1991-08-16', 'Adyar, Chennai', 'Female', 51000.00, 'E400', 'D400');
INSERT INTO EMPLOYEE (Fname, Lname, SSN, DOB, Address, Sex, Salary, Super_ssn, Dnumber) VALUES ('Rajesh', 'Pillai', 'E402', '1988-12-20', 'Juhu, Mumbai', 'Male', 56000.00, 'E400', 'D400');

-- Update DEPARTMENT with managers
UPDATE DEPARTMENT SET Mgr_ssn = 'E100', Mgr_start_date = '2020-01-15' WHERE Dnumber = 'D100';
UPDATE DEPARTMENT SET Mgr_ssn = 'E200', Mgr_start_date = '2019-03-20' WHERE Dnumber = 'D200';
UPDATE DEPARTMENT SET Mgr_ssn = 'E300', Mgr_start_date = '2020-06-10' WHERE Dnumber = 'D300';
UPDATE DEPARTMENT SET Mgr_ssn = 'E400', Mgr_start_date = '2021-02-01' WHERE Dnumber = 'D400';

-- Insert DEPT_LOCATIONS
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES
('D100', 'Bengaluru'),
('D100', 'Mumbai'),
('D200', 'Bengaluru'),
('D200', 'Chennai'),
('D200', 'Delhi'),
('D300', 'Mumbai'),
('D300', 'Delhi'),
('D400', 'Chennai');

-- Insert PROJECTS
-- Finance Department Projects
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('FinApp', 'P100', 'Bengaluru', 'D100', 350000.00, '2024-01-10', '2024-12-31');
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('BudgetPro', 'P101', 'Mumbai', 'D100', 280000.00, '2025-06-01', NULL);

-- R&D Department Projects (multiple ongoing, some in multiple cities)
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('InnoTech', 'P200', 'Bengaluru', 'D200', 450000.00, '2024-03-15', NULL);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('SmartSol', 'P201', 'Chennai', 'D200', 380000.00, '2024-08-20', NULL);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('FuturePro', 'P202', 'Delhi', 'D200', 420000.00, '2025-01-05', NULL);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('ResearchX', 'P203', 'Bengaluru', 'D200', 320000.00, '2023-05-10', '2024-10-30');

-- Marketing Department Projects
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('BrandBoost', 'P300', 'Mumbai', 'D300', 290000.00, '2024-11-01', NULL);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('MarketPro', 'P301', 'Delhi', 'D300', 340000.00, '2025-02-15', NULL);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('AdCamp', 'P302', 'Mumbai', 'D300', 180000.00, '2023-09-01', '2024-08-31');

-- Operations Department Projects
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('OptiOps', 'P400', 'Chennai', 'D400', 410000.00, '2024-04-20', NULL);
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnumber, Cost, Start_Date, End_Date) VALUES ('LogisticX', 'P401', 'Bengaluru', 'D400', 360000.00, '2023-07-15', '2024-11-20');

-- Insert WORKS_ON (employees working on projects)
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES
-- Finance employees on Finance projects
('E100', 'P100', 35.5),
('E101', 'P100', 30.0),
('E102', 'P101', 32.5),
('E103', 'P101', 28.0),

-- R&D employees on R&D projects (E201, E202, E203 work on multiple projects)
('E200', 'P200', 40.0),
('E201', 'P200', 35.0),
('E201', 'P201', 30.0),
('E201', 'P202', 28.0),  
('E202', 'P200', 32.0),
('E202', 'P201', 30.0),
('E202', 'P202', 25.0),  
('E203', 'P201', 35.0),
('E203', 'P202', 30.0),
('E203', 'P203', 28.0),  
('E204', 'P203', 32.0),
('E201', 'P203', 25.0),
('E202', 'P203', 22.0),

-- Marketing employees
('E300', 'P300', 36.0),
('E301', 'P301', 32.0),
('E302', 'P302', 30.0),

-- Operations employees
('E400', 'P400', 38.0),
('E401', 'P400', 33.0),
('E402', 'P401', 31.0);

-- Insert DEPENDENTS
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, DOB, Relationship) VALUES
-- Dependents for employees who completed projects worth 10L+
-- E201 worked on P200, P201, P202 (450K + 380K + 420K = 1.25M = 12.5L)
('E201', 'Aarav', 'Male', '2015-06-10', 'Son'),
('E201', 'Diya', 'Female', '2018-03-25', 'Daughter'),

-- E202 worked on P200, P201, P202 (same total = 12.5L)
('E202', 'Ishaan', 'Male', '2016-09-12', 'Son'),

-- E203 worked on P201, P202, P203 (380K + 420K + 320K = 1.12M = 11.2L)
('E203', 'Myra', 'Female', '2017-02-18', 'Daughter'),

-- Other dependents
('E100', 'Rashmika', 'Female', '2014-11-20', 'Wife'),
('E200', 'Rohan', 'Male', '2013-08-15', 'Son'),
('E300', 'Siya', 'Female', '2016-05-30', 'Daughter'),
('E400', 'Vihaan', 'Male', '2015-12-08', 'Son');

-- Query 1: List the f_Name, L_Name, dept_Name of the employee who draws a salary greater than the average salary of employees working for Finance department.
-- Average Finance salary = (75000 + 55000 + 48000 + 42000) / 4 = 55000

SELECT Fname, Lname, 
       (SELECT Dname FROM DEPARTMENT WHERE Dnumber = E.Dnumber) AS dept_Name
FROM EMPLOYEE E
WHERE Salary > (
    SELECT AVG(Salary) 
    FROM EMPLOYEE 
    WHERE Dnumber = (SELECT Dnumber FROM DEPARTMENT WHERE Dname = 'Finance')
);

-- Query 2: List the name and department of the employee who is currently working on more than two projects controlled by R&D department.

SELECT Fname, Lname,
       (SELECT Dname FROM DEPARTMENT WHERE Dnumber = E.Dnumber) AS dept_Name
FROM EMPLOYEE E
WHERE (
    SELECT COUNT(*) 
    FROM WORKS_ON W
    WHERE W.Essn = E.SSN 
    AND W.Pno IN (
        SELECT Pnumber 
        FROM PROJECT 
        WHERE Dnumber = (SELECT Dnumber FROM DEPARTMENT WHERE Dname = 'R&D')
    )
) > 2;

-- Query 3: List all the ongoing projects controlled by all the departments.

SELECT Pname, Pnumber, Plocation,
       (SELECT Dname FROM DEPARTMENT WHERE Dnumber = P.Dnumber) AS dept_Name
FROM PROJECT P
WHERE End_Date IS NULL OR End_Date > CURDATE();

-- Query 4: Give the details of the supervisor who is supervising more than 3 employees who have completed at least one project.

SELECT Fname, Lname, SSN, DOB, Address, Sex, Salary, 
       (SELECT Dname FROM DEPARTMENT WHERE Dnumber = E.Dnumber) AS dept_Name
FROM EMPLOYEE E
WHERE (
    SELECT COUNT(DISTINCT E2.SSN)
    FROM EMPLOYEE E2
    WHERE E2.Super_ssn = E.SSN
    AND EXISTS (
        SELECT 1 
        FROM WORKS_ON W
        WHERE W.Essn = E2.SSN
        AND W.Pno IN (
            SELECT Pnumber 
            FROM PROJECT 
            WHERE End_Date IS NOT NULL AND End_Date < CURDATE()
        )
    )
) > 3;

-- Query 5: List the name of the dependents of employee who has completed total projects worth 10L.

SELECT Dependent_name, Sex, DOB, Relationship,
       (SELECT Fname FROM EMPLOYEE WHERE SSN = D.Essn) AS Emp_Fname,
       (SELECT Lname FROM EMPLOYEE WHERE SSN = D.Essn) AS Emp_Lname
FROM DEPENDENT D
WHERE Essn IN (
    SELECT E.SSN
    FROM EMPLOYEE E
    WHERE (
        SELECT SUM(P.Cost)
        FROM WORKS_ON W, PROJECT P
        WHERE W.Essn = E.SSN
        AND W.Pno = P.Pnumber
    ) >= 1000000
);

-- Query 6: List the department and employee details whose project is in more than one city.

SELECT DISTINCT E.Fname, E.Lname, E.SSN, E.Salary,
       (SELECT Dname FROM DEPARTMENT WHERE Dnumber = E.Dnumber) AS dept_Name
FROM EMPLOYEE E
WHERE E.Dnumber IN (
    SELECT Dnumber
    FROM PROJECT
    GROUP BY Dnumber
    HAVING COUNT(DISTINCT Plocation) > 1
);