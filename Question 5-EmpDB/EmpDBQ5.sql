
CREATE TABLE employee(
    ssn INT PRIMARY KEY,
    name VARCHAR(20),
    address VARCHAR(20),
    sex VARCHAR(1),
    salary INT,
    super_ssn INT,
    dno INT
);

--REMEmber DEFAULT ' '

CREATE TABLE department(
    dno INT PRIMARY KEY,
    dname VARCHAR(20) NOT NULL UNIQUE,
    mgr_ssn INT REFERENCES employee(ssn) ON DELETE SET NULL,
    mgr_start_date DATE
);

--Alter to hook up the foreign keys
ALTER TABLE employee
    MODIFY (super_ssn INT REFERENCES employee(ssn) ON DELETE SET NULL,
            dno INT REFERENCES department(dno) ON DELETE SET NULL);
            
CREATE TABLE dlocation(
    dno INT,
    dloc VARCHAR(20),
    FOREIGN KEY(dno) REFERENCES department(dno) ON DELETE CASCADE --without dept there is no loc
);

CREATE TABLE project(
    pno INT,
    pname VARCHAR(20) NOT NULL,
    plocation VARCHAR(20),
    dno INT,
    PRIMARY KEY(pno),
    FOREIGN KEY(dno) REFERENCES department(dno) ON DELETE SET NULL
);

CREATE TABLE works_on(
    ssn INT REFERENCES employee(ssn) ON DELETE CASCADE,
    pno INT REFERENCES project(pno) ON DELETE CASCADE,
    hours INT,
    PRIMARY KEY(ssn, pno)
);


--SELECT * FROM V$VERSION --check version