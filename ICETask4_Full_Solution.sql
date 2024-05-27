CREATE TABLE Customer
(
  Cust_ID	        CHAR(4)        NOT NULL,    
  Fname	            VARCHAR2(20)       NOT NULL,
  Sname			    VARCHAR2(20)       NOT NULL,
  Primary_Address   VARCHAR2(20)	   NOT NULL,
  Contact       	VARCHAR2(12)       NOT NULL,
  CONSTRAINT pk_Customer  PRIMARY KEY (Cust_ID)
);

CREATE TABLE Employee
(
  Emp_ID	        CHAR(4)        NOT NULL,   
  Fname	            VARCHAR2(20)       NOT NULL,
  Sname			    VARCHAR2(20)       NOT NULL,
  Contact       	VARCHAR2(12)       NOT NULL,
CONSTRAINT pk_Employee  PRIMARY KEY (Emp_ID)
);

CREATE TABLE Air_Product
(
	Product_ID		 NUMBER(3,0)  NOT NULL, 
	Product_Type  	 VARCHAR2(20) NOT NULL,
	Product_Price    NUMBER(8,2)  NOT NULL,
    CONSTRAINT pk_Air_Product  PRIMARY KEY (Product_ID)
);

CREATE TABLE Sales
(
	Sales_ID NUMBER(5,0) NOT NULL, 
	Sales_Date	DATE NOT NULL, 
	Quantity NUMBER(3,0) NOT NULL, 
	Cust_ID	 CHAR(4) NOT NULL, 
	Emp_ID	CHAR(4)    not null,
	Product_ID	NUMBER(3,0)  		not null,
    CONSTRAINT pk_Sales PRIMARY KEY (Sales_ID),
    CONSTRAINT fk_Cust_Sales FOREIGN KEY (Cust_ID) REFERENCES Customer(Cust_ID),
    CONSTRAINT fk_Emp_Sales FOREIGN KEY (Emp_ID) REFERENCES Employee(Emp_ID),
    CONSTRAINT fk_AP_Sales FOREIGN KEY (Product_ID) REFERENCES Air_Product(Product_ID)
);

INSERT ALL
  INTO CUSTOMER(cust_id, fname, sname, primary_address, contact) VALUES ('A115', 'Patrick', 'Connor', '3 Main Road', '0821253659')
  INTO CUSTOMER(cust_id, fname, sname, primary_address, contact) VALUES ('A116', 'Sally', 'Williams', '13 Cape Road', '0769658547')
  INTO CUSTOMER(cust_id, fname, sname, primary_address, contact) VALUES ('A117', 'Wallace', 'Smith', '3 Mountain Road', '0863256574')
  INTO CUSTOMER(cust_id, fname, sname, primary_address, contact) VALUES ('A118', 'Richard', 'Hanson', '8 Circle Road', '0762356587')
  INTO CUSTOMER(cust_id, fname, sname, primary_address, contact) VALUES ('A119', 'Gary', 'Bitterhout', '15 Main Road', '0821235258')
  INTO CUSTOMER(cust_id, fname, sname, primary_address, contact) VALUES ('A120', 'Thando', 'Zolani', '88 Summer Road', '0847541254')
  INTO CUSTOMER(cust_id, fname, sname, primary_address, contact) VALUES ('A121', 'Philip', 'Jackson', '3 Long Road', '0745556658')
  INTO CUSTOMER(cust_id, fname, sname, primary_address, contact) VALUES ('A122', 'Sarah', 'Jones', '7 Sea Road', '0814745745')
SELECT * FROM DUAL;
COMMIT;
  
INSERT ALL
    INTO EMPLOYEE(emp_id, fname, sname, contact) VALUES ('EMP1', 'Andre', 'Jones',  '0721253659')
    INTO EMPLOYEE(emp_id, fname, sname, contact) VALUES ('EMP2', 'Alan', 'Haslett',  '0869658547')
    INTO EMPLOYEE(emp_id, fname, sname, contact) VALUES ('EMP3', 'Patricia', 'Gumede', '0763256574')
