ALTER SESSION SET "_ORACLE_SCRIPT"=true;
SET SERVEROUTPUT ON;

--Question 2

--DROP TABLE Kayak_Upgrades;
--DROP TABLE Kayaks;
--DROP TABLE Customer;
--DROP TABLE Upgrades;

CREATE TABLE Kayaks 
( 
Kayak_ID CHAR(5) NOT NULL, 
Kayak_Type VARCHAR2(50) NOT NULL, 
Kayak_Model VARCHAR2(50) NOT NULL, 
Manufacturer VARCHAR2(50) NOT NULL, 
CONSTRAINT PK_Kayaks PRIMARY KEY (Kayak_ID) 
); 

CREATE TABLE Customer 
( 
Cust_ID CHAR(4) NOT NULL, 
Cust_Fname VARCHAR2(50) NOT NULL, 
Cust_Sname VARCHAR2(50) NOT NULL, 
Cust_Address VARCHAR2(50) NOT NULL, 
Cust_contact VARCHAR2(50) NOT NULL, 
CONSTRAINT PK_Customer PRIMARY KEY (Cust_ID) 
); 

CREATE TABLE Upgrades 
( 
Upgrade_ID INT NOT NULL, 
Upgrade_Work VARCHAR2(50) NOT NULL, 
Upgrade_Date DATE NOT NULL, 
Upgrade_Hrs INT NOT NULL, 
CONSTRAINT PK_Upgrades PRIMARY KEY (Upgrade_ID)
);

CREATE TABLE Kayak_Upgrades 
( 
 Kayak_Upgrade_Num INT NOT NULL, 
 Kayak_Upgrade_Date DATE NOT NULL, 
 Kayak_Upgrade_Amt DECIMAL(10,2) NOT NULL, 
 Kayak_ID CHAR(5) NOT NULL, 
 Cust_ID CHAR(4) NOT NULL, 
 Upgrade_ID INT NOT NULL, 
 CONSTRAINT PK_Kayak_Upgrades PRIMARY KEY (Kayak_Upgrade_num), 
 CONSTRAINT FK_Kayak_ID FOREIGN KEY(Kayak_ID) REFERENCES Kayaks(Kayak_ID), 
 CONSTRAINT FK_Cust_ID FOREIGN KEY (Cust_ID) REFERENCES Customer(Cust_ID), 
 CONSTRAINT FK_Upgrade_ID FOREIGN KEY (Upgrade_ID) REFERENCES Upgrades(Upgrade_ID) 
);

INSERT ALL
    INTO Kayaks VALUES('12345','Single Seater','K100','FeelFree') 
    INTO Kayaks VALUES('54321','Tandem Seater','J55','Roamer') 
    INTO Kayaks VALUES('78945','Fishing Kayak','H9000','Wavesport') 
    INTO Kayaks VALUES('98754','Hobie Kayak','A450','Gemini')
    INTO Kayaks VALUES('55311','Canadian Style','L920','Surge')
    INTO Customer VALUES('C115','Jeff','Willis','3 Main Road','0821253659')
    INTO Customer VALUES('C116','Andre','Watson','13 Cape Road','0769658547') 
    INTO Customer VALUES('C117','Wallis','Smith','3 Mountain Road','0863256574') 
    INTO Customer VALUES('C118','Alex','Hanson','8 Circle Road','0762356587') 
    INTO Customer VALUES('C119','Bob','Bitterhout','15 Main Road','0821235258') 
    INTO Customer VALUES('C120','Thando','Zolani','88 Summer Road','0847541254') 
    INTO Customer VALUES('C121','Philip','Jackson','3 Long Road','0745556658') 
    INTO Customer VALUES('C122','Sarah','Jones','7 Sea Road','0814745745') 
    INTO Upgrades VALUES('1','Sonar Device','15/JUL/22','5') 
    INTO Upgrades VALUES('2','Padded Seats','18/JUL/22','3') 
    INTO Upgrades VALUES('3','GoPro Camera Mount','19/JUL/22','10') 
    INTO Kayak_Upgrades VALUES('101','27/JUL/19','75','98754','C121','3') 
    INTO Kayak_Upgrades VALUES('102','20/JUL/19','30','12345','C120','2') 
    INTO Kayak_Upgrades VALUES('103','23/JUL/19','75','55311','C119','1') 
    INTO Kayak_Upgrades VALUES('104','17/JUL/19','50','54321','C117','1') 
    INTO Kayak_Upgrades VALUES('105','19/JUL/19','30','12345','C122','2')
