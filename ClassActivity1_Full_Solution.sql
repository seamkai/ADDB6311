--Question 1

CREATE TABLE Product
(
    Product_ID CHAR(4) NOT NULL,
    Product_Name VARCHAR2(100) NOT NULL,
    Product_Price INT NOT NULL,
    CONSTRAINT PK_Product PRIMARY KEY(Product_ID)
);


CREATE TABLE Supplier
(
    Supplier_ID CHAR(10) NOT NULL,
    Supplier_Name VARCHAR2(100)NOT NULL,
    Supplier_Email VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_Supplier PRIMARY KEY(Supplier_ID)
);


CREATE TABLE SALES
(
    Sales_ID INT NOT NULL,
    Sales_Date DATE NOT NULL,
    Product_ID CHAR(4) NOT NULL,
    Supplier_ID CHAR(10) NOT NULL,
    CONSTRAINT PK_Sales PRIMARY KEY (SALES_ID),
    CONSTRAINT FK_Product_Sales FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    CONSTRAINT FK_Supplier_Sales FOREIGN KEY(Supplier_ID) REFERENCES Supplier(Supplier_ID)
);



--Single ROW Insert

INSERT INTO PRODUCT VALUES ('1001','Moca Java','30');
INSERT INTO PRODUCT VALUES ('1002','Americano','28');
INSERT INTO PRODUCT VALUES ('1003','Cappiccino','19');
INSERT INTO PRODUCT VALUES ('1004','Doppio','17');
INSERT INTO PRODUCT VALUES ('1005','Espresso Romano','25');



--Multiple Row Insert

INSERT ALL
    INTO Supplier VALUES ('SUP_101','Coffee Incoporated','ci@isat.co.za')
    INTO Supplier VALUES ('SUP_102','Java Heaven','javaheaven@ymail.com')
    INTO Supplier VALUES ('SUP_103','Colombia Dream','dream_col@isat.co.za')
SELECT * FROM DUAL;

--The dual tabe is default system table that is part of the oracle data dictionary


INSERT ALL
    INTO Sales VALUES ('1','15 July 2017','1002','SUP_101')
    INTO Sales VALUES ('2','15 July 2017','1002','SUP_102')
    INTO Sales VALUES ('3','27 August 2017','1001','SUP_103')
    INTO Sales VALUES ('4','30 August 2017','1005','SUP_101')
    INTO Sales VALUES ('5','30 August 2017','1003','SUP_102')
SELECT * FROM DUAL;

SELECT * FROM Product;
SELECT * FROM Supplier;
SELECT * FROM Sales;

--Question 2

SELECT Product_Name, 'R '||Product_Price AS Price,'R '|| Product_Price * 0.14 as VAT,
'R '||Product_Price * 1.14 AS TOTAL
FROM Product;

--Question 3

SELECT p.Product_Name, COUNT(s.Product_ID) AS Max_Sales
FROM Product p INNER JOIN Sales s ON p.Product_ID = s.Product_ID
GROUP BY p.Product_Name
ORDER BY COUNT(s.Product_ID) DESC
FETCH FIRST 1 ROWS ONLY;

--Question 4 Implicit FOR LOOP

SET SERVEROUTPUT ON;

DECLARE
    v_Pname Product.Product_Name%TYPE;
    v_SpName Supplier.Supplier_Name%TYPE;
    v_Sdate Sales.Sales_Date%TYPE;
CURSOR c1
IS
    SELECT p.Product_Name, sp.Supplier_Name, s.Sales_Date
    FROM Product p INNER JOIN Sales s ON p.Product_ID = s.Product_ID
    INNER JOIN Supplier sp ON s.Supplier_ID = sp.Supplier_ID
    WHERE s.Sales_ID = 3;

BEGIN 
FOR rec IN c1
LOOP
    v_Pname := rec.Product_Name;
    v_SpName := rec.Supplier_Name;
    v_Sdate := rec.Sales_Date;

    dbms_output.put_line('PRODUCT NAME:'||v_Pname||CHR(10)||'SUPPLIER NAME'||v_SpName||CHR(10)||'SALES DATE'||v_Sdate);
    
END LOOP;
END;
/

DECLARE
CURSOR c1
IS
    SELECT p.Product_Name, sp.Supplier_Name, s.Sales_Date
    FROM Product p INNER JOIN Sales s ON p.Product_ID = s.Product_ID
    INNER JOIN Supplier sp ON s.Supplier_ID = sp.Supplier_ID
    WHERE s.Sales_ID = 3;  
    v_rec  c1%ROWTYPE;
