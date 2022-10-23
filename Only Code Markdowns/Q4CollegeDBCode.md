# DBMS Lab Question 4 - College DB

## Question

> ### Schema
>
> > STUDENT(USN, SName, Address, Phone, Gender)
> >
> > SEMSEC(SSID, Sem, Sec)
> >
> > CLASS(USN, SSID)
> >
> > COURSE(Subcode, Title, Sem, Credits)
> >
> > IAMARKS(USN, Subcode, SSID, Test1, Test2, Test3, FinalIA)
>
> ### Queries to Execute
>
> > 1. List all the student details studying in fourth semester ‘C’ section.
> >
> > 2. Compute the total number of male and female students in each semester and in each section.
> >
> > 3. Create a view of Test1 marks of student USN ‘1B18CS024’ in all Courses.
> >
> > 4. Calculate the FinalIA (average of best two test marks) and update the corresponding table for all students.
> >
> > 5. Categorize students based on the following criterion:
> >
> > - If FinalIA = 17 to 20 then CAT = ‘Outstanding’
> >
> > - If FinalIA = 12 to 16 then CAT = ‘Average’
> >
> > - If FinalIA< 12 then CAT = ‘Weak’
> >
> >     Give these details only for 8th semester A, B, and C section >>students.

## CODE

**_NOTE: Please follow the order_**

### Create Tables

> Student table
>
> > ```sql
> > CREATE TABLE student(
> >    usn VARCHAR(11) PRIMARY KEY,
> >    sname VARCHAR(20) NOT NULL,
> >    address VARCHAR(20),
> >    phone NUMBER(10),
> >    gender VARCHAR(1)
> > );
> > ```
>
> SEMSEC Table
>
> > ```sql
> > CREATE TABLE semsec(
> >    ssid INT PRIMARY KEY,
> >    sem NUMBER(1),
> >    sec VARCHAR(1)
> > );
> > ```
>
> Class Table
> _(Weak Entity)_
>
> > ```sql
> > CREATE TABLE class(
> >    usn VARCHAR(11) REFERENCES student(usn) ON DELETE CASCADE,
> >    ssid INT REFERENCES semsec(ssid) ON DELETE SET NULL
> > );
> > ```
>
> Course Table
>
> > ```sql
> > CREATE TABLE course(
> >    subcode VARCHAR(10) PRIMARY KEY,
> >    title VARCHAR(20),
> >    sem NUMBER(1),
> >    credits NUMBER(1)
> > );
> > ```
>
> IA Marks table
>
> > ```sql
> > CREATE TABLE iamsarks(
> >    usn VARCHAR(11) REFERENCES student(usn) ON DELETE CASCADE,
> >    subcode VARCHAR(10) REFERENCES course(subcode) ON DELETE CASCADE,
> >    ssid INT REFERENCES semsec(ssid) ON DELETE CASCADE,
> >    test1 INT,
> >    test2 INT,
> >    test3 INT,
> >    finalia NUMBER(5, 2) DEFAULT NULL
> > );
> > ```

### Inserting Data into the tables

**_I have taken sufficient values to run all required queries_**

