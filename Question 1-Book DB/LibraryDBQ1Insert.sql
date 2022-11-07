INSERT ALL
        INTO publisher VALUES('Mcgraw-Hill','Bangalore',9191919191)
        INTO publisher VALUES('Pearson','Newdelhi',8181818181)
        INTO publisher VALUES('Random House','Hyderabad',7171717171)
        INTO publisher VALUES('Livre','Chennai',6161616161)
        INTO publisher VALUES('Planeta','Bangalore',5151515151)
SELECT * FROM dual;

INSERT ALL
    INTO book VALUES(1,'DBMS','Mcgraw-Hill',2017)
    INTO book VALUES(2,'ADBMS','Mcgraw-Hill',2016)
    INTO book VALUES(3,'CN','Pearson',2016)
    INTO book VALUES(4,'CG','Planeta',2015)
    INTO book VALUES(5,'OS','Pearson',2016)
SELECT * FROM dual;

INSERT ALL
    INTO book_author VALUES(1,'Navathe')
    INTO book_author VALUES(2,'Navathe')
    INTO book_author VALUES(3,'Tanenbaum')
    INTO book_author VALUES(4,'Edward Angel')
    INTO book_author VALUES(5,'Galvin')
SELECT * FROM dual;

INSERT ALL
    INTO library_programme VALUES(1, 'Double Dhamaka', 'Bangalore')
    INTO library_programme VALUES(2, 'Save for others', 'Mumbai')
    INTO library_programme VALUES(3, 'Great fair', 'Bangalore')
    INTO library_programme VALUES(4, 'Best of fantasy', 'Hyderabad')
SELECT * FROM dual;

INSERT ALL
    INTO book_copies VALUES(1,1,10)
    INTO book_copies VALUES(1,2,11)
    INTO book_copies VALUES(2,3,12)
    INTO book_copies VALUES(3,2,13)
    INTO book_copies VALUES(4,2,14)
    INTO book_copies VALUES(1,3,10)
    INTO book_copies VALUES(3,4,11)
SELECT * FROM dual;

INSERT ALL
    INTO card VALUES(100)
    INTO card VALUES(101)
    INTO card VALUES(102)
    INTO card VALUES(103)
    INTO card VALUES(104)
SELECT * FROM dual;

INSERT ALL
    INTO book_lending VALUES(1,1,101, '01-JAN-17','01-JUN-17')
    INTO book_lending VALUES(3,4,101, '11-JAN-17','11-MAR-17')
    INTO book_lending VALUES(2,3,101, '21-FEB-17','21-APR-17')
    INTO book_lending VALUES(4,1,101, '15-MAR-17','15-JUL-17')
    INTO book_lending VALUES(1,1,104, '12-APR-17','12-MAY-17')
SELECT * FROM dual;
INSERT INTO book_lending VALUES(4,1,102, '12-APR-17','12-MAY-17');

SELECT * FROM publisher;
SELECT * FROM book;
SELECT * FROM book_author;
SELECT * FROM library_programme;
SELECT * FROM book_copies;
SELECT * FROM book_lending;
SELECT * FROM card;