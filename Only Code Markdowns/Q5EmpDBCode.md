# DBMS Lab Question 5 - Employee DB

## Question

### Schema

> Employee(SSN, Name, Address, Sex, Salary, SuperSSN, DNo)
>
> Department(DNo, DName, MgrSSN, MgrStartDate)
>
> DLocation(DNo,DLoc)
>
> Project(PNo, PName, PLocation, DNo)
>
> Works_On(SSN, PNo, Hours)

### Queries to Execute

> 1. Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’, either as a worker or as a manager of the department that controls the project.
>
> 2. Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percent raise.
>
> 3. Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the maximum salary, the minimum salary, and the average salary in this
>    department.
>
> 4. Retrieve the name of each employee who works on all the projects controlled by department number 5 (use NOT EXISTS operator).
>
> 5. For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than Rs. 6,00,000.

## CODE

**_NOTE: Please follow the order_**

### Create Tables

Employee table

> ```sql
> CREATE TABLE employee(
>   ssn INT PRIMARY KEY,
>   name VARCHAR(20),
>   address VARCHAR(20),
>   sex VARCHAR(1),
>   salary INT,
>   super_ssn INT,
>   dno INT
> );
> ```

Department Table

> ```sql
> CREATE TABLE department(
>    dno INT PRIMARY KEY,
>    dname VARCHAR(20) NOT NULL UNIQUE,
>    mgr_ssn INT REFERENCES employee(ssn)
>      ON DELETE SET NULL,
>    mgr_start_date DATE
> );
> ```

Alter the employee tables to include foreign keys

> ```sql
> ALTER TABLE employee
>    MODIFY(
>    super_ssn INT REFERENCES employee(ssn) ON DELETE SET NULL,
>    dno INT REFERENCES department(dno) ON DELETE SET NULL
> );
> ```

DLocation Table

> ```sql
> CREATE TABLE dlocation(
>    dno INT,
>    dloc VARCHAR(20),
>    FOREIGN KEY(dno) REFERENCES department(dno) ON DELETE CASCADE --without dept there is no loc
> );
> ```

Project Table

> ```sql
> CREATE TABLE project(
>    pno INT,
>    pname VARCHAR(20) NOT NULL,
>    plocation VARCHAR(20),
>    dno INT,
>    PRIMARY KEY(pno),
>    FOREIGN KEY(dno) REFERENCES department(dno) ON DELETE SET NULL
> );
> ```

Works on table

> ```sql
> CREATE TABLE works_on(
>    ssn INT REFERENCES employee(ssn) ON DELETE CASCADE,
>    pno INT REFERENCES project(pno) ON DELETE CASCADE,
>    hours INT,
>    PRIMARY KEY(ssn, pno)
> );
> ```

### Inserting Data into the tables

Inserting supervisors into employee table

> ```sql
> INSERT ALL
>    INTO employee VALUES(100, 'Dixy Scott', 'USA', 'M', 1000000, NULL, NULL)
>    INTO employee VALUES(101, 'Michael John', 'Canada', 'M', 1050000, NULL, NULL)
> SELECT * FROM dual; --will also be manager of dept 1
> ```

Inserting managerial employees into employee table

> ```sql
> INSERT ALL
>    INTO employee VALUES(103, 'Layla Scott', 'US', 'F', 600000, 100, NULL) --dept 5
>    INTO employee VALUES(104, 'Clay Neal', 'UK', 'M', 650000, 100, NULL) --dept 2
>    INTO employee VALUES(105, 'Aldo Hansen', 'LA', 'M', 700000, 101, NULL) --dept 3
>    INTO employee VALUES(106, 'Drew Richardson','US', 'M', 750000, 101, NULL) --dept 4
> SELECT * FROM dual;
> ```

Inserting departments with manager IDs into department table

> ```sql
> INSERT ALL
>    INTO employee VALUES(103, 'Layla Scott', 'US', 'F', 600000, 100, NULL) --dept 5
>    INTO employee VALUES(104, 'Clay Neal', 'UK', 'M', 650000, 100, NULL) --dept 2
>    INTO employee VALUES(105, 'Aldo Hansen', 'LA', 'M', 700000, 101, NULL) --dept 3 manager
>    INTO employee VALUES(106, 'Drew Richardson','US', 'M', 750000, 101, NULL) --dept 4 manager
> SELECT * FROM dual;
> ```

Update the managerial and supervisor employees with dept IDs

> ```sql
> UPDATE employee
>    SET dno = CASE
>                WHEN ssn = 100 OR ssn = 103 THEN 5
>                WHEN ssn = 101 THEN 1
>                WHEN ssn = 104 THEN 2
>                WHEN ssn = 105 THEN 3
>                WHEN ssn = 106 THEN 4
>            END
>    WHERE ssn IN (100, 101, 103, 104, 105, 106);
> ```

Inserting other employees into the table

