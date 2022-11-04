INSERT ALL
    INTO actor VALUES(1, 'Anthony Perkins', 'M') --psyco
    INTO actor VALUES(2, 'Janet Leigh', 'F') --pysco
    INTO actor VALUES(3, 'Cary Grant', 'M') --north by northwest
    INTO actor VALUES(4, 'Eva Marie Saint', 'F') --north by northwest
    INTO actor VALUES(5, 'Liam Neeson', 'M') --schindler's list
    INTO actor VALUES(6, 'Jagapati Babu', 'M') --Alludugaaru Vachcharu
    INTO actor VALUES(7, 'Srikanth', 'M') --Chala Bagundi
    INTO actor VALUES(8, 'Prakash Raj', 'M') --Aavide Shyamala -- before 2000
    INTO actor VALUES(9, 'Chiranjeevi', 'M') -- Iddaru Mitrulu -- befroe 200
    INTO actor VALUES(10, 'Taki', 'M')
    INTO actor VALUES(11, 'Hodaka', 'M')
SELECT * FROM dual;

INSERT ALL
    INTO director VALUES(1, 'Alfred Hitchcock', 0554138177)
    INTO director VALUES(2, 'Steven Spielberg', 0987634744)
    INTO director VALUES(3, 'Kodi Ramakrishna', 5016237794)
    INTO director VALUES(4, 'Ravi Raja Pinisetty', 8242818739)
    INTO director VALUES(5, 'E.V.V.Satyanarayana', 1530119910)
    INTO director VALUES(6, 'K. Raghavendra Rao', 6187803214)
    INTO director VALUES(7, 'Prashanth Neel', 8988535132)
    INTO director VALUES(8, 'Mohan Raja', 5256775073)
    INTO director VALUES(9, 'Makoto Shinkai', 8508186630)
SELECT * FROM dual;

INSERT ALL
    INTO movie VALUES(1, 'Psyco', 1960, 'English', 1)
    INTO movie VALUES(2, 'NorthByNorthwest', 1959, 'English', 1)
    INTO movie VALUES(3, 'Schindler List', 1993, 'English', 2)
    INTO movie VALUES(4, 'Alludugaaru', 1999, 'Telugu', 4)
    INTO movie VALUES(5, 'Chala Bagundi', 1999, 'Telugu', 5)
    INTO movie VALUES(6, 'Aavide Shyamala', 1999, 'Telugu', 3)
    INTO movie VALUES(7, 'Iddaru Mitrulu', 1999, 'Telugu', 6)
    INTO movie VALUES(8, 'Kimi no na wa',2016, 'Japanese', 9)
    INTO movie VALUES(9, 'Tenki no ko', 2019, 'Japanese', 9)
    INTO movie VALUES(10, 'God Father', 2022, 'Telugu', 8)
    INTO movie VALUES(11, 'KGF', 2018, 'Kannada', 7)
SELECT * FROM dual;

INSERT ALL
    INTO movie_cast VALUES(1, 1, 'Main')
    INTO movie_cast VALUES(2, 1, 'Main Female')
    INTO movie_cast VALUES(3, 2, 'Main')
    INTO movie_cast VALUES(4, 2, 'Main Female')
    INTO movie_cast VALUES(5, 3, 'Main')
    INTO movie_cast VALUES(6, 4, 'Main')
    INTO movie_cast VALUES(7, 5, 'Main')
    INTO movie_cast VALUES(8, 6, 'Main')
    INTO movie_cast VALUES(8, 11, 'Narrator')
    INTO movie_cast VALUES(9, 7, 'Main')
    INTO movie_cast VALUES(9, 10, 'Main')
    INTO movie_cast VALUES(10, 8, 'Main')
    INTO movie_cast VALUES(11, 9, 'Main')
SELECT * FROM dual;

--movie 6 has no rating
INSERT ALL
    INTO rating VALUES(1, 3)
    INTO rating VALUES(2, 3)
    INTO rating VALUES(3, 3)
    INTO rating VALUES(5, 3)
    INTO rating VALUES(6, 0)
    INTO rating VALUES(7, 3)
    INTO rating VALUES(8, 5)
    INTO rating VALUES(9, 5)
    INTO rating VALUES(8, 5)
    INTO rating VALUES(9, 5)
    INTO rating VALUES(10, 3)
    INTO rating VALUES(11, 3)
SELECT * FROM dual;

SELECT * FROM actor;
SELECT * FROM director;
SELECT * FROM movie;
SELECT * FROM movie_cast;
SELECT * FROM rating;