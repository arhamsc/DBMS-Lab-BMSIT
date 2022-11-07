CREATE TABLE publisher(
    name VARCHAR(20) PRIMARY KEY,
    address VARCHAR(20),
    phone NUMBER(10)
);

CREATE TABLE book(
    book_id INT PRIMARY KEY,
    title VARCHAR(20),
    publisher_name VARCHAR(20) REFERENCES publisher(name) ON DELETE SET NULL,
    pub_year INT
);

CREATE TABLE book_author(
    book_id INT REFERENCES book(book_id) ON DELETE CASCADE,
    author_name VARCHAR(20)
);

CREATE TABLE library_programme(
    programme_id INT PRIMARY KEY,
    programme_name VARCHAR(20) NOT NULL,
    address VARCHAR(20)
);


CREATE TABLE book_copies(
    book_id INT REFERENCES book(book_id) ON DELETE CASCADE,
    programme_id INT REFERENCES library_programme(programme_id) ON DELETE SET NULL,
    no_of_copies INT
);

CREATE TABLE card(
    card_no INT PRIMARY KEY
);


CREATE TABLE book_lending(  
    book_id INT REFERENCES book(book_id) ON DELETE CASCADE,
    programme_id INT REFERENCES library_programme(programme_id) ON DELETE SET NULL,
    card_no INT REFERENCES card(card_no) ON DELETE CASCADE,
    date_out DATE,
    due_date DATE
);

DELETE book_lending;
DELETE card;
DELETE book_copies;
DELETE library_programme;
DELETE book_author;
DELETE book;
DELETE publisher;