SELECT * FROM DUAL;

SELECT * FROM Kayaks;
SELECT * FROM Customer;
SELECT * FROM Upgrades;
SELECT * FROM Kayak_Upgrades;


--Question 3.1

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER Tshepo IDENTIFIED BY tmphoabc2023; 
GRANT SELECT ANY TABLE TO Tshepo; 
GRANT INSERT ANY TABLE TO Tshepo; 

CREATE USER Mya IDENTIFIED BY mrobertabc2023; 
GRANT SELECT ANY TABLE TO Mya; 
GRANT INSERT ANY TABLE TO Mya;

/* Q.3.2 Example 1
The separation of duties ensures that no single individual has complete 
control over critical tasks within an organization. By dividing 
responsibilities among different users or roles, it prevents fraud, 
detects errors, enhances accountability, and ensures compliance with 
regulations. This practice introduces checks and balances, promoting 
security and integrity in organizational operations.
*/

/* Q.3.2 Example 2
The separation of roles in database management is critical for ensuring the security
and integrity of organizational data. Organizations can improve security measures and
reduce risks associated with unauthorized access or malicious activity by delegating 
particular roles to distinct users. This segmentation guarantees that functions like 
as database management, data entry, and data verification are carried out by separate 
personnel with appropriate privileges, preventing any single user from exercising 
disproportionate control over the system. Furthermore, the division of roles protects 
against fraud and errors by creating checks and balances inside the system. For example, 
splitting data entry and verification duties decreases the possibility of fraudulent or
inadvertent errors being undetected.Overall, the separation of roles is crucial for 
increasing the reliability, accuracy, and trustworthiness of database systems in businesses.
*/

/* Q.3.2 Example 2
Separation of duties helps reduce the risk of unauthorized access and
misuse of sensitive data by limiting user rights to only those necessary
for specific tasks.
Organizations can reduce security threats by adhering to the principle
of least privilege by assigning different roles to different users.--
*/
/* Q.3.2 Example 2
Separation of duties is important for security and accountability reasons. By 
assigning specific privileges to different users, you can ensure that:
    1. Access Control: Each user only has access to the data and operations that 
    are necessary for their role. This helps prevent unauthorized access and 
    reduces the risk of data breaches.
    2. Accountability: With separate user accounts and assigned privileges, it's 
    easier to track who performed which actions in the database. This is crucial 
    for auditing and accountability purposes.
    3. Risk Management: Limiting privileges to only what is necessary for each user 
    reduces the potential impact of security incidents or mistakes. It minimizes the 
    risk of accidental data loss or corruption.
    Page 5 of 8
    4. Compliance: Separation of duties helps organizations comply with regulatory 
    requirements and industry standards by implementing proper access controls 
    and security measures.
By following the principle of least privilege and separating duties among users, 
organizations can enhance the overall security and integrity of their database 
systems.
*/
--Question 2 Example 2

CREATE USER Tshepo IDENTIFIED BY tmphoabc2023;
CREATE OR REPLACE PROCEDURE grant_select_to_all_tables(
Assignment1 VARCHAR2,
tmphoabc2023 VARCHAR2
) AS
v_sql VARCHAR2(1000);
BEGIN
FOR t IN (SELECT table_name FROM all_tables WHERE owner = Assignment1) LOOP
v_sql := 'GRANT SELECT ON ' || Assignment1 || '.' || t.table_name || ' TO ' || tmphoabc2023;
EXECUTE IMMEDIATE v_sql;
END LOOP;
END;
/
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE USER Mya IDENTIFIED BY mrobertabc2023;
CREATE OR REPLACE PROCEDURE grant_insert_to_all_tables(
Assignment1 VARCHAR2,
Mya VARCHAR2
) AS
v_sql VARCHAR2(1000);
BEGIN
FOR t IN (SELECT table_name FROM all_tables WHERE owner = Assignment1) LOOP
v_sql := 'GRANT INSERT ON ' || Assignment1 || '.' || t.table_name || ' TO ' || Mya;
EXECUTE IMMEDIATE v_sql;
END LOOP;
END;
/


--Question 4

