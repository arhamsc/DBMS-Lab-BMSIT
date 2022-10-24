# DBMS Lab Question 2 - Orders DB

## Question

### Schema

> SALESMAN(Salesman_id, Name, City, Commission)
>
> CUSTOMER(Customer_id, Cust_Name, City, Grade, Salesman_id)
>
> ORDERS(Ord_No, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)

### Queries to Execute

> 1. Count the customers with grades above Bangalore’s average.
>
> 2. Find the name and numbers of all salesman who had more than one customer.
>
> 3. List all the salesman and indicate those who have and don’t have customers in their cities (Use UNION operation.)
>
> 4. Create a view that finds the salesman who has the customer with the highest order of a day.
>
> 5. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.

## CODE

**_NOTE: Please follow the order_**

### Create Tables

Salesman table

> ```sql
> CREATE TABLE salesman(
>    salesman_id INT PRIMARY KEY,
>    name VARCHAR(20),
>    city VARCHAR(20),
>    commission VARCHAR(10)
> );
> ```

Customer Table

> ```sql
> CREATE TABLE customer(
>    customer_id INT PRIMARY KEY,
>    cust_name VARCHAR(20),
>    city VARCHAR(20),
>    grade INT,
>    salesman_id INT REFERENCES salesman(salesman_id) ON DELETE SET NULL
> );
> ```

Orders Table

> ```sql
> CREATE TABLE orders(
>    ord_no INT PRIMARY KEY,
>    purchase_amt INT,
>    ord_date DATE,
>    customer_id REFERENCES customer(customer_id) ON DELETE CASCADE,
>    salesman_id REFERENCES salesman(salesman_id) ON DELETE CASCADE
> );
> ```

### Inserting Data into the tables

**_I have taken sufficient values to run all required queries_**

Inserting into Salesman table

> ```sql
> INSERT ALL
>    INTO salesman VALUES(1, 'John', 'BNG', '25%')
>    INTO salesman VALUES(2,'Arsh','BNG','20%')
>    INTO salesman VALUES(3,'Ara','MYS','15%')
>    INTO salesman VALUES(4,'Tanaka','DL','30%')
>    INTO salesman VALUES(5,'Kyoichirou','HYD','15%')
> SELECT * FROM dual;
> ```

Inserting into Customer table

> ```sql
> INSERT ALL
>    INTO customer VALUES(10,'Kumar','BNG',100,1)
>    INTO customer VALUES(11,'Kiran','MNG',300,1)
>    INTO customer VALUES(12,'Buvesh','CHN',400,2)
>    INTO customer VALUES(13,'Chamunda','BNG',200,2)
>    INTO customer VALUES(14,'Sidesh','BNG',400,3)
> SELECT * FROM dual;
> ```

Insert into Orders table

> ```sql
> INSERT ALL
>    INTO orders VALUES(20,6000,'04-MAY-22',10,1)
>    INTO orders VALUES(21,550,'20-JAN-22',10,2)
>    INTO orders VALUES(22,2000,'24-FEB-22',13,2)
>    INTO orders VALUES(23,4000,'13-APR-22',14,3)
>    INTO orders VALUES(24,600,'09-MAR-22',12,2)
> SELECT * FROM dual;
> ```

### Queries(Answers)

Q1:

> ```sql
> SELECT grade, COUNT(DISTINCT customer_id)
>    FROM customer
>    HAVING grade > (
>        SELECT AVG(grade)
>            FROM customer
>            WHERE city = 'BNG'
>    )
>    GROUP BY grade;
> ```

Q2:

I have included two methods to solve this question

> Method 1
>
> > ```sql
> > SELECT salesman_id, name
> >    FROM salesman
> >    WHERE (
> >        SELECT COUNT(salesman_id)
> >            FROM customer
> >            WHERE customer.salesman_id = salesman.salesman_id
> >    ) > 1;
> > ```
>
> Method 2
>
> > ```sql
> > SELECT DISTINCT salesman_id, name
> >    FROM salesman
> >    WHERE salesman.salesman_id IN (
> >        SELECT C.salesman_id
> >            FROM customer C
> >                HAVING COUNT(C.salesman_id) > 1
> >                GROUP BY (C.salesman_id)
> >    );
> > ```

Q3:

> ```sql
> SELECT salesman.salesman_id, salesman.name, customer.cust_name, salesman.commission
>    FROM salesman
>        JOIN customer
>        ON customer.salesman_id = salesman.salesman_id
>    UNION
>        SELECT S.salesman_id, S.name, 'No Match', S.commission
>            FROM salesman S
>            WHERE NOT S.city = ANY(SELECT city FROM customer)
>            ORDER BY 2 DESC;
> ```

Q4:

> ```sql
> SCREATE VIEW highest_cust AS
>    SELECT ord_date, cust_name, purchase_amt
>        FROM orders
>            JOIN customer
>            ON customer.customer_id = orders.customer_id
>        WHERE purchase_amt = (
>            SELECT MAX(purchase_amt)
>                FROM orders O
>                WHERE O.ord_date = orders.ord_date
>        );
> SELECT * FROM highest_cust;
> DROP VIEW highest_cust;
> ```

Q5:

> ```sql
> DELETE
>    FROM salesman
>    WHERE salesman_id = 1;
> ```

### Tested on Oracle DB V19

---

**_Note_**:
**_Check for version in ORACLE_**

```sql
SELECT * FROM V$VERSION
```
