CREATE TABLE actor(
    act_id INT PRIMARY KEY,
    act_name VARCHAR(20),
    act_gender VARCHAR(1)
);

CREATE TABLE director(
    dir_id INT PRIMARY KEY,
    dir_name VARCHAR(20),
    dir_phone NUMBER(10)
);

CREATE TABLE movie(
    mov_id INT PRIMARY KEY,
    mov_title VARCHAR(20),
    mov_year INT,
    mov_lang VARCHAR(10),
    dir_id INT,
    FOREIGN KEY(dir_id) REFERENCES director(dir_id) ON DELETE SET NULL
);

ALTER TABLE movie MODIFY mov_year INT;

CREATE TABLE movie_cast(
    act_id INT REFERENCES actor(act_id) ON DELETE SET NULL,
    mov_id INT REFERENCES movie(mov_id) ON DELETE CASCADE,
    role VARCHAR(20)
);

CREATE TABLE rating(
    mov_id INT REFERENCES movie(mov_id) ON DELETE CASCADE,
    rev_stars INT
);