> Inserting into Student table
>
> > ```sql
> > INSERT ALL
> >    INTO student VALUES('1BY21CS001', 'Krishna', 'Nepal', 7606138048, 'M')
> >    INTO student VALUES('1BY21CS002', 'Isaq', 'Yemen', 5376196505, 'M')
> >    INTO student VALUES('1BY20CS003', 'Arima', 'Japan', 1624938511, 'M')
> >    INTO student VALUES('1BY19CS004', 'Teppei', 'Japan', 4412555191, 'M')
> >    INTO student VALUES('1BY19CS005', 'Ichigo', 'Bleach', 3509858301, 'M')
> >    INTO student VALUES('1BY19CS006', 'Akeno','HSDxD', 7038192726, 'F')
> >    INTO student VALUES('1BY20CS007', 'Inori', 'GC', 9022119172, 'F')
> >    INTO student VALUES('1BY20CS008', 'Anna', 'Shimoneta', 7764985500, 'F')
> >    INTO student VALUES('1BY20CS009', 'Moka', 'Rosairia', 8192565373, 'F')
> >    INTO student VALUES('1BY18CS010', 'Lucy', 'FT', 8423598156, 'F')
> >    INTO student VALUES('1BY18CS011', 'Irohas', 'Oregairu', 4624406899, 'F')
> >    INTO student VALUES('1BY18CS012', 'Oreki', 'Hyoka', 8742964140, 'M')
> >    INTO student VALUES('1BY18CS013', 'Ikki', 'Chivalry', 7055598240, 'M')
> >    INTO student VALUES('1BY20CS014', 'Ann', 'Persona', 0986349283, 'F')
> >    INTO student VALUES('1BY20CS015', 'Hinata', 'Naruto', 9626120042, 'F')
> >    INTO student VALUES('1BY18CS016', 'Albedo', 'Overlord', 5719859234, 'F')
> >    INTO student VALUES('1BY21CS017', 'Lisa', 'Teyvat', 0607159719, 'F')
> >    INTO student VALUES('1BY21CS018', 'Zongli', 'Teyvat', 1162891350, 'M')
> >    INTO student VALUES('1BY20CS019', 'Musubi', 'Sekirei', 2181039716, 'F')
> >    INTO student VALUES('1BY21CS020', 'Mio', 'Shinmai', 7444157251, 'F')
> >    INTO student VALUES('1BY18CS021', 'Asuna', 'SAO', 4568156243, 'F')
> >    INTO student VALUES('1BY18CS022', 'Rimuru', 'Tensura', 1582010837, 'M')
> >    INTO student VALUES('1BY18CS023', 'Momo', 'LoveRu', 9190928749, 'F')
> >    INTO student VALUES('1BY18CS024', 'Arata', 'TSeven', 5228020713, 'M')
> > SELECT * FROM dual;
> > ```
>
> Inserting into semsec table (semester and section)
>
> > ```sql
> > INSERT ALL
> >    INTO employee VALUES(103, 'Layla Scott', 'US', 'F', 600000, 100, NULL) --dept 5
> >    INTO employee VALUES(104, 'Clay Neal', 'UK', 'M', 650000, 100, NULL) --dept 2
> >    INTO employee VALUES(105, 'Aldo Hansen', 'LA', 'M', 700000, 101, NULL) --dept 3
> >    INTO employee VALUES(106, 'Drew Richardson','US', 'M', 750000, 101, NULL) --dept 4
> > SELECT * FROM dual;
> > ```
>
> Inserting departments with manager IDs into department table
>
> **Considered _Even_ Semesters**
>
> > ```sql
> > INSERT ALL
> >    INTO semsec VALUES(1, 2, 'A')
> >    INTO semsec VALUES(2, 2, 'B')
> >    INTO semsec VALUES(3, 2, 'C')
> >    INTO semsec VALUES(4, 4, 'A')
> >    INTO semsec VALUES(5, 4, 'B')
> >    INTO semsec VALUES(6, 4, 'C')
> >    INTO semsec VALUES(7, 6, 'A')
> >    INTO semsec VALUES(8, 6, 'B')
> >    INTO semsec VALUES(9, 6, 'C')
> >    INTO semsec VALUES(10, 8, 'A')
> >    INTO semsec VALUES(11, 8, 'B')
> >    INTO semsec VALUES(12, 8, 'C')
> > SELECT * FROM dual;
> > ```
>
> Insert into class table
>
> _Connecting usn and semsec_
>
> > ```sql
> > INSERT ALL
> >    INTO class VALUES('1BY21CS001', 1)
> >    INTO class VALUES('1BY21CS002', 2)
> >    INTO class VALUES('1BY20CS003', 4)
> >    INTO class VALUES('1BY19CS004', 7)
> >    INTO class VALUES('1BY19CS005', 8)
> >    INTO class VALUES('1BY19CS006', 9)
> >    INTO class VALUES('1BY20CS007', 5)
> >    INTO class VALUES('1BY20CS008', 6)
> >    INTO class VALUES('1BY20CS009', 6)
> >    INTO class VALUES('1BY18CS010', 10)
> >    INTO class VALUES('1BY18CS011', 11)
> >    INTO class VALUES('1BY18CS012', 12)
> >    INTO class VALUES('1BY18CS013', 11)
> >    INTO class VALUES('1BY20CS014', 5)
> >    INTO class VALUES('1BY20CS015', 4)
> >    INTO class VALUES('1BY18CS016', 10)
> >    INTO class VALUES('1BY21CS017', 2)
> >    INTO class VALUES('1BY21CS018', 3)
> >    INTO class VALUES('1BY20CS019', 5)
> >    INTO class VALUES('1BY21CS020', 3)
> >    INTO class VALUES('1BY18CS021', 10)
> >    INTO class VALUES('1BY18CS022', 11)
> >    INTO class VALUES('1BY18CS023', 12)
> >    INTO class VALUES('1BY18CS024', 12)
> > SELECT * FROM dual;
> > ```
>
> Inserting into course table
>
> _Considered 2 subjects per semester_
>
> > ```sql
> > INSERT ALL
> >    INTO course VALUES('18CS21', 'Sub 1', 2, 3)
> >    INTO course VALUES('18CS22', 'Sub 2', 2, 3)
> >    INTO course VALUES('18CS41', 'Sub 3', 4, 3)
> >    INTO course VALUES('18CS42', 'Sub 4', 4, 4)
> >    INTO course VALUES('18CS61', 'Sub 5', 6, 3)
> >    INTO course VALUES('18CS62', 'Sub 6', 6, 4)
> >    INTO course VALUES('18CS81', 'Sub 7', 8, 4)
> >    INTO course VALUES('18CS82', 'Sub 8', 8, 4)
> > SELECT * FROM dual;
> > ```
>
> Insert into iamarks table
>
> _Every student has marks for two subjects in their semester_
>
> > ```sql
> > INSERT ALL
> >    INTO iamarks VALUES('1BY21CS001', '18CS21', 1, 18, 19, 20, NULL)
> >    INTO iamarks VALUES('1BY21CS001', '18CS22', 1, 15, 16, 18, NULL)
> >    INTO iamarks VALUES('1BY21CS002', '18CS21', 2, 14, 15, 14, NULL)
> >    INTO iamarks VALUES('1BY21CS002', '18CS22', 2, 12, 10, 9, NULL)
> >    INTO iamarks VALUES('1BY20CS003', '18CS41', 4, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY20CS003', '18CS42', 4, 19, 18, 20, NULL)
> >    INTO iamarks VALUES('1BY19CS004', '18CS61', 7, 10, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY19CS004', '18CS62', 7, 11, 19, 18, NULL)
> >    INTO iamarks VALUES('1BY19CS005', '18CS61', 8, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY19CS005', '18CS62', 8, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY19CS006', '18CS61', 9, 18, 18, 18, NULL)
> >    INTO iamarks VALUES('1BY19CS006', '18CS62', 9, 16, 18, 13, NULL)
> >    INTO iamarks VALUES('1BY20CS007', '18CS41', 5, 13, 16, 18, NULL)
> >    INTO iamarks VALUES('1BY20CS007', '18CS42', 5, 14, 17, 19, NULL)
> >    INTO iamarks VALUES('1BY20CS008', '18CS41', 6, 12, 13, 18, NULL)
> >    INTO iamarks VALUES('1BY20CS008', '18CS42', 6, 18, 19, 8, NULL)
> >    INTO iamarks VALUES('1BY20CS009', '18CS41', 6, 20, 12, 14, NULL)
> >    INTO iamarks VALUES('1BY20CS009', '18CS42', 6, 12, 20, 16, NULL)
> >    INTO iamarks VALUES('1BY18CS010', '18CS81', 10, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY18CS010', '18CS82', 10, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY18CS011', '18CS81', 11, 18, 18, 18, NULL)
> >    INTO iamarks VALUES('1BY18CS011', '18CS82', 11, 18, 18, 18, NULL)
> >    INTO iamarks VALUES('1BY18CS012', '18CS81', 12, 16, 16, 16, NULL)
> >    INTO iamarks VALUES('1BY18CS012', '18CS82', 12, 16, 16, 16, NULL)
> >    INTO iamarks VALUES('1BY18CS013', '18CS81', 11, 10, 10, 10, NULL)
> >    INTO iamarks VALUES('1BY18CS013', '18CS82', 11, 10, 10, 10, NULL)
> >    INTO iamarks VALUES('1BY20CS014', '18CS41', 5, 12, 8, 7, NULL)
> >    INTO iamarks VALUES('1BY20CS014', '18CS42', 5, 10, 8, 7, NULL)
> >    INTO iamarks VALUES('1BY20CS015', '18CS41', 4, 20, 10, 20, NULL)
> >    INTO iamarks VALUES('1BY20CS015', '18CS42', 4, 20, 15, 20, NULL)
> >    INTO iamarks VALUES('1BY18CS016', '18CS81', 10, 14, 14, 14, NULL)
> >    INTO iamarks VALUES('1BY18CS016', '18CS82', 10, 14, 14, 14, NULL)
> >    INTO iamarks VALUES('1BY21CS017', '18CS21', 2, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY21CS017', '18CS22', 2, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY21CS018', '18CS21', 3, 19, 12, 14, NULL)
> >    INTO iamarks VALUES('1BY21CS018', '18CS22', 3, 20, 10, 17, NULL)
> >    INTO iamarks VALUES('1BY20CS019', '18CS41', 5, 19, 12, 10, NULL)
> >    INTO iamarks VALUES('1BY20CS019', '18CS42', 5, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY21CS020', '18CS21', 3, 12, 14, 16, NULL)
> >    INTO iamarks VALUES('1BY21CS020', '18CS22', 3, 20, 19, 9, NULL)
> >    INTO iamarks VALUES('1BY18CS021', '18CS81', 10, 18, 17, 20, NULL)
> >    INTO iamarks VALUES('1BY18CS021', '18CS82', 10, 18, 17, 20, NULL)
> >    INTO iamarks VALUES('1BY18CS022', '18CS81', 11, 16, 19, 10, NULL)
> >    INTO iamarks VALUES('1BY18CS022', '18CS82', 11, 16, 19, 10, NULL)
> >    INTO iamarks VALUES('1BY18CS023', '18CS81', 12, 18, 13, 18, NULL)
> >    INTO iamarks VALUES('1BY18CS023', '18CS82', 12, 18, 13, 18, NULL)
> >    INTO iamarks VALUES('1BY18CS024', '18CS81', 12, 20, 20, 20, NULL)
> >    INTO iamarks VALUES('1BY18CS024', '18CS81', 12, 20, 20, 20, NULL)
> > SELECT * FROM dual;
> > ```

