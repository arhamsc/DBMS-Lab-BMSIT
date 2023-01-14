/*
1. Count the customers with grades above Bangalore’s average.
*/

SELECT grade, COUNT(DISTINCT customer_id)
    FROM customer
    HAVING grade > (
        SELECT AVG(grade)
            FROM customer
            WHERE city = 'BNG'
    )
    GROUP BY grade;

/*
2. Find the name and numbers of all salesman who had more than one customer.
*/

SELECT salesman_id, name
    FROM salesman
    WHERE (
        SELECT COUNT(salesman_id)
            FROM customer
            WHERE customer.salesman_id = salesman.salesman_id
    ) > 1;
---OR----
SELECT DISTINCT salesman_id, name
    FROM salesman
    WHERE salesman.salesman_id IN (
        SELECT C.salesman_id
            FROM customer C
                HAVING COUNT(C.salesman_id) > 1
                GROUP BY (C.salesman_id)
    );
    
/*
3. List all the salesman and indicate those who have and don’t have customers in
their cities (Use UNION operation.)
*/  

SELECT salesman.salesman_id, salesman.name, customer.cust_name, salesman.commission
    FROM salesman
        JOIN customer
        ON customer.sales\man_id = salesman.salesman_id
    UNION 
        SELECT S.salesman_id, S.name, 'No Match', S.commission
            FROM salesman S
            WHERE NOT S.city = ANY(SELECT city FROM customer)
            ORDER BY 2 DESC;

/*
4. Create a view that finds the salesman who has the customer with the highest order
of a day.
*/

CREATE VIEW highest_cust AS
    SELECT ord_date, cust_name, purchase_amt, orders.salesman_id
        FROM orders
            JOIN customer
            ON customer.customer_id = orders.customer_id
        WHERE purchase_amt = (
            SELECT MAX(purchase_amt)
                FROM orders O
                WHERE O.ord_date = orders.ord_date
        );
SELECT * FROM highest_cust;
DROP VIEW highest_cust;

/*
5. Demonstrate the DELETE operation by removing salesman with id 1. All
his orders must also be deleted.
*/

DELETE 
    FROM salesman
    WHERE salesman_id = 1;
