# DBMS Lab Question 3 - Movie DB

## Question

> ### Schema
>
> > BOOK(<ins>Book_id</ins>, Title, Publisher_Name, Pub_Year)
> >
> > BOOK_AUTHORS(<ins>Book_id</ins>, Author_Name)
> >
> > PUBLISHER(<ins>Name</ins>, Address, Phone)
> >
> > BOOK_COPIES(<ins>Book_id</ins>, <ins>Programme_id</ins>, No-of_Copies)
> >
> > BOOK_LENDING(<ins>Book_id</ins>, <ins>Programme_id</ins>, <ins>Card_No</ins> , Date_Out, Due_Date)
> >
> > LIBRARY_PROGRAMME(<ins>Programme_id</ins>, Programme_Name, Address)
>
> ### Queries to Execute
>
> > 1. Retrieve details of all books in the library – id, title, name of publisher, authors, number of copies in each Programme, etc.
> >
> > 2. Get the particulars of borrowers who have borrowed more than 3 books, but from Jan 2017 to Jun 2017.
> >
> > 3. Delete a book in BOOK table. Update the contents of other tables to reflect this data manipulation operation.
> >
> > 4. Partition the BOOK table based on year of publication. Demonstrate its working with a simple query.
> >
> > 5. Create a view of all books and its number of copies that are currently available in the Library.

## CODE

**_NOTE: Please follow the order_**

There is an extra table "CARD" as in "BOOK_LENDING" table there is a foreign key to card_no.

### Create Tables

Publisher table
>
>  ```sql
>  CREATE TABLE publisher(
>     name VARCHAR(20) PRIMARY KEY,
>     address VARCHAR(20),
>     phone NUMBER(10)
>  );
>  ```

Book Table
>
>  ```sql
>  CREATE TABLE book(
>     book_id INT PRIMARY KEY,
>     title VARCHAR(20),
>     publisher_name VARCHAR(20) REFERENCES publisher(name) ON DELETE SET NULL,
>     pub_year INT
>  );
>  ```

Book_Author Table
>
> > ```sql
> > CREATE TABLE book_author(
> >    book_id INT REFERENCES book(book_id) ON DELETE CASCADE,
> >    author_name VARCHAR(20)
> > );
> > ```
>
> Library Programme Table
>
> > ```sql
> > CREATE TABLE library_programme(
> >    programme_id INT PRIMARY KEY,
> >    programme_name VARCHAR(20) NOT NULL,
> >    address VARCHAR(20)
> > );
> > ```
>
> Book Copies table
>
> > ```sql
> > CREATE TABLE book_copies(
> >    book_id INT REFERENCES book(book_id) ON DELETE CASCADE,
> >    programme_id INT REFERENCES library_programme(programme_id) ON DELETE SET NULL,
> >    no_of_copies INT
> > );
> > ```
>
> Card Table (Extra table not mentioned in question)
>
> > ```sql
> > CREATE TABLE card(
> >    card_no INT PRIMARY KEY
> > );
> > ```
>
> Book Lending Table
>
> > ```sql
> > CREATE TABLE book_lending(
> >    book_id INT REFERENCES book(book_id) ON DELETE CASCADE,
> >    programme_id INT REFERENCES library_programme(programme_id) ON DELETE SET NULL,
> >    card_no INT REFERENCES card(card_no) ON DELETE CASCADE,
> >    date_out DATE,
> >    due_date DATE
> > );
> > ```

### Inserting Data into the tables

**_I have taken sufficient values to run all required queries_**

