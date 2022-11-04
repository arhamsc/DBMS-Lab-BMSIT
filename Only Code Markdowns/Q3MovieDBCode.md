# DBMS Lab Question 3 - Movie DB

## Question

### Schema

> ACTOR(Act_id, Act_Name, Act_Gender)
>
> DIRECTOR(Dir_id, Dir_Name, Dir_Phone)
>
> MOVIES(Mov_id, Mov_Title, Mov_Year, Mov_Lang, Dir_id)
>
> MOVIE_CAST(Act_id, Mov_id, Role)
>
> RATING(Mov_id, Rev_Stars)

### Queries to Execute

> 1. List the titles of all movies directed by ‘Hitchcock’.
>
> 2. Find the movie names where one or more actors acted in two or more movies.
>
> 3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).
>
> 4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title.
>
> 5. Update rating of all movies directed by ‘Steven Spielberg’ to 5.

## CODE

**_NOTE: Please follow the order_**

### Create Tables

Actor table

> ```sql
> CREATE TABLE actor(
>    act_id INT PRIMARY KEY,
>    act_name VARCHAR(20),
>    act_gender VARCHAR(1)
> );
> ```

Director Table

> ```sql
> CREATE TABLE director(
>    dir_id INT PRIMARY KEY,
>    dir_name VARCHAR(20),
>    dir_phone NUMBER(10)
> );
> ```

Movie Table

> ```sql
> CREATE TABLE movie(
>    mov_id INT PRIMARY KEY,
>    mov_title VARCHAR(20),
>    mov_year INT,
>    mov_lang VARCHAR(10),
>    dir_id INT,
>    FOREIGN KEY(dir_id) REFERENCES director(dir_id) ON DELETE SET NULL
> );
> ```

Movie Cast Table

> ```sql
> CREATE TABLE movie_cast(
>    act_id INT REFERENCES actor(act_id) ON DELETE SET NULL,
>    mov_id INT REFERENCES movie(mov_id) ON DELETE CASCADE,
>    role VARCHAR(20)
> );
> ```

Ratings table

> ```sql
> CREATE TABLE rating(
>    mov_id INT REFERENCES movie(mov_id) ON DELETE CASCADE,
>    rev_stars INT
> );
> ```

### Inserting Data into the tables

**_I have taken sufficient values to run all required queries_**

Inserting into Actors table

> ```sql
> INSERT ALL
>    INTO actor VALUES(1, 'Anthony Perkins', 'M')
>    INTO actor VALUES(2, 'Janet Leigh', 'F')
>    INTO actor VALUES(3, 'Cary Grant', 'M')
>    INTO actor VALUES(4, 'Eva Marie Saint', 'F')
>    INTO actor VALUES(5, 'Liam Neeson', 'M')
>    INTO actor VALUES(6, 'Jagapati Babu', 'M')
>    INTO actor VALUES(7, 'Srikanth', 'M')
>    INTO actor VALUES(8, 'Prakash Raj', 'M')
>    INTO actor VALUES(9, 'Chiranjeevi', 'M')
>    INTO actor VALUES(10, 'Taki', 'M')
>    INTO actor VALUES(11, 'Hodaka', 'M')
>SELECT * FROM dual;
>```

Inserting into director table

> ```sql
> INSERT ALL
>    INTO director VALUES(1, 'Alfred Hitchcock', 0554138177)
>    INTO director VALUES(2, 'Steven Spielberg', 0987634744)
>    INTO director VALUES(3, 'Kodi Ramakrishna', 5016237794)
>    INTO director VALUES(4, 'Ravi Raja Pinisetty', 8242818739)
>    INTO director VALUES(5, 'E.V.V.Satyanarayana', 1530119910)
>    INTO director VALUES(6, 'K. Raghavendra Rao', 6187803214)
>    INTO director VALUES(7, 'Prashanth Neel', 8988535132)
>    INTO director VALUES(8, 'Mohan Raja', 5256775073)
>    INTO director VALUES(9, 'Makoto Shinkai', 8508186630)
> SELECT * FROM dual;
> ```

Insert into movie table

> ```sql
> INSERT ALL
>    INTO movie VALUES(1, 'Psyco', 1960, 'English', 1)
>    INTO movie VALUES(2, 'NorthByNorthwest', 1959, 'English', 1)
>    INTO movie VALUES(3, 'Schindler List', 1993, 'English', 2)
>    INTO movie VALUES(4, 'Alludugaaru', 1999, 'Telugu', 4)
>    INTO movie VALUES(5, 'Chala Bagundi', 1999, 'Telugu', 5)
>    INTO movie VALUES(6, 'Aavide Shyamala', 1999, 'Telugu', 3)
>    INTO movie VALUES(7, 'Iddaru Mitrulu', 1999, 'Telugu', 6)
>    INTO movie VALUES(8, 'Kimi no na wa',2016, 'Japanese', 9)
>    INTO movie VALUES(9, 'Tenki no ko', 2019, 'Japanese', 9)
>    INTO movie VALUES(10, 'God Father', 2022, 'Telugu', 8)
>    INTO movie VALUES(11, 'KGF', 2018, 'Kannada', 7)
> SELECT * FROM dual;
> ```

