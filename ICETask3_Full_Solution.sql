--Question 1

SELECT s.CustomerID, s.EmpID, ps.ProductID, s.SaleDate
FROM Product_Sales ps INNER JOIN Sales s ON ps.SaleID = s.SaleID
INNER JOIN Product p ON p.ProductID = ps.Productid
WHERE p.Price < 5000
ORDER BY s.CustomerID;

--Question 2

SET SERVEROUTPUT ON;
DECLARE
CURSOR c1 
IS
    SELECT c.first_name||', '||c.surname as Customer, p.productname, p.price, sp.rating
    FROM Customer c INNER JOIN sales s ON c.customerid = s.customerid
    INNER JOIN product_sales ps ON ps.saleid = s.saleid
    INNER JOIN Product p ON p.productid = ps.productid
    INNER JOIN supplier sp ON sp.supplierid = p.supplierid
    WHERE sp.rating = 7
    ORDER BY c.surname;
                            v_rec c1%ROWTYPE;
    
BEGIN 
    FOR v_rec IN c1
    LOOP
        dbms_output.put_line('Customer :'||v_rec.Customer);
        dbms_output.put_line('Product :'||v_rec.productname);
        dbms_output.put_line('Product Price R:'||v_rec.price);
        dbms_output.put_line('Rating :'||v_rec.rating);
        dbms_output.put_line('----------------------------------------');
    END LOOP;
END;
/


--Question 3

DECLARE
CURSOR c1 
IS
    SELECT p.productname, SUM(s.saleqty*p.price) as TotalSales
    FROM sales s INNER JOIN product_sales ps ON ps.saleid = s.saleid
    INNER JOIN Product p ON p.productid = ps.productid
    GROUP BY p.productname
    HAVING SUM(s.saleqty*p.price) >
    (SELECT AVG(s.saleqty*p.price)
    FROM sales s INNER JOIN product_sales ps ON ps.saleid = s.saleid
    INNER JOIN Product p ON p.productid = ps.productid);
    
 v_rec c1%ROWTYPE;
    
BEGIN 
    FOR v_rec IN c1
    LOOP
        dbms_output.put_line('Product Name :'||v_rec.productname||CHR(10)||
            'Total Sales R:'||v_rec.TotalSales||CHR(10)||
                '----------------------------------------');
    END LOOP;
EXCEPTION WHEN ZERO_DIVIDE THEN 
            RAISE_APPLICATION_ERROR(-20191, 'Cannot divide by zero -'||SQLCODE||'-ERROR-'||SQLERRM);
            WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20191, 'No data was found -'||SQLCODE||'-ERROR-'||SQLERRM);
            WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20191, 'An error occured -'||SQLCODE||'-ERROR-'||SQLERRM);
END;
/ 

--Question 4

CREATE OR REPLACE VIEW Overall_Report
AS
    SELECT e.first_name||', '||e.surname AS Employee,c.first_name||', '||c.surname as Customer, p.productname,
    sp.suppliername, s.saledate
    FROM Customer c INNER JOIN sales s ON c.customerid = s.customerid
    INNER JOIN product_sales ps ON ps.saleid = s.saleid
    INNER JOIN Product p ON p.productid = ps.productid
    INNER JOIN supplier sp ON sp.supplierid = p.supplierid
    INNER JOIN Employee e ON e.EmpId = s.EmpId
    WHERE s.saledate = '22-Oct-2016';
    
    SELECT * FROM Overall_Report;


--Question 5

CREATE OR REPLACE PROCEDURE Sales_Count(v_EmpID NUMBER)
AS
v_Count INT;
CURSOR c1
    IS
    SELECT COUNT(EMPID) as SalesCount
    from Sales
    WHERE EmpID = v_EmpID;
BEGIN
    FOR rec IN c1
    LOOP 
    v_Count := rec.SalesCount;
    
    IF v_Count >= 3 THEN
        dbms_output.put_line('Sale count for employee is  '||v_Count);
        dbms_output.put_line('Performance : Good  ');
        dbms_output.put_line('------------------------------------------------');
    ELSE 
        dbms_output.put_line('Sale count for employee is  '||v_Count);
        dbms_output.put_line('Performance : Poor  '); 
        dbms_output.put_line('------------------------------------------------');
    END IF;
    END LOOP;
END;
/

EXEC Sales_Count(101);

--Question 6

CREATE OR REPLACE FUNCTION Lowest_Sales
RETURN varchar2
AS
    v_pname product.productname%TYPE;
    v_price product.price%TYPE;
    v_details varchar2(100);
Cursor myInfo 
IS
    SELECT p.productname,MIN(s.saleqty*p.price) AS price
    FROM sales s INNER JOIN product_sales ps ON s.saleid = ps.saleid
    INNER JOIN product p ON p.productid = ps.productid
    GROUP BY p.productname
    ORDER BY price
    FETCH FIRST 1 ROWS ONLY;
BEGIN
FOR rec IN myInfo
LOOP
    v_pname := rec.productname;
    v_price := rec.price;
    v_details := v_pname||' - R:'||v_price;
RETURN v_details;
    END LOOP;
EXCEPTION WHEN ZERO_DIVIDE THEN 
            RAISE_APPLICATION_ERROR(-20191, 'Cannot divide by zero -'||SQLCODE||'-ERROR-'||SQLERRM);
            WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20191, 'No data was found -'||SQLCODE||'-ERROR-'||SQLERRM);
            WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20191, 'An error occured -'||SQLCODE||'-ERROR-'||SQLERRM);
END;
/

SELECT Lowest_Sales
FROM dual;


--Question 7


CREATE OR REPLACE TRIGGER SupplierEntry
BEFORE INSERT OR UPDATE OF rating ON supplier
FOR EACH ROW
BEGIN
    IF(:New.rating <= 0) THEN 
      RAISE_APPLICATION_ERROR(-20199, 'Cannot insert a negative or zero rating');
    END IF;
END;
/

--Test trigger with negative supplier rating

SELECT * FROM supplier;

INSERT INTO supplier VALUES (755,'New Supplier','0123546987',0);


--System defined Exceptions

DECLARE
CURSOR c1 
IS
    SELECT p.productname, SUM(s.saleqty*p.price) as TotalSales
    FROM sales s INNER JOIN product_sales ps ON ps.saleid = s.saleid
    INNER JOIN Product p ON p.productid = ps.productid
    GROUP BY p.productname
    HAVING SUM(s.saleqty*p.price) >
    (SELECT AVG(s.saleqty*p.price)
    FROM sales s INNER JOIN product_sales ps ON ps.saleid = s.saleid
    INNER JOIN Product p ON p.productid = ps.productid);
    
 v_rec c1%ROWTYPE;
    
BEGIN 
    FOR v_rec IN c1
    LOOP
        dbms_output.put_line('Product Name :'||v_rec.productname||CHR(10)||
            'Total Sales R:'||v_rec.TotalSales||CHR(10)||
                '----------------------------------------');
    END LOOP;
EXCEPTION WHEN ZERO_DIVIDE THEN 
            RAISE_APPLICATION_ERROR(-20191, 'Cannot divide by zero -'||SQLCODE||'-ERROR-'||SQLERRM);
            WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20191, 'No data was found -'||SQLCODE||'-ERROR-'||SQLERRM);
            WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20191, 'An error occured -'||SQLCODE||'-ERROR-'||SQLERRM);
END;
/ 




--User defined Exception

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