--Question 1

--Create a customer table

CREATE TABLE CUSTOMER(
CUSTOMER_ID CHAR(5) NOT NULL,
FIRST_NAME VARCHAR2(10) NOT NULL,
SURNAME VARCHAR(20) NOT NULL,
ADDRESS VARCHAR(30) NOT NULL,
CONTACT_NUMBER CHAR(10) NOT NULL,
EMAIL VARCHAR(20) NOT NULL,
CONSTRAINT PK_Customer PRIMARY KEY(CUSTOMER_ID)
);

--Create a Employee table

CREATE TABLE EMPLOYEE(
EMPLOYEE_ID VARCHAR2(6) NOT NULL,
FIRST_NAME VARCHAR2(10) NOT NULL,
SURNAME VARCHAR2(20) NOT NULL,
CONTACT_NUMBER CHAR(10) NOT NULL,
ADDRESS VARCHAR2(30) NOT NULL,
EMAIL VARCHAR2(20) NOT NULL,
CONSTRAINT PK_Employee PRIMARY KEY(EMPLOYEE_ID)
);

--Create Donator table

CREATE TABLE DONATOR(
DONATOR_ID CHAR(5) NOT NULL,
FIRST_NAME VARCHAR(10) NOT NULL,
SURNAME VARCHAR(20) NOT NULL,
CONTACT_NUMBER CHAR(20) NOT NULL,
EMAIL VARCHAR(30) NOT NULL,
CONSTRAINT PK_Donator PRIMARY KEY(DONATOR_ID)
);

--Create Donation Table

CREATE TABLE DONATION(
DONATION_ID CHAR(6) NOT NULL,
DONATOR_ID CHAR(5) NOT NULL,
DONATION VARCHAR(40) NOT NULL,
PRICE DECIMAL(10,2) NOT NULL,
DONATION_DATE DATE NOT NULL,
CONSTRAINT PK_Donation PRIMARY KEY(DONATION_ID),
CONSTRAINT FK_Donation_Donator FOREIGN KEY(DONATOR_ID) REFERENCES DONATOR(DONATOR_ID)
);

--Create Delivery Table

CREATE TABLE DELIVERY(
DELIVERY_ID CHAR(3) NOT NULL,
DELIVERY_NOTE VARCHAR2(100) NOT NULL,
DISPATCH_DATE DATE NOT NULL,
DELIVERY_DATE DATE NOT NULL,
CONSTRAINT PK_Delivery PRIMARY KEY(DELIVERY_ID)
);

--Create Return Table

CREATE TABLE RETURNS(
RETURN_ID VARCHAR2(6) NOT NULL,
RETURN_DATE DATE NOT NULL,
REASON VARCHAR2(100) NOT NULL,
CUSTOMER_ID CHAR(5) NOT NULL,
DONATION_ID CHAR(6) NOT NULL,
EMPLOYEE_ID VARCHAR2(6) NOT NULL,
CONSTRAINT PK_Returns PRIMARY KEY(RETURN_ID),
CONSTRAINT FK_CUSTOMER_RETURNS FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
CONSTRAINT FK_DONATION_RETURNS FOREIGN KEY(DONATION_ID) REFERENCES DONATION(DONATION_ID),
CONSTRAINT FK_EMPLOYEE_RETURNS FOREIGN KEY(EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID)
);

--Create Invoice Table 

CREATE TABLE INVOICE(
INVOICE_NUM CHAR(4) NOT NULL,
CUSTOMER_ID CHAR(5) NOT NULL,
INVOICE_DATE DATE NOT NULL,
EMPLOYEE_ID VARCHAR2(6) NOT NULL,
DONATION_ID CHAR(6) NOT NULL,
DELIVERY_ID CHAR(3) NOT NULL,
CONSTRAINT PK_INVOICE PRIMARY KEY(INVOICE_NUM),
CONSTRAINT FK_INVOICE_CUSTOMER FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
CONSTRAINT FK_INVOICE_DONATION FOREIGN KEY(DONATION_ID) REFERENCES DONATION(DONATION_ID),
CONSTRAINT FK_INVOICE_EMPLOYEE FOREIGN KEY(EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID),
CONSTRAINT FK_INVOICE_DELIVERY FOREIGN KEY(DELIVERY_ID) REFERENCES DELIVERY(DELIVERY_ID)
);