Inserting into movie_cast table

> ```sql
> INSERT ALL
>    INTO movie_cast VALUES(1, 1, 'Main')
>    INTO movie_cast VALUES(2, 1, 'Main Female')
>    INTO movie_cast VALUES(3, 2, 'Main')
>    INTO movie_cast VALUES(4, 2, 'Main Female')
>    INTO movie_cast VALUES(5, 3, 'Main')
>    INTO movie_cast VALUES(6, 4, 'Main')
>    INTO movie_cast VALUES(7, 5, 'Main')
>    INTO movie_cast VALUES(8, 6, 'Main')
>    INTO movie_cast VALUES(8, 11, 'Narrator')
>    INTO movie_cast VALUES(9, 7, 'Main')
>    INTO movie_cast VALUES(9, 10, 'Main')
>    INTO movie_cast VALUES(10, 8, 'Main')
>    INTO movie_cast VALUES(11, 9, 'Main')
> SELECT * FROM dual;
> ```

Insert into rating table

(Every movie can have multiple ratings and they do not clash as primary key isn't specified)

> ```sql
> INSERT ALL
>    INTO rating VALUES(1, 3)
>    INTO rating VALUES(2, 3)
>    INTO rating VALUES(3, 3)
>    INTO rating VALUES(5, 3)
>    INTO rating VALUES(6, 0)
>    INTO rating VALUES(7, 3)
>    INTO rating VALUES(8, 5)
>    INTO rating VALUES(9, 5)
>    INTO rating VALUES(8, 5)
>    INTO rating VALUES(9, 5)
>    INTO rating VALUES(10, 3)
>    INTO rating VALUES(11, 3)
> SELECT * FROM dual;
> ```

### Queries(Answers)

Q1:

Below can be written with JOINS but I have used Nested query

> ```sql
> SELECT *
>    FROM movie
>    WHERE movie.dir_id = (
>        SELECT director.dir_id
>            FROM director
>            WHERE director.dir_name LIKE '% Hitchcock'
>            FETCH NEXT 1 ROWS ONLY -- to return only one row
>    );
> ```

Q2:

> ```sql
> SELECT mov_title
>    FROM movie m
>        JOIN movie_cast mc
>        ON mc.mov_id = m.mov_id
>    WHERE act_id IN (
>        SELECT act_id
>            FROM movie
>                JOIN movie_cast
>                ON movie_cast.mov_id = movie.mov_id
>            HAVING COUNT(act_id) >= 2 --condition for 2 or more
>            GROUP BY act_id
>    );
> ```

Q3:

I have included two methods to solve this question

> Method 1 - With JOIN Keyword
>
> > ```sql
> > SELECT *
> >    FROM actor A
> >        JOIN movie_cast C
> >        ON C.act_id = A.act_id
> >                JOIN movie M
> >                ON C.mov_id = M.mov_id
> >    WHERE --Condition checks if that act_id is in both the places
> >        C.act_id IN( --gets movies before 2000
> >            SELECT movie_cast.act_id
> >                FROM movie
> >                    JOIN movie_cast
> >                    ON movie_cast.mov_id = movie.mov_id
> >                WHERE mov_year < 2000
> >        )
> >        AND
> >        C.act_id IN( --gets movies after 2015
> >            SELECT movie_cast.act_id
> >                FROM movie
> >                    JOIN movie_cast
> >                    ON movie_cast.mov_id = movie.mov_id
> >                WHERE mov_year > 2015
> >        );
> > ```
>
> Method 2 - Without JOIN Keyword
>
> > ```sql
> > SELECT *
> >    FROM actor A, movie_cast C1, movie_cast C2, movie M1, Movie M2 --Where clause Joins
> >        WHERE
> >        A.act_id = C1.act_id AND A.act_id = C2.act_id --joining condition for 1st copy
> >        AND
> >        M1.mov_id = C1.mov_id AND M2.mov_id = C2.mov_id --joining condition for 2nd copy
> >        AND
> >        M1.mov_year < 2000 AND M2.mov_year > 2015;
> > ```

Q4:

> ```sql
> SELECT  mov_title, MAX(rev_stars) as max_rating
>    FROM movie
>        JOIN rating
>        ON rating.mov_id = movie.mov_id
>    GROUP BY mov_title
>    HAVING MAX(rev_stars) > 0
>    ORDER BY mov_title;
> ```

Q5:

> ```sql
> UPDATE rating
>    SET rev_stars = 5
>    WHERE mov_id IN (
>        SELECT mov_id
>            FROM movie
>                JOIN director USING (dir_id)
>            WHERE director.dir_name = 'Steven Spielberg'
>    );
>
> SELECT * FROM rating;
> ```

### Tested on Oracle DB V19

---

**_Note_**:
**_Check for version in ORACLE_**

```sql
SELECT * FROM V$VERSION
```