Inserting into Publisher table
>
> > ```sql
> > INSERT ALL
> >        INTO publisher VALUES('Mcgraw-Hill','Bangalore',9191919191)
> >        INTO publisher VALUES('Pearson','Newdelhi',8181818181)
> >        INTO publisher VALUES('Random House','Hyderabad',7171717171)
> >        INTO publisher VALUES('Livre','Chennai',6161616161)
> >        INTO publisher VALUES('Planeta','Bangalore',5151515151)
> > SELECT * FROM dual;
> > ```
>
Inserting into Book table
>
> > ```sql
> > INSERT ALL
> >    INTO book VALUES(1,'DBMS','Mcgraw-Hill',2017)
> >    INTO book VALUES(2,'ADBMS','Mcgraw-Hill',2016)
> >    INTO book VALUES(3,'CN','Pearson',2016)
> >    INTO book VALUES(4,'CG','Planeta',2015)
> >    INTO book VALUES(5,'OS','Pearson',2016)
> > SELECT * FROM dual;
> > ```
>
Insert into Book Author table
>
> > ```sql
> > INSERT ALL
> >    INTO book_author VALUES(1,'Navathe')
> >    INTO book_author VALUES(2,'Navathe')
> >    INTO book_author VALUES(3,'Tanenbaum')
> >    INTO book_author VALUES(4,'Edward Angel')
> >    INTO book_author VALUES(5,'Galvin')
> > SELECT * FROM dual;
> > ```
>
Inserting into Library Programme table
>
> > ```sql
> > INSERT ALL
> >    INTO library_programme VALUES(1, 'Double Dhamaka', 'Bangalore')
> >    INTO library_programme VALUES(2, 'Save for others', 'Mumbai')
> >    INTO library_programme VALUES(3, 'Great fair', 'Bangalore')
> >    INTO library_programme VALUES(4, 'Best of fantasy', 'Hyderabad')
> > SELECT * FROM dual;
> > ```
>
Insert into Book Copies table
>
> > ```sql
> > INSERT ALL
> >    INTO book_copies VALUES(1,1,10)
> >    INTO book_copies VALUES(1,2,11)
> >    INTO book_copies VALUES(2,3,12)
> >    INTO book_copies VALUES(3,2,13)
> >    INTO book_copies VALUES(4,2,14)
> >    INTO book_copies VALUES(1,3,10)
> >    INTO book_copies VALUES(3,4,11)
> > SELECT * FROM dual;
> > ```
>
Insert into Card Table
>
> > ```sql
> > INSERT ALL
> >    INTO card VALUES(100)
> >    INTO card VALUES(101)
> >    INTO card VALUES(102)
> >    INTO card VALUES(103)
> >    INTO card VALUES(104)
> > SELECT * FROM dual;
> > ```
>
Insert into Book Lending Table
>
> > ```sql
> > INSERT ALL
> >    INTO book_lending VALUES(1,1,101, '01-JAN-17','01-JUN-17')
> >    INTO book_lending VALUES(3,4,101, '11-JAN-17','11-MAR-17')
> >    INTO book_lending VALUES(2,3,101, '21-FEB-17','21-APR-17')
> >    INTO book_lending VALUES(4,1,101, '15-MAR-17','15-JUL-17')
> >    INTO book_lending VALUES(1,1,104, '12-APR-17','12-MAY-17')
> > SELECT * FROM dual;
> > ```

### Queries(Answers)

Q1:
>
> > ```sql
> > SELECT B.book_id, B.title, B.publisher_name, BA.author_name, LP.programme_name, BC.no_of_copies
> >    FROM book B, book_author BA, library_programme LP, book_copies BC
> >    WHERE
> >        B.book_id = BA.book_id
> >            AND
> >        B.book_id = BC.book_id
> >            AND
> >        BC.programme_id = LP.programme_id;
> > ```
>
Q2:
>
> > ```sql
> > SELECT card_no, COUNT(card_no)
> >    FROM book_lending
> >    WHERE date_out BETWEEN '01-Jan-2017' AND '01-Jun-2017'
> >    HAVING COUNT(card_no) >= 3
> >    GROUP BY card_no;
> > ```
>
Q3:
>
> In the Scheme we have linked the book_id with "ON DELETE CASCADE" as foreign key to other tables which makes sure that when the book is deleted from the "BOOK" table, it deletes the whole row linked to this book from the other tables also.
>
> > ```sql
> > DELETE
> >   FROM book
> >   WHERE book_id = 1;
> > ```
>
Q4:
>
> "PARTITION BY" creates a sub view to use, as the Aggregate functions can't be used with extra fields, by creating PARTITION we can use other fields(columns) also. It is always used with "OVER()"
>
> > ```sql
> > SELECT book_id, title, publisher_name, pub_year, COUNT(pub_year) OVER(PARTITION BY pub_year) YearCount
> >    FROM book
> >    ORDER BY pub_year;
> > ```
>
Q5:
>
> As mentioned in above question, we partition(create sub table) w.r.t title, hence we were able to use book_id, title and other columns, and distinct is used to not repeat the book values.
>
> > ```sql
> > CREATE VIEW total_books AS
> >    SELECT DISTINCT B.book_id, B.title, B.publisher_name, B.pub_year, SUM(BC.no_of_copies) OVER(PARTITION BY B.title) TotalBooks
> >        FROM book B, book_copies BC
> >        WHERE B.book_id = BC.book_id
> >        ORDER BY B.book_id;
> >
> > DROP VIEW total_books;
> > ```

### Tested on Oracle DB V19

---

**_Note_**:
**_Check for version in ORACLE_**

```sql
SELECT * FROM V$VERSION
```
