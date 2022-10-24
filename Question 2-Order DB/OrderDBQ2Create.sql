CREATE TABLE salesman(
    salesman_id INT PRIMARY KEY,
    name VARCHAR(20),
    city VARCHAR(20),
    commission VARCHAR(10)
);
ALTER TABLE salesman RENAME COLUMN comission TO commission;
CREATE TABLE customer(
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(20),
    city VARCHAR(20),
    grade INT,
    salesman_id INT REFERENCES salesman(salesman_id) ON DELETE SET NULL
);
drop table orders;

CREATE TABLE orders(
    ord_no INT PRIMARY KEY,
    purchase_amt INT,
    ord_date DATE,
    customer_id REFERENCES customer(customer_id) ON DELETE CASCADE,
    salesman_id REFERENCES salesman(salesman_id) ON DELETE CASCADE
);