/*
1. List all the student details studying in fourth semester ‘C’ section.
*/
SELECT * 
    FROM student
    WHERE student.usn IN (
        SELECT usn
            FROM class
            JOIN semsec
            ON semsec.ssid = class.ssid
            WHERE semsec.sem = 4 AND semsec.sec = 'C'
    );

/*
2. Compute the total number of male and female students in each semester and in
each section.
*/

SELECT 
    COUNT(CASE WHEN student.gender = 'M' THEN 1 END) AS male, 
    COUNT(CASE WHEN student.gender = 'F' THEN 1 END) as female, 
    semsec.sem, semsec.sec
        FROM student
        JOIN class
        ON class.usn = student.usn
            JOIN semsec
            ON semsec.ssid = class.ssid
    GROUP BY semsec.sem, semsec.sec
    ORDER BY semsec.sem, semsec.sec;
    
/*
3. Create a view of Test1 marks of student USN ‘1BY18CS024’ in all Courses.
*/
CREATE VIEW test1_marks AS
SELECT test1, subcode
    FROM iamarks
    WHERE iamarks.usn = '1BY18CS024';
SELECT * FROM test1_marks;
DROP VIEW test1_marks;

/*
4. Calculate the FinalIA (average of best two test marks) and update the
corresponding table for all students.
*/

UPDATE iamarks
    SET finalia = CASE
                    WHEN GREATEST(test1, test2) = GREATEST(test2, test3)
                        THEN (GREATEST(test1, test2) + GREATEST(test2, test3)) / 2
                    ELSE
                        (GREATEST(test1, test2) + GREATEST(test3, test2)) / 2
                    END;
SELECT * FROM iamarks;
    
/*
5. Categorize students based on the following criterion:
If FinalIA = 17 to 20 then CAT = ‘Outstanding’
If FinalIA = 12 to 16 then CAT = ‘Average’
If FinalIA< 12 then CAT = ‘Weak’
Give these details only for 8th semester A, B, and C section students
*/

SELECT iamarks.usn, iamarks.subcode, iamarks.finalia, semsec.sec, (
    CASE
        WHEN finalia BETWEEN 17 AND 20 THEN 'Outstanding'
        WHEN finalia BETWEEN 12 AND 16 THEN 'Average'
        ELSE 'Weak'
    END
    ) as category
    FROM iamarks
        JOIN semsec
        ON iamarks.ssid = semsec.ssid
    WHERE semsec.sem = 8
    ORDER BY sec, iamarks.subcode;