> ```sql
> INSERT ALL
>    INTO employee VALUES(102, 'Skyla Hodge', 'Russia', 'F', 500000, 100, 2)
>    INTO employee VALUES(107, 'Jerimiah Nash', 'US', 'M', 600000, 100, 2)
>    INTO employee VALUES(108, 'Zoie Bailey', 'US', 'F', 610000, 101, 2)
>    INTO employee VALUES(109, 'Adison Higgins', 'Canada', 'F', 650000, 101, 2)
>    INTO employee VALUES(110, 'Craig Daugherty', 'North Carolina', 'M', 300000, 100, 2)
>    INTO employee VALUES(111, 'Romeo Stephenson', 'France', 'M', 400000, 101, 1)
>    INTO employee VALUES(112, 'Ashtyn Rodgers', 'US', 'M', 500000, 100, 1)
>    INTO employee VALUES(113, 'Cyrus Gallegos', 'Germany', 'M', 700000, 101, 3)
>    INTO employee VALUES(114, 'Kasey Dunn', 'UK', 'F', 600000, 100, 4)
>    INTO employee VALUES(115, 'Ellen Valencia', 'Germany', 'F', 400000, 101, 5)
> SELECT * FROM dual;
> ```

Insert dept location into dlocation table

> ```sql
> INSERT ALL
>    INTO dlocation VALUES(1, 'US')
>    INTO dlocation VALUES(2, 'UK')
>    INTO dlocation VALUES(3, 'Canada')
>    INTO dlocation VALUES(4, 'California')
>    INTO dlocation VALUES(5, 'India')
> SELECT * FROM dual;
> ```

Insert projects into project tables

> ```sql
> INSERT ALL
>    INTO project VALUES(1, 'IoT', 'US', 3)
>    INTO project VALUES(2, 'AIML', 'UK', 5)
>    INTO project VALUES(3, 'Website', 'INDIA', 5)
>    INTO project VALUES(4, 'App', 'India', 4)
>    INTO project VALUES(5, 'Dev', 'India', 5)
> SELECT * FROM dual;
> ```

Insert into works-on table

> ```sql
> INSERT ALL
>    INTO works_on VALUES(113, 1, 200)
>    INTO works_on VALUES(115, 2, 100)
>    INTO works_on VALUES(103, 3, 100)
>    INTO works_on VALUES(114, 4, 150)
>    INTO works_on VALUES(115, 5, 100) -- this guy works on all projects for dept 5
>    INTO works_on VALUES(115, 3, 100)
> SELECT * FROM dual;
> ```

Check for inserted values

> ```sql
> SELECT * FROM employee;
> SELECT * FROM department;
> SELECT * FROM dlocation;
> SELECT * FROM project;
> SELECT * FROM works_on;
> ```

### Queries(Answers)

Q1:

> ```sql
> SELECT DISTINCT project.pno
>    FROM project
>       JOIN employee
>       ON project.dno = employee.dno
>           WHERE name LIKE '% Scott';
> ```

Q2:

> ```sql
> SELECT name, salary AS before_sal, (salary*1.1) as after_sal
>    FROM employee
>    WHERE ssn IN (
>        SELECT ssn
>        FROM works_on
>            JOIN project
>            ON works_on.pno = project.pno
>            WHERE project.pname = 'IoT'
>    );
> ```

Q3:
_(Included 2 methods)_

> Method 1 - With Nested query
>
> > ```sql
> > SELECT SUM(salary) AS sal_sum, MAX(salary) AS max_sal, MIN(salary) AS min_sal, AVG(salary) AS avg_sal
> >    FROM employee
> >    WHERE dno IN (
> >        SELECT dno
> >            FROM department
> >            WHERE department.dname = 'Accounts'
> >    );
> > ```
>
> Method 2 - With JOIN
>
> > ```sql
> > SELECT SUM(salary) AS sal_sum, MAX(salary) AS max_sal, MIN(salary) AS min_sal, AVG(salary) AS avg_sal
> >    FROM employee
> >        JOIN department
> >        ON employee.dno = department.dno
> >            WHERE dname = 'Accounts';
> > ```

Q4:

> ```sql
> SELECT *
>    FROM employee
>    WHERE NOT EXISTS (
>        SELECT project.pno FROM project
>        WHERE
>            project.dno = 5
>            AND
>            project.pno NOT IN
>                (SELECT pno FROM works_on WHERE employee.ssn = works_on.ssn)
>
>    );
> ```

Q5:

> ```sql
> SELECT *
>    FROM employee
>    WHERE
>        dno IN(
>            SELECT dno -- returns maximum employee department
>            FROM employee
>                GROUP BY dno
>                ORDER BY COUNT(dno) DESC
>                FETCH NEXT 1 ROW ONLY --return only first row(max number)
>            )
>        AND
>        salary > 600000;
> ```

**_Note_**:
**_Check for version in ORACLE_**

```sql
SELECT * FROM V$VERSION
```
