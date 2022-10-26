/*
 1. Make a list of all project numbers for projects that involve an employee whose 
last name is ‘Scott’, either as a worker or as a manager of the department 
that controls the project.
*/
    
SELECT DISTINCT project.pno 
    FROM project
        JOIN employee
        ON project.dno = employee.dno
            WHERE name LIKE '% Scott';
   
/*
 2. Show the resulting salaries if every employee working on the ‘IoT’ project is
given a 10 percent raise.
*/
SELECT name, salary AS before_sal, (salary*1.1) as after_sal 
    FROM employee
    WHERE ssn IN (
        SELECT ssn 
        FROM works_on
            JOIN project
            ON works_on.pno = project.pno
            WHERE project.pname = 'IoT'
    );

/*
 3. Find the sum of the salaries of all employees of the ‘Accounts’ department, as
well as the maximum salary, the minimum salary, and the average salary in this
department
*/

--Can use joins also
SELECT SUM(salary) AS sal_sum, MAX(salary) AS max_sal, MIN(salary) AS min_sal, AVG(salary) AS avg_sal
    FROM employee
    WHERE dno IN (
        SELECT dno 
            FROM department
            WHERE department.dname = 'Accounts'
    );
    -----OR------
SELECT SUM(salary) AS sal_sum, MAX(salary) AS max_sal, MIN(salary) AS min_sal, AVG(salary) AS avg_sal
    FROM employee
        JOIN department
        ON employee.dno = department.dno
            WHERE dname = 'Accounts';
            
/*
 4. Retrieve the name of each employee who works on all the projects controlledby
department number 5 (use NOT EXISTS operator)

NOT EXISTS returns TRUE if the result of the subquery does not contain any rows.
In case a single record in a table matches the subquery, 
the NOT EXISTS returns FALSE, and the execution of the subquery is stopped. 

EXISTS and NOT Exists are used in correlated nested queries.
*/

SELECT *
    FROM employee
    WHERE NOT EXISTS (
        SELECT project.pno FROM project 
        WHERE 
            project.dno = 5 
            AND 
            project.pno NOT IN
                (SELECT pno FROM works_on WHERE employee.ssn = works_on.ssn)
        
    );

/*
 5. For each department that has more than five employees, retrieve the department
number and the number of its employees who are making more than Rs. 6,00,000
*/ 

SELECT dno, COUNT(dno)
    FROM employee
    WHERE 
        dno IN(
            SELECT dno -- returns maximum employee department
            FROM employee
                GROUP BY dno
                ORDER BY COUNT(dno) DESC
                FETCH NEXT 1 ROW ONLY --return only first row(max number)
            )
        AND
        salary > 600000
    GROUP BY dno;
