

--Enable non compatible user naming

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

--Enable Oracle to display results of Query and block execution in results plane

SET SERVEROUTPUT ON;

--Create a user called SchemaName to be assigned a schemma role

CREATE USER ST11003344_Practicum IDENTIFIED BY Password1;
GRANT ALL PRIVILEGES TO ST11003344_Practicum;
COMMIT;

--Connect to the shema after creation using the GREEN PLUS icon in the Connections Plane

--To drop a Schema Delete the connection, Restart Oracle and run the following command

DROP USER ClassActivity2 CASCADE;