--Insert into Customers
INSERT ALL
    INTO CUSTOMER VALUES('11011','Jack','Smith','18 Water Rd','0877277521','jsmith@isat.com')
    INTO CUSTOMER VALUES('11012','Pat','Hendricks','22 Water Rd','0863257851','ph@mcom.co.za')
    INTO CUSTOMER VALUES('11013','Andre','Clark','101 Summer Lane','0834567891','aclark@mcom.co.za')
    INTO CUSTOMER VALUES('11014','Kevin','Jones','55 Montain Way','0612547895','kj@isat.co.za')
    INTO CUSTOMER VALUES('11015','Lucy','Williams','5 Main Rd','0827238521','kw@mcal.co.za')
select * FROM DUAL;

--Insert into Employee
INSERT ALL
 INTO EMPLOYEE VALUES('emp101','Jeff','Davis','0877277521','10 Main road','jand@isat.com')
 INTO EMPLOYEE VALUES('emp102','Kevin','Marks','0837377522','18 Water road','km@isat.com')
 INTO EMPLOYEE VALUES('emp103','Adanya','Andrews','0817117522','21 Ciricle lane','aa@isat.com')
 INTO EMPLOYEE VALUES('emp104','Adebayo','Dryer','0797215244','1 Sea Road','aryer@isat.com')
 INTO EMPLOYEE VALUES('emp105','Xolani','Samson','0827122255','12 Main road','xosam@isat.com')
SELECT * FROM DUAL;

--Insert into Donator
INSERT ALL
 INTO DONATOR VALUES('20111','Jeff','Watson','0827172250','jwatson@ymail.com')
 INTO DONATOR VALUES('20112','Stephen','Jones','0837865670','joness@ymail.com')
 INTO DONATOR VALUES('20113','James','Joe','0878978650','jj@isat.com')
 INTO DONATOR VALUES('20114','Kelly','Ross','0826575650','kross@gasl.com')
 INTO DONATOR VALUES('20115','Abraham','Clark','0797656490','aclark@ymail.com')
SELECT * FROM DUAL;

--Insert into Donation
INSERT ALL
 INTO DONATION VALUES('7111','20111','KIC Fridge',599,'1/May/2024')
 INTO DONATION VALUES('7112','20112','Samsung 42 inch LCD',1299,'3/May/2024')
 INTO DONATION VALUES('7113','20113','Sharp Microwave',1599,'3/May/2024')
 INTO DONATION VALUES('7114','20115','6 Seat Dining room table',799,'5/May/2024')
 INTO DONATION VALUES('7115','20114','Lazyboy Sofa',1199,'7/May/2024')
 INTO DONATION VALUES('7116','20113','JUV Surround Sound System',179,'9/May/2024')
SELECT *  FROM DUAL;

--Insert into Delivery
INSERT ALL
 INTO DELIVERY VALUES('511','Double packing requested','10/May/2024','15/May/2024')
 INTO DELIVERY VALUES('512','Delivery to work address','12/May/2024','15/May/2024')
 INTO DELIVERY VALUES('513','No Notes','12/May/2024','17/May/2024')
 INTO DELIVERY VALUES('514','Signature Requierd','12/May/2024','15/May/2024')
 INTO DELIVERY VALUES('515','Birthday presnt wrapping required','18/May/2024','19/May/2024')
 INTO DELIVERY VALUES('516','Delivery to work address','20/May/2024','25/May/2024')
SELECT *  FROM DUAL;

-- Insert into Returns
INSERT ALL
 INTO RETURNS VALUES('ret001','25/May/2024','Customer not satisfied with product','11011','7116','emp101')
 INTO RETURNS VALUES('ret002','25/May/2024','Product had broken section','11013','7114','emp103')
SELECT *  FROM DUAL;

--Insert into Invoice
INSERT ALL
 INTO INVOICE VALUES('8111','11011','15/May/2024','emp103','7111','511')
 INTO INVOICE VALUES('8112','11013','15/May/2024','emp101','7114','512')
 INTO INVOICE VALUES('8113','11012','17/May/2024','emp101','7112','513')
 INTO INVOICE VALUES('8114','11015','17/May/2024','emp102','7113','514')
 INTO INVOICE VALUES('8115','11011','17/May/2024','emp102','7115','515')
 INTO INVOICE VALUES('8116','11015','18/May/2024','emp103','7116','516')
SELECT * FROM DUAL;

--QUESTION 2

SELECT c.first_name||', '||c.surname AS CUSTOMER,
e.employee_id,
d.delivery_note,
do.donation,
i.invoice_num,
i.invoice_date
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id
JOIN employee e ON i.employee_id = e.employee_id
JOIN delivery d ON i.delivery_id = d.delivery_id
JOIN donation do ON i.donation_id = do.donation_id
WHERE i.invoice_date < '18-MAY-2024';

