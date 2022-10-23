--ALTER TABLE student MODIFY usn VARCHAR(11);
CREATE TABLE student(
    usn VARCHAR(11) PRIMARY KEY,
    sname VARCHAR(20) NOT NULL,
    address VARCHAR(20),
    phone NUMBER(10),
    gender VARCHAR(1)
);

CREATE TABLE semsec(
    ssid INT PRIMARY KEY,
    sem NUMBER(1),
    sec VARCHAR(1)
);

--Weak entity
CREATE TABLE class(
    usn VARCHAR(11) REFERENCES student(usn) ON DELETE CASCADE,
    ssid INT REFERENCES semsec(ssid) ON DELETE SET NULL
);

CREATE TABLE course(
    subcode VARCHAR(10) PRIMARY KEY,
    title VARCHAR(20),
    sem NUMBER(1),
    credits NUMBER(1)
);

--drop table iamarks;
CREATE TABLE iamsarks(
    usn VARCHAR(11) REFERENCES student(usn) ON DELETE CASCADE,
    subcode VARCHAR(10) REFERENCES course(subcode) ON DELETE CASCADE,
    ssid INT REFERENCES semsec(ssid) ON DELETE CASCADE,
    test1 INT,
    test2 INT,
    test3 INT,
    finalia NUMBER(5, 2) DEFAULT NULL
);