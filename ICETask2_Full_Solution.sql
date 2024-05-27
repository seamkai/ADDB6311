--Question 1 Create Table statements

CREATE TABLE CUSTOMER
(

CUSTOMER_ID CHAR(5) NOT NULL,
FIRST_NAME VARCHAR2(100) NOT NULL,
SURNAME VARCHAR2(100) NOT NULL,
ADDRESS VARCHAR2(100) NOT NULL,
PHONE_NUM CHAR(10) NOT NULL,
EMAIL VARCHAR2(100) NOT NULL,
CONSTRAINT PK_Customer PRIMARY KEY (CUSTOMER_ID)

);

CREATE TABLE STAFF
(

STAFF_ID CHAR(5) NOT NULL,
FIRST_NAME VARCHAR2(100) NOT NULL,
SURNAME VARCHAR2(100) NOT NULL,
POSITION VARCHAR2(100) NOT NULL,
PHONE_NUM CHAR(10) NOT NULL,
ADDRESS VARCHAR2(100) NOT NULL,
EMAIL VARCHAR2(100) NOT NULL,
CONSTRAINT PK_Staff PRIMARY KEY (STAFF_ID)

);

CREATE TABLE DRIVER
(

DRIVER_ID CHAR(5) NOT NULL,
FIRST_NAME VARCHAR2(100) NOT NULL,
SURNAME VARCHAR2(100) NOT NULL,
DRIVER_CODE CHAR(3) NOT NULL,
PHONE_NUM CHAR(10) NOT NULL,
ADDRESS VARCHAR2(100) NOT NULL,
CONSTRAINT PK_Driver PRIMARY KEY (DRIVER_ID)

);

CREATE TABLE VEHICLE
(

VIN_NUMBER CHAR(11)  NOT NULL,
VEHICLE_TYPE VARCHAR2(50) NOT NULL,
MILEAGE INT NOT NULL,
COLOUR VARCHAR2(50) NOT NULL,
MANUFACTURER VARCHAR2(50) NOT NULL,
CONSTRAINT PK_Vehicle PRIMARY KEY (VIN_NUMBER)

);

CREATE TABLE BILLING
(

BILL_ID CHAR(3)  NOT NULL,
CUSTOMER_ID CHAR(5) NOT NULL,
STAFF_ID CHAR(5) NOT NULL,
BILL_DATE DATE NOT NULL,
CONSTRAINT PK_Billing PRIMARY KEY (BILL_ID),
CONSTRAINT FK_Customer_Billing FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID),
CONSTRAINT FK_Staff_Billing FOREIGN KEY (STAFF_ID) REFERENCES STAFF (STAFF_ID)

);

CREATE TABLE Delivery_Items
(

Delivery_Item_ID CHAR(5) NOT NULL,
Description VARCHAR2(50) NOT NULL,
Staff_ID CHAR(5) NOT NULL,
CONSTRAINT PK_Delivery_Items PRIMARY KEY (DELIVERY_ITEM_ID),
CONSTRAINT FK_Staff_Delivery_Items FOREIGN KEY (STAFF_ID) REFERENCES STAFF (STAFF_ID)

);