--Question 3 Option 1

CREATE TABLE Funding (
Funding_ID NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
Funder VARCHAR2(30) NOT NULL,
Funding_Amt DECIMAL(10,2) NOT NULL,
CONSTRAINT PK_FUNDING_ID PRIMARY KEY(Funding_ID)
);

INSERT INTO Funding (Funder, Funding_Amt) VALUES ('New Funder1', 1000.00);
INSERT INTO Funding (Funder, Funding_Amt) VALUES ('New Funder2', 2000.00);
INSERT INTO Funding (Funder, Funding_Amt) VALUES ('New Funder3', 3000.00);

SELECT * FROM Funding;

DROP TABLE Funding;

--Question 3 Option 2

CREATE TABLE Funding (
Funding_ID NUMBER,
Funder VARCHAR2(30) NOT NULL,
Funding_Amt DECIMAL(10,2) NOT NULL,
CONSTRAINT PK_Funding_ID PRIMARY KEY(Funding_ID)
);

CREATE SEQUENCE seq_Funding_ID
START WITH 1
INCREMENT BY 1
MINVALUE 1
NOMAXVALUE
CACHE 10;
/
--tEST
INSERT INTO Funding VALUES (seq_Funding_ID.NEXTVAL,'New Funder1', 1000.00);
INSERT INTO Funding VALUES (seq_Funding_ID.NEXTVAL,'New Funder2', 2000.00);
INSERT INTO Funding VALUES (seq_Funding_ID.NEXTVAL,'New Funder3', 3000.00);

SELECT * FROM Funding;

--QUESTION 4

SET SERVEROUTPUT ON;
DECLARE
    v_firstName customer.First_name%TYPE;
    v_surname customer.surname%TYPE;
    v_donation donation.donation%TYPE;
    v_price donation.price%TYPE;
    v_reason returns.reason%TYPE;

CURSOR c1
    IS
    SELECT c.First_name, c.surname, d.donation, d.price, r.reason
    FROM customer c 
    INNER JOIN returns r on r.customer_id = c.customer_id
    INNER JOIN donation d on d.donation_id = r.donation_id;
BEGIN
    FOR rec IN c1
    LOOP 
        v_firstName := rec.First_Name;
        v_surname := rec.surname;
        v_donation := rec.donation;
        v_price := rec.price;
        v_reason := rec.reason;
        
        dbms_output.put_line('Customer:             '||v_firstName||', '||v_surname||CHR(10)
        ||'DONATION PURCHASED:   '||v_donation||CHR(10)||
        'PRICE:                R:'||v_price||CHR(10)||
        'RETURN REASON:        '||v_reason||CHR(10)||
        '---------------------------------------------');
    END LOOP;
END;
/

--QUESTION 5
DECLARE
    v_firstName customer.First_Name%TYPE;
    v_surname customer.surname%TYPE;
    v_eFirstName employee.First_Name%TYPE;  
    v_eSurname employee.Surname%TYPE;    
    v_donation donation.donation%TYPE;
    v_dispatch  delivery.dispatch_date%TYPE;
    v_delivery delivery.delivery_date%TYPE;
    v_days NUMBER; 

CURSOR c2 
IS
    SELECT c.first_name AS cusName,c.surname cusSurname,e.first_name,e.surname,d.donation,de.dispatch_date,de.delivery_date
    FROM customer c
    INNER JOIN invoice i ON i.customer_id = c.customer_id
    INNER JOIN employee e ON e.employee_id = i .employee_id
    INNER JOIN donation d ON d.donation_id = i.donation_id
    INNER JOIN delivery de ON  de.delivery_id = i.delivery_id
    WHERE c.customer_id ='11013';

BEGIN
 FOR rec IN c2
     LOOP 
     v_firstName := rec.cusName;
     v_surname := rec.cusSurname;
     v_eFirstName := rec.First_Name;
     v_eSurname := rec.surname;
     v_donation :=rec.donation;
     v_dispatch := rec.dispatch_date;
     v_delivery := rec.delivery_date;
     
    dbms_output.put_line(
    'CUSTOMER:          '||substr(v_firstName,1,1)||'.'||v_surname||CHR(10)||
    'EMPLOYEE:          '||substr(v_efirstname,1,1)||'.'||v_esurname||CHR(10)||
    'DONATION:          '||v_donation||CHR(10)||
    'DISPATCH DATE:     '||v_dispatch||CHR(10)||
    'DELIVERY DATE:     '||v_delivery||CHR(10)||
    'DAYS TO DELIVER:   '||(v_delivery-v_dispatch));