BEGIN 
    FOR rec IN c1
    LOOP
        dbms_output.put_line('PRODUCT NAME:'||v_rec.Product_name||CHR(10)||
            'SUPPLIER NAME'||v_rec.Supplier_name||CHR(10)||'SALES DATE'||v_rec.Sales_date);   
    END LOOP;
END;
/

SET SERVEROUTPUT ON;

DECLARE
    v_Pname Product.Product_Name%TYPE;
    v_SpName Supplier.Supplier_Name%TYPE;
    v_Sdate Sales.Sales_Date%TYPE;
CURSOR c1
IS
    SELECT p.Product_Name, sp.Supplier_Name, s.Sales_Date
    FROM Product p INNER JOIN Sales s ON p.Product_ID = s.Product_ID
    INNER JOIN Supplier sp ON s.Supplier_ID = sp.Supplier_ID
    WHERE s.Sales_ID = 3;

BEGIN 
OPEN c1;
LOOP
FETCH c1 INTO v_Pname,v_SpName,v_Sdate;
EXIT WHEN c1%NOTFOUND;

    dbms_output.put_line('PRODUCT NAME:'||v_Pname);
    dbms_output.put_line('SUPPLIER NAME'||v_SpName);
    dbms_output.put_line('SALES DATE'||v_Sdate);
END LOOP;
CLOSE c1;
END;
/

--Question 4 For Loop

SET SERVEROUTPUT ON;
DECLARE
    my_Exception EXCEPTION;
    v_Pname Product.Product_Name%TYPE;
    v_SpName Supplier.Supplier_Name%TYPE;
    v_Sdate Sales.Sales_Date%TYPE;
CURSOR c1
IS
    SELECT p.Product_Name, sp.Supplier_Name, s.Sales_Date
    FROM Product p INNER JOIN Sales s ON p.Product_ID = s.Product_ID
    INNER JOIN Supplier sp ON s.Supplier_ID = sp.Supplier_ID
    WHERE s.Sales_ID = 3;

BEGIN 
FOR rec IN c1
    LOOP
        v_Pname := rec.Product_Name;
        v_SpName := rec.Supplier_Name; 
        v_Sdate := rec.Sales_Date;
        
        IF v_Sdate >= SYSDATE THEN 
        RAISE my_Exception;
        END IF;
                dbms_output.put_line('PRODUCT NAME: '||v_Pname);
                dbms_output.put_line('SUPPLIER NAME: '||v_SpName);
                dbms_output.put_line('SALES DATE: '||v_Sdate);
    END LOOP;
EXCEPTION
        WHEN my_Exception THEN
        RAISE_APPLICATION_ERROR(-20199,'Cannot perform the requested action');
END;
/


--Question 5

DECLARE
    v_Pname Product.Product_Name%TYPE;
    v_Price Product.Product_Price%TYPE;
    
CURSOR c2
IS
SELECT p.Product_Name, p.Product_Price * 1.1 as Price
    FROM Product p INNER JOIN Sales s ON p.Product_ID = s.Product_ID
    INNER JOIN Supplier sp ON s.Supplier_ID = sp.Supplier_ID
    WHERE sp.Supplier_Name  = 'Coffee Incoporated';
BEGIN
FOR rec IN c2
LOOP
    v_Pname := rec.Product_Name;
    v_Price := rec.Price;

    dbms_output.put_line(v_Pname||'Price: R :'||v_Price||CHR(10)||'--------------------------------');
    
END LOOP;
END;
/

--Question 6

CREATE OR REPLACE VIEW Product_Sales
AS
SELECT p.Product_Name, s.Sales_Date, COUNT(s.Product_ID) AS Max_Sales
FROM Product p INNER JOIN Sales s ON p.Product_ID = s.Product_ID
GROUP BY p.Product_Name, s.Sales_Date
HAVING s.Sales_Date BETWEEN '1 July 2017' and '28 August 2017';


SELECT * FROM Product_Sales;



--Quetion 7

DECLARE
    v_Pname Product.Product_Name%TYPE;
    v_Price Product.Product_Price%TYPE;   
CURSOR c3
IS
    SELECT Product_name, Product_Price
    FROM Product
    WHERE Product_Price >
    (SELECT avg(product_price)
    FROM Product)
    GROUP BY Product_name, Product_Price;
BEGIN
       FOR rec IN c3
        LOOP
            v_Pname := rec.Product_name;
            v_Price := rec.Product_Price; 
        
                dbms_output.put_line(v_Pname||CHR(10)||'Price: R'||v_Price||CHR(10)||'------------------------------');
            
        END LOOP;     
EXCEPTION 
        WHEN OTHERS
            THEN dbms_output.put_line('An error occured');
END;
/























