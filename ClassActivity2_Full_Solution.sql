--Question 1

CREATE TABLE Book
(
Book_ID VARCHAR2(100) NOT NULL,
Title VARCHAR2(100) NOT NULL,
Price NUMBER(5,2) NOT NULL,
Instock INT NOT NULL,
CONSTRAINT PK_Book PRIMARY KEY (Book_ID)
);

CREATE TABLE Author
(
Author_ID INT NOT NULL,
Firstname VARCHAR2(100) NOT NULL,
Surname VARCHAR2(100) NOT NULL,
Contact VARCHAR2(100) NOT NULL,
CONSTRAINT PK_Author PRIMARY KEY (Author_ID)
);

CREATE TABLE ORDERS
(
Order_ID VARCHAR2(100) NOT NULL,
Order_Date DATE NOT NULL,
Qty VARCHAR2(100) NOT NULL,
Book_ID VARCHAR2(100) NOT NULL,
Author_id INT NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY (Order_ID),
constraint FK_Book_ID FOREIGN KEY(Book_id) REFERENCES Book(Book_ID),
constraint FK_Author_ID FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID)
);

INSERT INTO  BOOK VALUES('SQL101','SQL in 3 Months','899','55');
INSERT INTO  BOOK VALUES('AND101','Android Developer','599','35');
INSERT INTO  BOOK VALUES('C101','Extreme C#','997','15');
INSERT INTO  BOOK VALUES('J101','Java in 3 Months','557','28');
INSERT INTO  BOOK VALUES('IT101','IT System Design','825','29');

INSERT INTO Author VALUES('101','Bob','Bobson','0211231258');
INSERT INTO Author VALUES('102','Joe','Bloggs','0111755859');
INSERT INTO Author VALUES('103','Andre','Smith','0411238795');

INSERT INTO Orders VALUES('ORDER_1','15/May/2016','5','SQL101','101');
INSERT INTO Orders VALUES('ORDER_2','15/May/2016','3','C101','102');
INSERT INTO Orders VALUES('ORDER_3','17/May/2016','5','AND101','103');
INSERT INTO Orders VALUES('ORDER_4','25/May/2016','2','AND101','103');
INSERT INTO Orders VALUES('ORDER_5','28/May/2016','3','SQL101','101');

--Question 1.2

SELECT a.Firstname||' '||a.Surname AS Aurther_Name, b.Title, o.Order_Date
FROM Author a INNER JOIN Orders o ON a.Author_ID = o.Author_ID
INNER JOIN Book b ON b.Book_ID = o.Book_ID
ORDER BY b.Title;

--Question 1.3

SELECT b.Title AS Book_Title, 'R'||b.Price AS Price, 'R'||b.Price*0.14 as VAT, 
'R'||Price*1.14 AS Total_Price
FROM Book b INNER JOIN Orders o ON b.Book_ID = o.Book_ID
WHERE o.Qty = 5;

--Question 1.4

SET SERVEROUTPUT ON;
DECLARE
    v_Fname Author.Firstname%TYPE;
    v_Surname Author.Surname%TYPE;
    v_Title Book.Title%TYPE;

CURSOR c1
IS
    SELECT a.Firstname, a.Surname , b.Title
    FROM Author a INNER JOIN Orders o ON a.Author_ID = o.Author_ID
    INNER JOIN Book b ON b.Book_ID = o.Book_ID
    WHERE a.Contact LIKE '011%';
BEGIN
    OPEN c1;
    LOOP
    FETCH c1 INTO v_Fname, v_Surname, v_Title;
    EXIT WHEN c1%notfound;
    
        dbms_output.put_line('AUTHOR :'||v_Fname||' '|| v_Surname||CHR(10)||'TITLE :'||v_Title);

    END LOOP;
    CLOSE c1;
END;
/

SET SERVEROUTPUT ON;
DECLARE
    v_Fname Author.Firstname%TYPE;
    v_Surname Author.Surname%TYPE;
    v_Title Book.Title%TYPE;
CURSOR myInfo
IS
    SELECT a.Firstname, a.Surname , b.Title
    FROM Author a INNER JOIN Orders o ON a.Author_ID = o.Author_ID
    INNER JOIN Book b ON b.Book_ID = o.Book_ID
    WHERE a.Contact LIKE '011%';
BEGIN
    FOR rec IN myInfo
    LOOP
    v_Fname := rec.Firstname;
    v_Surname := rec.Surname;
    v_Title :=rec.Title;
        dbms_output.put_line('AUTHOR :'||v_Fname||' '|| v_Surname||CHR(10)||
        'TITLE :'||v_Title);
    END LOOP;
