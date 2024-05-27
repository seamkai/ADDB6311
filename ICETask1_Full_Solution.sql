

SELECT s.Firstname||', '||s.Surname AS Names,
c.CourseName, r.Results||'%' AS Results
FROM Student s JOIN Results r ON s.StudID = r.StudID
INNER JOIN Course c ON r.CourseID = c.CourseID
ORDER BY r.Results ASC;

--Question 3

set serveroutput on;

DECLARE
     v_Fname Student.Firstname%TYPE;
     v_Surname Student.Surname%TYPE;
     v_Course Course.Coursename%TYPE;
     v_Result Results.Results%TYPE;
CURSOR c1 
IS
    SELECT s.Firstname, s.Surname , c.CourseName, r.Results
    FROM Student s JOIN Results r ON s.StudID = r.StudID
    INNER JOIN Course c ON r.CourseID = c.CourseID
    WHERE s.StudID = 1033;
BEGIN
OPEN c1;
LOOP
FETCH c1 INTO  v_Fname,v_Surname, v_Course ,v_Result; 
EXIT WHEN c1%NOTFOUND;

    dbms_output.put_line('The student result is : '||v_Fname||','||v_Surname||', '||v_Course||', '||v_Result||'%');
    
END LOOP;
CLOSE c1;
END;
/

--Question 4

DECLARE
    v_Studid Results.StudID%type;
    v_Count INT;
    
CURSOR c1 
IS
    SELECT StudID, COUNT(Studid)
    FROM Results
    GROUP BY StudID
    ORDER BY  COUNT(Studid) desc;
BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_Studid, v_Count;
EXIT WHEN c1%NOTFOUND;

    dbms_output.put_line('The result count for '||v_Studid||' is : '||v_Count);
    
END LOOP;
CLOSE c1;
END;
/

--Question 1.5

CREATE OR REPLACE VIEW Course_Credits
AS
SELECT Coursename, Credits
FROM Course
WHERE Credits > 12;

SELECT * FROM  Course_Credits;

--Question 6 Using IF    
    
DECLARE
    v_Studid Results.StudID%TYPE;
    v_Result Results.ResultID%TYPE;
    
CURSOR c1 
IS
    SELECT StudID, Results
    FROM Results
    WHERE StudID = 1011 AND ResultID = 101;
BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_Studid, v_Result;
EXIT WHEN c1%NOTFOUND;

IF v_Result >= 0 AND v_Result <= 49

THEN 
    dbms_output.put_line('StudentID :' ||v_Studid);
    dbms_output.put_line('Result : '||v_Result||'%');
    dbms_output.put_line('Outcome : Result is a Fail');
ELSIF 
        v_Result >= 50 AND v_Result <= 74
THEN 
    dbms_output.put_line('StudentID :' ||v_Studid);
    dbms_output.put_line('Result : '||v_Result||'%');
    dbms_output.put_line('Outcome : Result is a Pass');
ELSE
    dbms_output.put_line('StudentID :' ||v_Studid);
    dbms_output.put_line('Result : '||v_Result||'%');
    dbms_output.put_line('Outcome : Result is a Distinction');
END IF;

END LOOP;
CLOSE c1;
END;
/

--Question 6 Using CASE 

SET SERVEROUTPUT ON;

DECLARE
    v_Studid Results.StudID%TYPE;
    v_Result Results.ResultID%TYPE;
    
CURSOR myInfo 
IS
    SELECT StudID, Results
    FROM Results
    WHERE StudID = 1011 AND ResultID = 101;
BEGIN
FOR rec IN myInfo
    LOOP
        v_Studid := rec.StudID;
        v_Result := rec.Results;
    
        CASE 
        WHEN  v_Result >= 0 AND v_Result <= 49 
            THEN 
            dbms_output.put_line('StudentID :' ||v_Studid||CHR(10)||'Result : '||v_Result||'%'||CHR(10)||'Outcome : Result is a Fail');
        WHEN v_Result >= 50 AND v_Result <= 74 
            THEN 
            dbms_output.put_line('StudentID :' ||v_Studid||CHR(10)||'Result : '||v_Result||'%'||CHR(10)||'Outcome : Result is a Pass');
        ELSE
            dbms_output.put_line('StudentID :' ||v_Studid||CHR(10)||'Result : '||v_Result||'%'||CHR(10)||'Outcome : Result is a Distinction');
        END CASE;
    
    END LOOP;
END;
/

--Question 7

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER Pat_Jones IDENTIFIED BY Pat12345;
GRANT SELECT  ON Results TO Pat_Jones;
COMMIT;

--Question 8

CREATE SEQUENCE Result_ID
START with 106
INCREMENT BY 1;

select * from Results;

INSERT INTO Results VALUES (Result_ID.nextval, 98,1011, 2);






























    