SELECT * FROM DUAL;
COMMIT;

INSERT ALL
  INTO AIR_PRODUCT(product_id, product_type, product_price) VALUES (101,  'Air Conditioner', 1200)
  INTO AIR_PRODUCT(product_id, product_type, product_price) VALUES (102,  'Heater', 800)
  INTO AIR_PRODUCT(product_id, product_type, product_price) VALUES (103, 'Extractor Fan',  1800)
  INTO AIR_PRODUCT(product_id, product_type, product_price) VALUES (104, 'Humidifier', 750)
  INTO AIR_PRODUCT(product_id, product_type, product_price) VALUES (105, 'Dehumidifier', 1500)
SELECT * FROM DUAL;
COMMIT;
  
INSERT ALL
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10111, '03-AUG-23', 1, 'A115', 'EMP3', 101)
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10211, '04-AUG-23', 2, 'A120', 'EMP2', 103)
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10311, '05-AUG-23', 1, 'A118', 'EMP1', 105)
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10411, '05-AUG-23', 1, 'A117', 'EMP2', 103)
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10511, '05-AUG-23', 3, 'A122', 'EMP1', 101)
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10611, '06-AUG-23', 1, 'A115', 'EMP3', 101)
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10711, '07-AUG-23', 1, 'A120', 'EMP1', 103)
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10811, '07-AUG-23', 2, 'A118', 'EMP3', 105)
  INTO SALES(sales_id, sales_date, quantity, cust_id, emp_id, product_id) VALUES (10911, '08-AUG-23', 1, 'A119', 'EMP3', 102)
SELECT * FROM DUAL; 
COMMIT;

-- Question 1

SELECT c.Fname || ', ' || c.Sname AS Customer, ap.Product_Type AS "Product Type"
FROM Sales s JOIN Customer c ON s.Cust_ID = c.Cust_ID
JOIN Air_Product ap ON s.Product_ID = ap.Product_ID
WHERE s.Emp_ID = 'EMP2'
ORDER BY c.Sname ASC;

-- Question 2
SET SERVEROUTPUT ON;
DECLARE
 CURSOR c1
 IS
 SELECT c.cust_id, ap.product_type
 FROM SALES s
 JOIN CUSTOMER c ON s.cust_id = c.cust_id
 JOIN AIR_PRODUCT ap ON s.product_id = ap.product_id;
BEGIN
 FOR sales_rec IN c1 LOOP
 DBMS_OUTPUT.PUT_LINE('CUSTOMER ID: ' || sales_rec.cust_id);
 DBMS_OUTPUT.PUT_LINE('PRODUCT TYPE: ' || sales_rec.product_type);
 DBMS_OUTPUT.PUT_LINE('----------------------------');
 END LOOP;
END;
/

-- Question 3
SET SERVEROUTPUT ON;
DECLARE
 total_sales NUMBER(10,2);
CURSOR c1 
IS
SELECT c.fname || ' ' || c.sname AS Customer,
 e.fname || ' ' || e.sname AS Employee,
 ap.Product_Type AS Product,
 s.Sales_Date AS SalesDate,
 s.Quantity * ap.Product_Price AS Total
 FROM Sales s
 JOIN Customer c ON s.Cust_ID = c.Cust_ID
 JOIN Employee e ON s.Emp_ID = e.Emp_ID
 JOIN Air_Product ap ON s.Product_ID = ap.Product_ID
 WHERE s.Cust_ID = 'A117';
 v_rec c1%ROWTYPE;
BEGIN
 FOR v_rec IN c1
 LOOP
     DBMS_OUTPUT.PUT_LINE('CUSTOMER: ' || v_rec.Customer||CHR(10)||
     'EMPLOYEE: ' || v_rec.Employee||CHR(10)||
     'PRODUCT: ' || v_rec.Product||CHR(10)||
     'SALES DATE: ' || TO_CHAR(v_rec.SalesDate, 'DD-MON-YY')||CHR(10)||
     'TOTAL: R ' || v_rec.Total||CHR(10)||
     '--------------------------');
 END LOOP;
