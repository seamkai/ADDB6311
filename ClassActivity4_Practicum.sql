--Question 1

--DROP TABLE SALES CASCADE CONSTRAINTS PURGE;
--DROP TABLE CUSTOMER CASCADE CONSTRAINTS PURGE;
--DROP TABLE REPAIRS CASCADE CONSTRAINTS PURGE;
--DROP TABLE STOCK CASCADE CONSTRAINTS PURGE;

CREATE TABLE Stock (
    Stock_ID CHAR(5) NOT NULL,
    Stock_Type VARCHAR2(20) NOT NULL,
    Stock_Model VARCHAR2(20) NOT NULL,
    Manufacturer VARCHAR2(20) NOT NULL,
    CONSTRAINT  Pk_Stock PRIMARY KEY(Stock_ID)
);

SELECT * FROM Stock;

CREATE TABLE Customer
(
    Customer_ID CHAR(4) NOT NULL,
    Cust_Fname VARCHAR2(30) NOT NULL,
    Cust_Sname VARCHAR2(30) NOT NULL,
    Cust_Address VARCHAR2(30) NOT NULL,
    Cust_Contact CHAR(10) NOT NULL,
    CONSTRAINT PK_Customer PRIMARY KEY (Customer_ID)
);

SELECT * FROM Customer;

CREATE TABLE Repairs 
(
    Repair_ID INT NOT NULL,
    Repair_Work VARCHAR2(100) NOT NULL,
    Repair_Date DATE NOT NULL,
    Repair_Hours INT NOT NULL,
    CONSTRAINT Pk_Repairs PRIMARY KEY(Repair_ID)
);

SELECT * FROM Repairs;

CREATE TABLE SALES
(
    Sales_Num INT NOT NULL,
    Sales_Date DATE NOT NULL,
    Sales_Amount DECIMAL(10,2) NOT NULL,
    Stock_ID CHAR(5) NOT NULL,
    Customer_ID CHAR(4) NOT NULL,
    Repair_ID INT NOT NULL,
    CONSTRAINT PK_Sales PRIMARY KEY (Sales_Num),
    CONSTRAINT FK_Stock_Sales FOREIGN KEY (Stock_ID) REFERENCES Stock(Stock_ID),
    CONSTRAINT FK_Customer_Sales FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID),
    CONSTRAINT FK_Repair_Sales FOREIGN KEY(Repair_ID) REFERENCES Repairs(Repair_ID)
);

SELECT * FROM Sales;

--Perform an ETL - (Extract-Transform-Load) Data import from the Excel file to load your table data.

--Question 2

SELECT c.Cust_Fname||', '||c.Cust_Sname as Customer, r.Repair_Work, r.Repair_Date, r.Repair_Hours
FROM Sales s INNER JOIN Customer c ON s.Customer_ID = c.Customer_ID
INNER JOIN Repairs r ON r.Repair_ID = s.Repair_ID
INNER JOIN Stock st ON s.Stock_ID = st.Stock_ID
WHERE  r.Repair_Hours <= 3;

--Question 3

SET SERVEROUTPUT ON;
DECLARE
CURSOR c1 
    IS
    SELECT c.Customer_ID, st.Stock_Type, s.sales_amount
    FROM Sales s INNER JOIN Customer c ON s.Customer_ID = c.Customer_ID
    INNER JOIN Repairs r ON r.Repair_ID = s.Repair_ID
    INNER JOIN Stock st ON s.Stock_ID = st.Stock_ID
    WHERE  s.Sales_Amount <= 1500;
    
v_rec c1%ROWTYPE;

BEGIN 
    FOR v_rec IN c1
    LOOP 
    dbms_output.put_line('Customer '||v_rec.Customer_ID);
    dbms_output.put_line('Stock_Type '||v_rec.Stock_Type);
    dbms_output.put_line('Amount  R:'||v_rec.Sales_Amount);
    dbms_output.put_line('---------------------------------');
    END LOOP;
END;
/

--Question 4

