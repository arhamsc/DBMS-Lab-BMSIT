INSERT ALL
    INTO salesman VALUES(1, 'John', 'BNG', '25%')
    INTO salesman VALUES(2,'Arsh','BNG','20%')
    INTO salesman VALUES(3,'Ara','MYS','15%')
    INTO salesman VALUES(4,'Tanaka','DL','30%')
    INTO salesman VALUES(5,'Kyoichirou','HYD','15%')
SELECT * FROM dual;

INSERT ALL
    INTO customer VALUES(10,'Kumar','BNG',100,1)
    INTO customer VALUES(11,'Kiran','MNG',300,1)
    INTO customer VALUES(12,'Buvesh','CHN',400,2)
    INTO customer VALUES(13,'Chamunda','BNG',200,2)
    INTO customer VALUES(14,'Sidesh','BNG',400,3)
SELECT * FROM dual;

INSERT ALL
    INTO orders VALUES(20,6000,'04-MAY-22',10,1)
    INTO orders VALUES(21,550,'20-JAN-22',10,2)
    INTO orders VALUES(22,2000,'24-FEB-22',13,2)
    INTO orders VALUES(23,4000,'13-APR-22',14,3)
    INTO orders VALUES(24,600,'09-MAR-22',12,2)
SELECT * FROM dual;

SELECT * FROM salesman;
SELECT * FROM customer;
SELECT * FROM orders;