SELECT ku.Kayak_ID, 
 ku.Cust_ID, 
 u.Upgrade_hrs, 
 ku.Kayak_Upgrade_amt AS "KAYAK_UPGRADE_AMT", 
 u.Upgrade_hrs * ku.Kayak_Upgrade_amt AS "TOTAL" 
FROM Kayak_Upgrades ku 
INNER JOIN Upgrades u ON ku.Upgrade_ID = u.Upgrade_ID;

--Question 5

SELECT c.Cust_fname ||' '|| c.Cust_sname AS "CUSTOMER", 
 k.Kayak_type, 
 u.Upgrade_hrs, 
 u.Upgrade_work, 
 ku.Kayak_Upgrade_amt AS "KAYAK_UPGRADE_AMT" 
FROM Customer c 
JOIN Kayak_Upgrades ku ON c.Cust_ID = ku.Cust_ID 
JOIN Kayaks k ON ku.Kayak_ID = k.Kayak_ID 
JOIN Upgrades u ON ku.Upgrade_ID = u.Upgrade_ID;

--Question 5

SELECT (CONCAT(CONCAT(c.Cust_fname,', '),Cust_sname)) AS "CUSTOMER", 
 k.Kayak_type, 
 u.Upgrade_hrs, 
 u.Upgrade_work, 
 ku.Kayak_Upgrade_amt AS "KAYAK_UPGRADE_AMT" 
FROM Customer c 
JOIN Kayak_Upgrades ku ON c.Cust_ID = ku.Cust_ID 
JOIN Kayaks k ON ku.Kayak_ID = k.Kayak_ID 
JOIN Upgrades u ON ku.Upgrade_ID = u.Upgrade_ID;

--Question 6 Explicit Cursor

SET SERVEROUTPUT ON;
DECLARE 
 v_cust_id Kayak_Upgrades.Cust_ID%TYPE; 
 v_upgrade_work Upgrades.Upgrade_work%TYPE; 
 v_kayak_upgrade_amount Kayak_Upgrades.Kayak_Upgrade_Amt%TYPE; 
CURSOR c2
IS
    SELECT ku.Cust_ID, u.Upgrade_work, ku.Kayak_Upgrade_amt 
    FROM Kayak_Upgrades ku 
    JOIN Upgrades u ON ku.Upgrade_ID = u.Upgrade_ID 
    WHERE ku.Kayak_Upgrade_amt > 50;
 
BEGIN 
    OPEN c2;
        LOOP
        FETCH c2 INTO v_cust_id, v_upgrade_work, v_kayak_upgrade_amount; 
        EXIT WHEN c2%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE('CUSTOMER ID: ' || v_cust_id); 
          DBMS_OUTPUT.PUT_LINE('UPGRADE WORK: ' || v_upgrade_work); 
          DBMS_OUTPUT.PUT_LINE( 'UPGRADE AMOUNT: R' || v_kayak_upgrade_amount); 
         DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        END LOOP; 
    CLOSE c2;
END;
/

/* 6.2
Cursor Type: Explicit Cursor
Explicit cursors offer more control and flexibility over result set 
processing compared to implicit cursors.

They are manually created from within the PL/SQL, meaning they must be 
defined in a PL/SQL program when working with SELECT statements that return 
more than one row of data.
1. Explicit cursors provide more control and flexibility over cursor operations, 
such as opening, fetching, and closing the cursor manually. This is useful when 
you need to perform complex operations or handle specific conditions within the 
cursor loop.
2. Explicit cursors allow you to define and work with cursor variables, which 
can be useful when you need to pass cursor data between procedures or functions, 
or when you need to perform operations on the cursor itself 
(e.g., checking cursor attributes).
*/

--Question 6 Implicit Cursor

SET SERVEROUTPUT ON;
DECLARE 
     v_cust_id Kayak_Upgrades.Cust_ID%TYPE; 
     v_upgrade_work Upgrades.Upgrade_work%TYPE; 
     v_kayak_upgrade_amount Kayak_Upgrades.Kayak_Upgrade_Amt%TYPE; 
     CURSOR myInfo is
     SELECT ku.Cust_ID, u.Upgrade_work, ku.Kayak_Upgrade_amt 
                FROM Kayak_Upgrades ku 
                JOIN Upgrades u ON ku.Upgrade_ID = u.Upgrade_ID 
                WHERE ku.Kayak_Upgrade_amt > 50;