CREATE TABLE Driver_Deliveries
(
Driver_Delivery_ID CHAR(5) NOT NULL,
VIN_Number CHAR(11)  NOT NULL,
Driver_ID CHAR(5) NOT NULL,
Delivery_Item_ID CHAR(5) NOT NULL,
CONSTRAINT PK_Driver_Deliveries PRIMARY KEY (Driver_Delivery_ID),
CONSTRAINT FK_Vehicle_Driver_Deliveries FOREIGN KEY (VIN_Number) REFERENCES Vehicle (VIN_Number),
CONSTRAINT FK_Driver_Driver_Deliveries FOREIGN KEY (Driver_ID) REFERENCES Driver (Driver_ID),
CONSTRAINT FK_DI_Driver_Deliveries FOREIGN KEY (Delivery_Item_ID) REFERENCES Delivery_Items (Delivery_Item_ID)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Question 2 Insert Statements

INSERT INTO CUSTOMER VALUES (11011,'Bob','Smith','18 Water rd',0877277521,'bobs@isat.com');
INSERT INTO CUSTOMER VALUES (11012,'Sam','Hendricks','22 Water rd',0863257857,'shen@mcom.co.z');
INSERT INTO CUSTOMER VALUES (11013,'Larry','Clark','101 Summer lane',0834567891,'larc@mcom.co.za');
INSERT INTO CUSTOMER VALUES (11014,'Jeff','Jones','55 Mountain way',0612547895,'jj@isat.co.za');
INSERT INTO CUSTOMER VALUES (11015,'Andre','Kerk','5 Main rd',0827238521,'akerk@mcal.co.za');

INSERT INTO STAFF VALUES (51011,'Sally','Du Toit','Logistics',0825698547,'18 Main rd','sdut@isat.com');
INSERT INTO STAFF VALUES (51012,'Mark','Wright','CRM',0836984178,'12 Cape Way','mwright@isat.com');
INSERT INTO STAFF VALUES (51013,'Harry','Sheen','Logistics',0725648965,'15 Water Street','hsheen@isat.com');
INSERT INTO STAFF VALUES (51014,'Jabu','Xolani','Logistics',0823116598,'18 White Lane','jxo@isat.com');
INSERT INTO STAFF VALUES (51015,'Roberto','Henry','Packaging',0783521457,'55 Cape Street','rhenry@isat.com');

INSERT INTO DRIVER VALUES (81011,'Brett','Marshall','C1',0725698547,'18 Leopard creek');
INSERT INTO DRIVER VALUES (81012,'Tina','Mtati','C',0636984178,'12 Cape rd');
INSERT INTO DRIVER VALUES (81013,'Richard','Mvuyisi','EC1',0725648965,'15 Circle lane');
INSERT INTO DRIVER VALUES (81014,'Jonathan','Smith','C1',0623116598,'18 Beach rd');
INSERT INTO DRIVER VALUES (81015,'Sisanda','Buthelezi','EB',0883521457,'55 Summer lane');

INSERT INTO VEHICLE VALUES ('1ZA55858541','Cutaway van chassis',115352,'RED','MAN');
INSERT INTO VEHICLE VALUES ('1ZA51858542','Flatbed truck',315856,'BLUE','ISUZU');
INSERT INTO VEHICLE VALUES ('1ZA35858543','Medium Standard Truck',789587,'SILVER','MAN');
INSERT INTO VEHICLE VALUES ('1ZA15851545','Flatbed truck',555050,'WHITE','MAN');
INSERT INTO VEHICLE VALUES ('1ZA35868540','Cutaway van chassis',79058,'WHITE','ISUZU');

INSERT INTO BILLING VALUES (800,11011,51011,'06/SEP/16');
INSERT INTO BILLING VALUES (801,11012,51013,'07/SEP/16');
INSERT INTO BILLING VALUES (802,11014,51015,'10/NOV/16');
INSERT INTO BILLING VALUES (803,11015,51012,'09/DEC/16');
INSERT INTO BILLING VALUES (804,11013,51014,'09/DEC/16');

INSERT INTO DELIVERY_ITEMS VALUES(71011,'House relocation',51011);
INSERT INTO DELIVERY_ITEMS VALUES(71012,'Office relocation',51013);
INSERT INTO DELIVERY_ITEMS VALUES(71013,'Delivery of specialized consignments',51015);
INSERT INTO DELIVERY_ITEMS VALUES(71014,'Office relocation',51012);
INSERT INTO DELIVERY_ITEMS VALUES(71015,'Delivery of specialized consignments',51014);

INSERT INTO DRIVER_DELIVERIES VALUES (91011,'1ZA55858541',81011,71011);
INSERT INTO DRIVER_DELIVERIES VALUES (91012,'1ZA35858543',81012,71013);
INSERT INTO DRIVER_DELIVERIES VALUES (91013,'1ZA55858541',81011,71014);
INSERT INTO DRIVER_DELIVERIES VALUES (91014,'1ZA35868540',81013,71015);
INSERT INTO DRIVER_DELIVERIES VALUES (91015,'1ZA15851545',81014,71012);

QUESTION 3
SELECT C.FIRST_NAME||', ' ||C.SURNAME AS CUSTOMER, S.STAFF_ID, DD.DRIVER_ID, di.description
FROM  customer C
INNER JOIN BILLING B ON C.CUSTOMER_ID =B.CUSTOMER_ID
INNER JOIN STAFF S ON S.STAFF_ID = B.STAFF_ID
INNER JOIN DELIVERY_ITEMS DI ON DI.STAFF_ID = S.STAFF_ID
INNER JOIN DRIVER_DELIVERIES DD ON DD.DELIVERY_ITEM_ID = DI.DELIVERY_ITEM_ID
ORDER BY C.SURNAME;


--QUESTION 4
SELECT D.FIRST_NAME, D.SURNAME , V.VEHICLE_TYPE , DI.DESCRIPTION
FROM DELIVERY_ITEMS DI 
INNER JOIN DRIVER_DELIVERIES DD ON DD.DELIVERY_ITEM_ID = DI.DELIVERY_ITEM_ID
INNER JOIN DRIVER D ON D.DRIVER_ID = DD.DRIVER_ID
INNER JOIN VEHICLE V ON  V.VIN_NUMBER =DD.VIN_NUMBER
WHERE D.DRIVER_ID = 81011;

--QUESTION 5
SET SERVEROUTPUT ON;

DECLARE
v_vehicle vehicle.vehicle_type%type;
v_mileage vehicle.mileage%type;
v_manufacturer vehicle.manufacturer%type;

CURSOR P1
IS

SELECT V.VEHICLE_TYPE, V.MILEAGE, V.MANUFACTURER
FROM VEHICLE V
WHERE V.MILEAGE > 700000;

BEGIN
OPEN P1;
LOOP
FETCH P1 INTO v_vehicle, v_mileage,v_manufacturer;
EXIT WHEN P1%NOTFOUND;
            dbms_output.put_line('VIHICLE: ' ||v_vehicle);
             dbms_output.put_line('MILEAGE: '||v_mileage);
              dbms_output.put_line('MANUFACTURER: '||v_manufacturer);
END LOOP;
CLOSE P1;
END;
/


--QUESTION 6
DECLARE
v_vehicle vehicle.vehicle_type%type;
v_mileage vehicle.mileage%type;
v_new number;

CURSOR P2
IS
SELECT V.VEHICLE_TYPE,V.MILEAGE, (V.MILEAGE+ 983) AS NEW_MILEAGE
FROM VEHICLE V 
WHERE VIN_NUMBER = '1ZA35868540';

BEGIN
OPEN P2;
LOOP
FETCH P2 INTO v_vehicle,v_mileage,v_new;
EXIT WHEN P2%NOTFOUND;

                dbms_output.put_line('VIHICLE: ' ||v_vehicle);
                 dbms_output.put_line('ORIGINAL MILEAGE: '||v_mileage ||' km');
                  dbms_output.put_line('NEW MILEAGE: '||v_new||' km');
END LOOP;
CLOSE P2;
END;
/

--question 7

DECLARE
v_customer varchar(50);
v_bill billing.bill_date%type;
v_description delivery_items.description%type;
v_type vehicle.vehicle_type%type;

CURSOR P3
IS

SELECT C.FIRST_NAME||', ' ||C.SURNAME AS CUSTOMER, B.BILL_DATE , DI.description,V.VEHICLE_TYPE
FROM  customer C
INNER JOIN BILLING B ON C.CUSTOMER_ID =B.CUSTOMER_ID
INNER JOIN STAFF S ON S.STAFF_ID = B.STAFF_ID
INNER JOIN DELIVERY_ITEMS DI ON DI.STAFF_ID = S.STAFF_ID
INNER JOIN DRIVER_DELIVERIES DD ON DD.DELIVERY_ITEM_ID = DI.DELIVERY_ITEM_ID
INNER JOIN VEHICLE V ON V.VIN_NUMBER = DD.VIN_NUMBER
WHERE B.BILL_DATE = '10-NOV-16';

BEGIN
    OPEN P3;
        LOOP
        FETCH P3 INTO v_customer,v_bill,v_description,v_type;
        EXIT WHEN P3%NOTFOUND;
                        dbms_output.put_line('CUSTOMER: ' ||v_customer);
                        dbms_output.put_line('BILL DATE: '||v_bill);
                        dbms_output.put_line('DESCRIPTION: '||v_description);
                        dbms_output.put_line('VEHICLE: '||v_type);
        END LOOP;
    CLOSE P3;
END;
/

--Question 8 using Cursor FOR LOOP

DECLARE
    v_Vnum Vehicle.Vin_Number%TYPE;
    v_Type Vehicle.Vehicle_Type%TYPE;
    v_Count INT;

CURSOR info 
IS
    SELECT v.Vin_Number, v.Vehicle_Type, COUNT(dd.Vin_Number) AS Delivery_Count
    FROM Driver_Deliveries dd INNER JOIN Vehicle v ON v.Vin_Number = dd.Vin_Number
    GROUP BY v.Vin_Number, v.Vehicle_Type
    ORDER BY Delivery_Count DESC;

BEGIN
FOR rec IN info
LOOP
    v_Vnum := rec.Vin_Number;
    v_Type := rec.Vehicle_Type;
    v_Count := rec.Delivery_Count;
    
    IF  v_Count < 2
    THEN
    
        DBMS_OUTPUT.PUT_LINE('VIN NUMBER      :'||v_Vnum);
        DBMS_OUTPUT.PUT_LINE('VEHICLE TYPE    :'||v_Type);
        DBMS_OUTPUT.PUT_LINE('DELIVERY COUNT  :'||v_Count);
        DBMS_OUTPUT.PUT_LINE('INSPECTION DUE  :NO');
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
        
    ELSE 
    
        DBMS_OUTPUT.PUT_LINE('VIN NUMBER      :'||v_Vnum);
        DBMS_OUTPUT.PUT_LINE('VEHICLE TYPE    :'||v_Type);
        DBMS_OUTPUT.PUT_LINE('DELIVERY COUNT  :'||v_Count);
        DBMS_OUTPUT.PUT_LINE('INSPECTION DUE  :YES');
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
    
    END IF;
    END LOOP;
END;
/
       
--Question 9 using Cursor FOR LOOP

DECLARE
v_Name Driver.First_Name%TYPE;
v_Surname Driver.Surname%TYPE;
v_ID Driver.Driver_ID%TYPE;

CURSOR info 
IS
    SELECT d.First_Name,d.Surname, dd.Driver_ID
    FROM Driver d LEFT JOIN Driver_Deliveries dd 
    ON dd.Driver_ID = d.Driver_ID;

BEGIN
FOR rec IN info
    LOOP
    v_Name := rec.First_Name;
    v_Surname := rec.Surname;
    v_ID := rec.Driver_ID;
    
        IF v_ID IS NULL 
        
        THEN
                DBMS_OUTPUT.PUT_LINE('FIRST NAME         :'||v_Name);
                DBMS_OUTPUT.PUT_LINE('SURNAME            :'||v_Surname);
                DBMS_OUTPUT.PUT_LINE('DELIVERY REQUIRED  :YES');
                DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
        END IF;
    END LOOP;
END;
/

--Question 9 Notes

--Notes on SubQuery vs Left Outer Join
 
SELECT First_Name, Surname, Driver_ID
FROM DRIVER
WHERE Driver_ID NOT IN  
(SELECT Driver_ID FROM driver_deliveries);
  
SELECT d.First_Name, d.Surname, dd.Driver_ID
FROM Driver d LEFT JOIN Driver_Deliveries dd ON d.Driver_ID = dd.Driver_ID
WHERE dd.Driver_ID IS NULL;


--Quetion 10

CREATE OR REPLACE VIEW Days_To_Deliver
AS
SELECT c.First_Name, c.Surname, di.Description, (TO_DATE('15 December 2016') - (b.Bill_Date) ||' days') AS DELIVERY_TIME
FROM Billing b, Customer c, Staff s, Delivery_Items di
  WHERE c.Customer_ID = b.Customer_ID
  AND b.Staff_ID = s.Staff_ID
  AND s.Staff_ID = di.Staff_ID
  AND BILL_ID = 804;
  
SELECT * FROM Days_To_Deliver;