### Queries(Answers)

> Q1:
>
> > ```sql
> > SELECT *
> >    FROM student
> >    WHERE student.usn IN (
> >        SELECT usn
> >            FROM class
> >            JOIN semsec
> >            ON semsec.ssid = class.ssid
> >            WHERE semsec.sem = 4 AND semsec.sec = 'C'
> >    );
> > ```
>
> Q2:
>
> > ```sql
> > SELECT
> >    COUNT(CASE WHEN student.gender = 'M' THEN 1 END) AS male,
> >    COUNT(CASE WHEN student.gender = 'F' THEN 1 END) as female,
> >    semsec.sem, semsec.sec
> >        FROM student
> >        JOIN class
> >        ON class.usn = student.usn
> >            JOIN semsec
> >            ON semsec.ssid = class.ssid
> >    GROUP BY semsec.sem, semsec.sec
> >    ORDER BY semsec.sem, semsec.sec;
> > ```
>
> Q3:
>
> > ```sql
> > CREATE VIEW test1_marks AS
> > SELECT test1, subcode
> >    FROM iamarks
> >    WHERE iamarks.usn = '1BY18CS024';
> > SELECT * FROM test1_marks;
> > --Run drop only to drop the created view
> > DROP VIEW test1_marks;
> > ```
>
> Q4:
>
> > ```sql
> > UPDATE iamarks
> >    SET finalia = CASE
> >                    WHEN GREATEST(test1, test2) = GREATEST(test2, test3)
> >                        THEN (GREATEST(test1, test2) + GREATEST(test2,test3)) / 2
> >                    ELSE
> >                        (GREATEST(test1, test2) + GREATEST(test3, test2)) / 2
> >                    END;
> > --View all data
> > SELECT * FROM iamarks;
> > ```
>
> Q5:
>
> > ```sql
> > SELECT iamarks.usn, iamarks.subcode, iamarks.finalia, semsec.sec, (
> >    CASE
> >        WHEN finalia BETWEEN 17 AND 20 THEN 'Outstanding'
> >        WHEN finalia BETWEEN 12 AND 16 THEN 'Average'
> >        ELSE 'Weak'
> >    END
> >    ) as category
> >    FROM iamarks
> >        JOIN semsec
> >        ON iamarks.ssid = semsec.ssid
> >    WHERE semsec.sem = 8
> >    ORDER BY sec, iamarks.subcode;
> > ```

**Tested on Oracle DB V19**

**_Note_**:
**_Check for version in ORACLE_**

```sql
SELECT * FROM V$VERSION
```