BEGIN 
  FOR rec IN myInfo
        LOOP
            v_cust_id := rec.Cust_ID;
            v_upgrade_work := rec.Upgrade_work;
            v_kayak_upgrade_amount := rec.Kayak_Upgrade_amt; 

                 DBMS_OUTPUT.PUT_LINE('CUSTOMER ID: ' || v_cust_id); 
                 DBMS_OUTPUT.PUT_LINE('UPGRADE WORK: ' || v_upgrade_work); 
                 DBMS_OUTPUT.PUT_LINE( 'UPGRADE AMOUNT: R' || v_kayak_upgrade_amount); 
                 DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
                 
        END LOOP; 
END;
/

/* 6.2 Implicit Cursor
Cursor Type: Cursor FOR LOOP using Implicit Control
Explicit cursor are con cursors offer more control and flexibility over result set 
processing compared to implicit cursors.
In this query, an explicit cursor is suitable because we need to filter 
results based on a condition (upgrade amount greater than R 50) and 
process each fetched row individually.

--Type of Cursor Used: Implicit Cursor  

--Reasons for the suitability 

--Automatic Handling: Whenever a SQL statement is run, Oracle automatically creates implicit cursors. 
They work well for straightforward queries that do not need explicit cursor control. 

--Simplicity: Compared to explicit cursors, implicit cursors are simpler to use and need less code. 
They are perfect for simple queries like this one, which only require the rows to be fetched and 
shown depending on the condition. 
*/

--Question 7

DECLARE
    v_cust_name Customer.Cust_fname%TYPE;
    v_kayak_type Kayaks.Kayak_type%TYPE;
    v_upgrade_work Upgrades.Upgrade_work%TYPE;
    v_upgrade_date Upgrades.Upgrade_date%TYPE;
    v_kayak_upgrade_amt Kayak_Upgrades.Kayak_Upgrade_amt%TYPE;
    v_discount Kayak_Upgrades.Kayak_Upgrade_amt%TYPE;

CURSOR myInfo IS  
    SELECT (c.Cust_Fname || ' ' || c.cust_sname) Customer, k.Kayak_Type, u.Upgrade_Work, 
                ku.Kayak_Upgrade_Date, ku.Kayak_Upgrade_Amt, (ku.Kayak_Upgrade_Amt * 0.10) Discount_Amount
    FROM Kayak_Upgrades ku INNER JOIN Customer c ON c.Cust_ID = ku.Cust_ID
    INNER JOIN  Kayaks k  ON k.Kayak_ID = ku.Kayak_ID 
    INNER JOIN  Upgrades u ON u.Upgrade_ID = ku.Upgrade_ID 
    WHERE c.Cust_ID = 'C121';
BEGIN
OPEN myInfo;
    LOOP
        FETCH myInfo INTO v_cust_name, v_kayak_type, v_upgrade_work, v_upgrade_date, v_kayak_upgrade_amt, v_discount;
        EXIT WHEN myInfo%NOTFOUND;
        
            DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_cust_name);
            DBMS_OUTPUT.PUT_LINE('Kayak Type: ' || v_Kayak_type);
            DBMS_OUTPUT.PUT_LINE('Upgrade Work: ' || v_Upgrade_work); 
            DBMS_OUTPUT.PUT_LINE('Upgrade Date: ' || TO_CHAR(v_Upgrade_date, 'DD-MON-YYYY'));
            DBMS_OUTPUT.PUT_LINE('Upgrade Amount: R ' || v_Kayak_Upgrade_amt);
            DBMS_OUTPUT.PUT_LINE('Discount Amount: R ' || v_discount);
    END LOOP;
CLOSE myInfo;
END;
/

--Question 8

CREATE OR REPLACE VIEW vwCustUpgrades 
AS
SELECT c.Cust_fname || ' ' || c.Cust_sname AS "Customer_Name", k.Kayak_type, u.Upgrade_work, c.Cust_contact
    FROM Kayak_Upgrades ku 
    INNER JOIN Customer c ON c.Cust_ID = ku.Cust_ID
    INNER JOIN  Kayaks k  ON k.Kayak_ID = ku.Kayak_ID 
    INNER JOIN  Upgrades u ON u.Upgrade_ID = ku.Upgrade_ID
    WHERE UPPER(c.Cust_address) LIKE '%SUMMER%';
    
--Code to test View 

SELECT * FROM vwCustUpgrades;