END;
/

-- Question 4

CREATE OR REPLACE VIEW vwCustomerSales 
AS
    SELECT c.fname || ', ' || c.Sname AS "CUSTOMER",
     ap.Product_Type AS "SERVICE TYPE",
     s.Sales_Date AS "INVOICE DATE"
    FROM Sales s
    JOIN Customer c ON s.Cust_ID = c.Cust_ID
    JOIN Air_Product ap ON s.Product_ID = ap.Product_ID
    WHERE s.Cust_ID = 'A115';

SELECT * FROM vwCustomerSales;

-- Question 5

CREATE OR REPLACE PROCEDURE spEmployeeDetails(p_emp_id IN VARCHAR2) AS
 emp_contact EMPLOYEE.contact%TYPE; 
 CURSOR c1 
 IS
  SELECT contact
  FROM EMPLOYEE WHERE emp_id = p_emp_id;
BEGIN
FOR rec IN c1
    LOOP
     emp_contact := rec.contact;

                dbms_output.put_line('EMPLOYEE DETAILS >> ID: ' || p_emp_id || ', CONTACT: ' || emp_contact);

    END LOOP;
    IF emp_contact IS NULL THEN
                dbms_output.put_line('No employee data found for ID: ' || p_emp_id); 
    END IF;
EXCEPTION
 WHEN OTHERS THEN
     RAISE_APPLICATION_ERROR(-20191, 'An error occured -'||SQLCODE||'-ERROR-'||SQLERRM);
END; 
/


BEGIN
 spEmployeeDetails('EMP156');
END;
/

EXEC spEmployeeDetails('EMP3');

/*
--5.2 THEORY:
Number: Values that store fixed?point or floating?point numbers. 
Example 120 and 187.50. 
Character: Values that represent single characters or strings of characters,
which you can manipulate.  
Example 'c' and '5'. 
BOOLEAN: Values in which you can perform logical operations.  
Examples 'AND' and '='.
Datetime: Values that let you store and manipulate dates and time.
Example 16-05-2018.
Interval: Time interval values with which you can manipulate data.  
Example 'INTERVAL YEAR TO MONTH'.
*/
-- Question 6

CREATE OR REPLACE FUNCTION fnCustomerSales(v_sales_id IN NUMBER) RETURN 
VARCHAR2 
AS
 customer_details VARCHAR2(100);
BEGIN
     SELECT 'CUSTOMER SALES DETAILS: '||c.fname || ', ' || c.sname || ', ' || ap.product_type || ', ' || s.sales_date INTO customer_details
     FROM SALES s
     JOIN CUSTOMER c ON s.cust_id = c.cust_id
     JOIN AIR_PRODUCT ap ON s.product_id = ap.product_id
     WHERE s.Sales_ID = v_sales_id;
     RETURN  customer_details;
     EXCEPTION
WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR(-20199,'No Data was found for the supplied Customer'|| v_sales_id);
END;
/

--Calling the fuction from a Select statement

SELECT fnCustomerSales(10111) AS Details
FROM DUAL;
/

--or

DECLARE
v_Result VARCHAR2(100);
BEGIN
 SELECT fnCustomerSales(10111) INTO v_Result
 FROM DUAL;
 dbms_output.put_line(v_Result);
END;
/

/*
--6.2 Theory
IF-THEN: The IF?THEN statement contains an expression to be
evaluated and one or more actions to be performed, if the result of the
expression is TRUE.
IF-THEN-ELSE: The IF?THEN?ELSE statement allows a choice between
two actions based on the evaluation of an expression.
IF-THEN-ELSIF: To introduce additional conditions, where you can
choose between several alternatives, the keyword ELSIF is used.
*/

--QED

--Practicum Type Questions
--SQL Statement
--View
--Anonymous Block
--Stored Procedure with Parameters
--Function with Parameters
--Trigger
--Exception Handling
--Decision Logic
--External Programs
--Excel Preload --> Extract-Transform-Load










