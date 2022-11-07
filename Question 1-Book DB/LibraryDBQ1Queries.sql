/*
1. Retrieve details of all books in the library – id, title, name of publisher, authors, number of copies in each Programme, etc.
*/

SELECT B.book_id, B.title, B.publisher_name, BA.author_name, LP.programme_name, BC.no_of_copies
    FROM book B, book_author BA, library_programme LP, book_copies BC
    WHERE 
        B.book_id = BA.book_id 
            AND 
        B.book_id = BC.book_id 
            AND 
        BC.programme_id = LP.programme_id;

/*
2. Get the particulars of borrowers who have borrowed more than 3 books, but from Jan 2017 to Jun 2017.
*/

SELECT card_no, COUNT(card_no)
    FROM book_lending
    WHERE date_out BETWEEN '01-Jan-2017' AND '01-Jun-2017'
    HAVING COUNT(card_no) >= 3
    GROUP BY card_no;
    
/*
3. Delete a book in BOOK table. Update the contents of other tables to reflect this data manipulation operation
*/
DELETE 
    FROM book
    WHERE book_id = 1;

/*
4. Partition the BOOK table based on year of publication. Demonstrate its working with a simple query
*/
--observe value of year count in year 2016
SELECT book_id, title, publisher_name, pub_year, COUNT(pub_year) OVER(PARTITION BY pub_year) YearCount
    FROM book
    ORDER BY pub_year;

CREATE TABLE unpart_book AS Select * From book;
SELECT * FROM unpart_book PARTITION (year_2015);


ALTER TABLE unpart_book MODIFY PARTITION BY RANGE (pub_year) INTERVAL(1) (
    PARTITION year_2015 VALUES LESS THAN (2016)
);

SELECT * FROM unpart_book PARTITION FOR (2016);


/*
5. Create a view of all books and its number of copies that are currently available in the Library.
*/
--Partition by title to create a subview and also to use the aggregate SUM and also display the other fields, DISTINCT to not repeat.
CREATE VIEW total_books AS
    SELECT DISTINCT B.book_id, B.title, B.publisher_name, B.pub_year, SUM(BC.no_of_copies) OVER(PARTITION BY B.title) TotalBooks
        FROM book B, book_copies BC
        WHERE B.book_id = BC.book_id
        ORDER BY B.book_id;
DROP VIEW total_books;

CREATE VIEW total_books AS
    SELECT book_id, SUM(total_books) as total_copies, SUM(lend_books) as borrowed_books, (SUM(total_books)-SUM(lend_books)) as remaining
        FROM (
            SELECT book_id, no_of_copies as total_books, 0 as lend_books from book_copies 
                UNION ALL
            SELECT DISTINCT book_id, null as total_books, COUNT(card_no) as lend_books from book_lending group by(book_id)
        )
        GROUP BY book_id
        ORDER BY book_id;
SELECT * FROM total_books;
DROP VIEW total_books;