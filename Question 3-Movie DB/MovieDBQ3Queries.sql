/*
1. List the titles of all movies directed by ‘Hitchcock’
*/

--Can be done using joins also but I will use nested query
SELECT *
    FROM movie
    WHERE movie.dir_id = (
        SELECT director.dir_id
            FROM director
            WHERE director.dir_name LIKE '% Hitchcock'
            FETCH NEXT 1 ROWS ONLY -- to return only one row
    );

/*
2. Find the movie names where one or more actors acted in two or more movies
*/

SELECT mov_title
    FROM movie m
        JOIN movie_cast mc
        ON mc.mov_id = m.mov_id
    WHERE act_id IN (
        SELECT act_id
            FROM movie
                JOIN movie_cast
                ON movie_cast.mov_id = movie.mov_id
            HAVING COUNT(act_id) >= 2 --condition for 2 or more
            GROUP BY act_id
    );


/*
3. List all actors who acted in a movie before 2000 and also in a movie after 2015
(use JOIN operation)
*/
--with normal joins and subqueries
SELECT *
    FROM actor A
        JOIN movie_cast C
        ON C.act_id = A.act_id
                JOIN movie M
                ON C.mov_id = M.mov_id
    WHERE --Condition checks if that act_id is in both the places
        C.act_id IN( --gets movies before 2000
            SELECT movie_cast.act_id 
                FROM movie 
                    JOIN movie_cast 
                    ON movie_cast.mov_id = movie.mov_id 
                WHERE mov_year < 2000
        )
        AND
        C.act_id IN( --gets movies after 2015
            SELECT movie_cast.act_id 
                FROM movie 
                    JOIN movie_cast 
                    ON movie_cast.mov_id = movie.mov_id 
                WHERE mov_year > 2015
        );
  ----OR----  
SELECT *
    FROM actor A, movie_cast C1, movie_cast C2, movie M1, Movie M2 --Where clause Joins
        WHERE 
        A.act_id = C1.act_id AND A.act_id = C2.act_id --joining condition for 1st copy
        AND 
        M1.mov_id = C1.mov_id AND M2.mov_id = C2.mov_id --joining condition for 2nd copy 
        AND
        M1.mov_year < 2000 AND M2.mov_year > 2015;
        
/*
4.Find the title of movies and number of stars for each movie that has at least one
rating and find the highest number of stars that movie received. Sort the result by
movie title
*/

--Joins only where there exists atleast one relation with two tables
SELECT  mov_title, MAX(rev_stars) as max_rating
    FROM movie
        JOIN rating
        ON rating.mov_id = movie.mov_id   
    GROUP BY mov_title
    HAVING MAX(rev_stars) > 0 
    ORDER BY mov_title;

/*
5. Update rating of all movies directed by ‘Steven Spielberg’ to 5.
*/

UPDATE rating
    SET rev_stars = 5
    WHERE mov_id IN (
        SELECT mov_id
            FROM movie
                JOIN director USING (dir_id)
            WHERE director.dir_name = 'Steven Spielberg'
    );
    
SELECT * FROM rating;
     