END LOOP;
END;
/

--QUESTION 6
SET SERVEROUTPUT ON;

DECLARE
    v_firstName customer.first_name%TYPE;
    v_surname customer.surname%TYPE;
    v_amount DECIMAL(10,2);
    v_rating VARCHAR2(20);
    v_output VARCHAR2(1000);
    
    CURSOR c_customers IS
        SELECT 
            c.first_name, 
            c.surname, 
            SUM(d.price) AS total_amount
        FROM 
            customer c
        INNER JOIN 
            invoice i ON c.customer_id = i.customer_id
        INNER JOIN 
            donation d ON i.donation_id = d.donation_id
        GROUP BY 
            c.first_name, c.surname;

BEGIN
    FOR rec IN c_customers LOOP
        v_firstName := rec.first_name;
        v_surname := rec.surname;
        v_amount := rec.total_amount;
        
        IF v_amount >= 1500 THEN
            v_rating := '(*)';
        ELSE
            v_rating := '';
        END IF;
        
        v_output := 'FIRST NAME: ' || v_firstName || CHR(10) ||
                    'SURNAME: ' || v_surname || CHR(10) ||
                    'AMOUNT: R ' || v_amount || ' ' || v_rating || CHR(10) ||
                    '--------------------------------------------';
        
        DBMS_OUTPUT.PUT_LINE(v_output);
    END LOOP;
END;
/

--QUESTION 7

--Q.7.1 %TYPE Attribute:

DECLARE
    v_customer_name CUSTOMER.FIRST_NAME%TYPE;
    v_customer_address CUSTOMER.ADDRESS%TYPE;
BEGIN
    -- Assign values to variables using %TYPE attribute
    SELECT FIRST_NAME, ADDRESS INTO v_customer_name, v_customer_address
    FROM CUSTOMER
    WHERE CUSTOMER_ID = '11011';
    
    -- Display the retrieved customer name and address
    DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_customer_name);
    DBMS_OUTPUT.PUT_LINE('Customer Address: ' || v_customer_address);
END;
/


--Q.7.2 %ROWTYPE Attribute:
DECLARE
    v_customer_rec CUSTOMER%ROWTYPE;
BEGIN
    -- Fetch a row from the CUSTOMER table into the record variable
    SELECT *
    INTO v_customer_rec
    FROM CUSTOMER
    WHERE CUSTOMER_ID = '11012';

    -- Display the fetched customer record
    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_rec.CUSTOMER_ID);
    DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_customer_rec.FIRST_NAME || ' ' || v_customer_rec.SURNAME);
    DBMS_OUTPUT.PUT_LINE('Customer Address: ' || v_customer_rec.ADDRESS);
END;
/

--Q.7.3 System Defined Exception:
--A System defined exception is handled implicitly raised by the Oracle compiler and they is no need for the user to explicitly raise the exception
--However a user can defined custom error messages when handling the exception

DECLARE
    v_customer_name CUSTOMER.FIRST_NAME%TYPE;
BEGIN
    -- Attempt to fetch a customer name with a non-existent customer ID
    SELECT FIRST_NAME
    INTO v_customer_name
    FROM CUSTOMER
    WHERE CUSTOMER_ID = '99999';
EXCEPTION
    -- Handle the NO_DATA_FOUND exception
    WHEN NO_DATA_FOUND THEN
        --DBMS_OUTPUT.PUT_LINE('Customer not found.');
        RAISE_APPLICATION_ERROR(-20199,'Custom Message');
        
END;
/

--Q.7.4 User Defined Exception:
--AUser defined exception must be explicitly declared, raised and handled by the user depending on the required business logic
DECLARE
    -- Define a custom exception
    ex_custom_exception EXCEPTION;
    
    v_customer_id CUSTOMER.CUSTOMER_ID%TYPE := '11013'; -- Existing customer ID
BEGIN
    -- Check if the customer ID exists
    SELECT 'Y'
    INTO v_customer_id
    FROM CUSTOMER
    WHERE CUSTOMER_ID = v_customer_id;

    -- If the customer ID doesn't exist, raise the custom exception
    IF v_customer_id IS NULL THEN
        RAISE ex_custom_exception;
    END IF;
EXCEPTION
    -- Handle the custom exception
    WHEN ex_custom_exception THEN
        DBMS_OUTPUT.PUT_LINE('Custom exception: Customer ID not found.');
END;
/