DECLARE
CURSOR c1 
    IS
    SELECT c.Customer_ID, st.Stock_id, s.sales_amount, s.sales_num, r.repair_id
    FROM Sales s INNER JOIN Customer c ON s.Customer_ID = c.Customer_ID
    INNER JOIN Repairs r ON r.Repair_ID = s.Repair_ID
    INNER JOIN Stock st ON s.Stock_ID = st.Stock_ID;
    v_rec c1%ROWTYPE;

   BEGIN 
    FOR v_rec IN c1
    LOOP 
        IF v_rec.sales_amount <= 9999 THEN
            dbms_output.put_line('Customer '||v_rec.Customer_ID||chr(10)||'Stock_Type '||v_rec.Stock_id||chr(10)||'Amount  R:'||v_rec.Sales_Amount
            ||chr(10)||'Sales Number  '||v_rec.sales_num||chr(10)||'Repair ID:'||v_rec.repair_id||chr(10)||'Commission  R:'||v_rec.Sales_Amount*0.05
            ||chr(10)||'---------------------------------');
        ELSIF v_rec.sales_amount >= 1000 and v_rec.sales_amount <= 1499 THEN
            dbms_output.put_line('Customer '||v_rec.Customer_ID||chr(10)||'Stock_Type '||v_rec.Stock_id||chr(10)||'Amount  R:'||v_rec.Sales_Amount
            ||chr(10)||'Sales Number  '||v_rec.sales_num||chr(10)||'Repair ID:'||v_rec.repair_id||chr(10)||'Commission  R:'||v_rec.Sales_Amount*0.1
            ||chr(10)||'---------------------------------');
        ELSE
            dbms_output.put_line('Customer '||v_rec.Customer_ID||chr(10)||'Stock_Type '||v_rec.Stock_id||chr(10)||'Amount  R:'||v_rec.Sales_Amount
            ||chr(10)||'Sales Number  '||v_rec.sales_num||chr(10)||'Repair ID:'||v_rec.repair_id||chr(10)||'Commission  R:'||v_rec.Sales_Amount*0.15
            ||chr(10)||'---------------------------------');
        END IF;
    END LOOP;   
END;
/ 

--Question 5

CREATE OR REPLACE VIEW Repair_View
AS
    SELECT c.Cust_Fname||', '||c.Cust_Sname as Customer, st.Stock_ID, r.Repair_Work, r.Repair_Date
    FROM Sales s INNER JOIN Customer c ON s.Customer_ID = c.Customer_ID
    INNER JOIN Repairs r ON r.Repair_ID = s.Repair_ID
    INNER JOIN Stock st ON s.Stock_ID = st.Stock_ID;
    
    SELECT * FROM Repair_View;
    
--Question 6
    
CREATE OR REPLACE TRIGGER Sales_Entry
    BEFORE INSERT OR UPDATE of Sales_Amount ON Sales
    FOR EACH ROW
    BEGIN
    IF :New.Sales_Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20999, 'Sale Amount cannot be less than zero.');
        end if;
    END;
    /
    
SELECT * FROM Sales;

INSERT INTO SALES VALUES(110,'27-Jul-2023',0,98754,'C121', 3);


--Question 7

CREATE OR REPLACE PROCEDURE sp_Customer_Details(v_sales_ID NUMBER)
IS 
CURSOR c1 IS
    SELECT c.Customer_ID, c.Cust_Fname||', '||c.Cust_Sname as Customer, c.Cust_Contact
    FROM Sales s INNER JOIN Customer c ON s.Customer_ID = c.Customer_ID
    INNER JOIN Repairs r ON r.Repair_ID = s.Repair_ID
    INNER JOIN Stock st ON s.Stock_ID = st.Stock_ID
    where s.sales_num = v_sales_ID;
    v_rec c1%ROWTYPE;
BEGIN
FOR v_rec in c1
    LOOP
        dbms_output.put_line('Customer '||v_rec.Customer);
        dbms_output.put_line('Contact '||v_rec.Cust_Contact);
        dbms_output.put_line('Customer_ID :'||v_rec.Customer_ID);
        dbms_output.put_line('---------------------------------');
    END LOOP;
END;
/

EXEC sp_Customer_Details(101);

--Question 8

CREATE OR REPLACE FUNCTION FN_it_Gear(v_SaleID number)
RETURN VARCHAR
IS 
CURSOR c1 IS
    SELECT c.Customer_ID, c.Cust_Fname||', '||c.Cust_Sname as Customer, c.Cust_Contact, r.Repair_Work, r.Repair_Date
    FROM Sales s INNER JOIN Customer c ON s.Customer_ID = c.Customer_ID
    INNER JOIN Repairs r ON r.Repair_ID = s.Repair_ID
    INNER JOIN Stock st ON s.Stock_ID = st.Stock_ID
    where s.sales_num = v_SaleID;
    v_rec c1%ROWTYPE;
    v_message VARCHAR2(200);
BEGIN
FOR v_rec IN c1
LOOP 

        v_message:= 'Customer '||v_rec.Customer||' contact number '||v_rec.Cust_Contact||' had repairs for '||v_rec.Repair_Work||' on  '||v_rec.Repair_Date;

END LOOP;
IF v_message IS NULL THEN
v_message := 'No Data was found for the supplied Customer';
END IF;
RETURN v_message;
EXCEPTION WHEN NO_DATA_FOUND  
THEN
    --RAISE_APPLICATION_ERROR(-20199,'No Data was found for the supplied Customer');
    dbms_output.put_line('No Data was found for the supplied Customer');
END;
/

--Exectuting the Function

--Customer ID 101

SELECT FN_it_Gear(101) AS Details
FROM dual; 

--No Customer ID 120

SELECT FN_it_Gear(120) AS Details
FROM dual; 

--Quite easily done!!!!