END;
/

--Question 1.5

DECLARE
    v_Fname Author.Firstname%TYPE;
    v_Surname Author.Surname%TYPE;
    v_Total INT;
CURSOR c1
IS
SELECT a.Firstname, a.Surname, SUM(o.Qty) 
    FROM Author a INNER JOIN Orders o ON a.Author_ID = o.Author_ID
    GROUP BY a.Firstname, a.Surname
    ORDER BY a.Firstname;
BEGIN
    OPEN c1;
    LOOP
    FETCH c1 INTO v_Fname, v_Surname, v_Total;
    EXIT WHEN c1%notfound;
    
        dbms_output.put_line('Book sales for '||v_Fname||' '|| v_Surname||' are '||v_Total);
        dbms_output.put_line('---------------------------------------------------------------');
    END LOOP;
    CLOSE c1;
END;
/




--Question 1.6 using LEFT JOIN

CREATE OR REPLACE VIEW No_Book_Orders
AS
    SELECT b.Title, o.Order_Date
    FROM  Book b LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
    WHERE o.Book_ID IS NULL;
    
--Question 1.6 using RIGHT JOIN

CREATE OR REPLACE VIEW No_Book_Orders
AS
    SELECT b.Title, o.Order_Date
    FROM  Orders o RIGHT JOIN Book b ON b.Book_ID = o.Book_ID
    WHERE o.Book_ID IS NULL;
    
--Question 1.6 using Nested or SubQuery

CREATE OR REPLACE VIEW No_Book_Orders
AS
    SELECT Title
    FROM Book 
    WHERE Book_ID NOT IN
    (SELECT Book_ID
    FROM Orders);
    
--Test the view
    
SELECT * FROM No_Book_Orders;

--Question 1.7 IF Statement

DECLARE 
    v_BookID Book.Book_ID%TYPE;
    v_Title Book.Title%TYPE;
    v_Stock Book.Instock%TYPE;
CURSOR 
c1 IS
    SELECT Book_ID, Title, InStock
    FROM Book;
BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_BookID, v_Title, v_Stock;
EXIT WHEN c1%notfound;

    IF v_Stock < 20 THEN
        dbms_output.put_line('BOOK ID'||v_BookID);
        dbms_output.put_line('BOOK TITLE '||v_Title);
        dbms_output.put_line('STOCK REPORT : Stock levels are not stable Increase');
        dbms_output.put_line('-----------------------------------');
    ELSE   
        dbms_output.put_line('BOOK ID'||v_BookID);
        dbms_output.put_line('BOOK TITLE '||v_Title);
        dbms_output.put_line('STOCK REPORT : Stock levels are STABLE');
        dbms_output.put_line('-----------------------------------');  
    END IF;   
END LOOP;
CLOSE c1;
END;
/

--Question 1.7 CASE Statement

DECLARE 
    v_BookID Book.Book_ID%TYPE;
    v_Title Book.Title%TYPE;
    v_Stock Book.Instock%TYPE;
CURSOR 
c1 IS
    SELECT Book_ID, Title, InStock
    FROM Book;
BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_BookID, v_Title, v_Stock;
EXIT WHEN c1%notfound;

CASE 
    WHEN v_Stock < 20 THEN
        dbms_output.put_line('BOOK ID'||v_BookID);
        dbms_output.put_line('BOOK TITLE '||v_Title);
        dbms_output.put_line('STOCK REPORT : Stock levels are not stable Increase');
        dbms_output.put_line('-----------------------------------');
    ELSE   
        dbms_output.put_line('BOOK ID'||v_BookID);
        dbms_output.put_line('BOOK TITLE '||v_Title);
        dbms_output.put_line('STOCK REPORT : Stock levels are STABLE');
        dbms_output.put_line('-----------------------------------');  
    END CASE;
END LOOP;
CLOSE c1;
END;
/

--Question 8

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER Andre_Pollack IDENTIFIED BY andre12345;
GRANT SELECT ON Book TO Andre_Pollack;
COMMIT;

--Question 9

CREATE SEQUENCE Seq_Author_id
START WITH 104
INCREMENT BY 1;

SELECT * FROM Author;

--Test your squence by inserting a value in the required table

INSERT INTO Author VALUES(Seq_Author_id.nextval,'Simukai','Musiyiwa','0780780789');


























































































    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    