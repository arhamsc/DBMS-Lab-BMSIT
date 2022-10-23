--Insert Supervisors
INSERT ALL
    INTO employee VALUES(100, 'Dixy Scott', 'USA', 'M', 1000000, NULL, NULL) -- dept 5
    INTO employee VALUES(101, 'Michael John', 'Canada', 'M', 1050000, NULL, NULL) --manager of dept 1
SELECT * FROM dual;

--Manager insert
INSERT ALL 
    INTO employee VALUES(103, 'Layla Scott', 'US', 'F', 600000, 100, NULL) --dept 5
    INTO employee VALUES(104, 'Clay Neal', 'UK', 'M', 650000, 100, NULL) --dept 2
    INTO employee VALUES(105, 'Aldo Hansen', 'LA', 'M', 700000, 101, NULL) --dept 3 manager
    INTO employee VALUES(106, 'Drew Richardson','US', 'M', 750000, 101, NULL) --dept 4 manager
SELECT * FROM dual;

--INSERT Departments along with manager
INSERT ALL
    INTO department VALUES(1, 'Accounts', 101, '20-Nov-2016')
    INTO department VALUES(2, 'HR', 104, '19-Dec-2017')
    INTO department VALUES(3, 'Food', 105, '05-May-2019')
    INTO department VALUES(4, 'R' || '&' || 'D',106, '10-June-2020')
    INTO department VALUES(5, 'Development', 103, '15-August-2018')
SELECT * FROM dual;

--Modify employyes to link with their departments
UPDATE employee
    SET dno = CASE 
                WHEN ssn = 100 OR ssn = 103 THEN 5
                WHEN ssn = 101 THEN 1
                WHEN ssn = 104 THEN 2
                WHEN ssn = 105 THEN 3
                WHEN ssn = 106 THEN 4
            END
    WHERE ssn IN (100, 101, 103, 104, 105, 106);

--Insert Other Employees
INSERT ALL
    INTO employee VALUES(102, 'Skyla Hodge', 'Russia', 'F', 500000, 100, 2)
    INTO employee VALUES(107, 'Jerimiah Nash', 'US', 'M', 600000, 100, 2)
    INTO employee VALUES(108, 'Zoie Bailey', 'US', 'F', 610000, 101, 2)
    INTO employee VALUES(109, 'Adison Higgins', 'Canada', 'F', 650000, 101, 2)
    INTO employee VALUES(110, 'Craig Daugherty', 'North Carolina', 'M', 300000, 100, 2)
    INTO employee VALUES(111, 'Romeo Stephenson', 'France', 'M', 400000, 101, 1)
    INTO employee VALUES(112, 'Ashtyn Rodgers', 'US', 'M', 500000, 100, 1)
    INTO employee VALUES(113, 'Cyrus Gallegos', 'Germany', 'M', 700000, 101, 3)
    INTO employee VALUES(114, 'Kasey Dunn', 'UK', 'F', 600000, 100, 4)
    INTO employee VALUES(115, 'Ellen Valencia', 'Germany', 'F', 400000, 101, 5)
SELECT * FROM dual;

--Insert into dlocation
INSERT ALL
    INTO dlocation VALUES(1, 'US')
    INTO dlocation VALUES(2, 'UK')
    INTO dlocation VALUES(3, 'Cananda')
    INTO dlocation VALUES(4, 'California')
    INTO dlocation VALUES(5, 'India')
SELECT * FROM dual;

--Insert in projects
INSERT ALL 
    INTO project VALUES(1, 'IoT', 'US', 3)
    INTO project VALUES(2, 'AIML', 'UK', 5)
    INTO project VALUES(3, 'Website', 'INDIA', 5)
    INTO project VALUES(4, 'App', 'India', 4)
    INTO project VALUES(5, 'Dev', 'India', 5)
SELECT * FROM dual;

--Insert in works on -- for Q4 use this table
INSERT ALL
    INTO works_on VALUES(113, 1, 200)
    INTO works_on VALUES(115, 2, 100)
    INTO works_on VALUES(103, 3, 100)
    INTO works_on VALUES(114, 4, 150)
    INTO works_on VALUES(115, 5, 100) -- this guy works on all projects for dept 5
    INTO works_on VALUES(115, 3, 100)
SELECT * FROM dual;

SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM dlocation;
SELECT * FROM project;
SELECT * FROM works_on;