-- ****************************************************** 
-- 2014ps3.sql 
-- 
-- Loader for PS-3 Database 
-- 
-- Description:  This script contains the DDL to load 
--              the tables of the 
--              INVENTORY database 
-- 
-- There are 6 tables on this DB 
-- 
-- Author:  Maria R. Garcia Altobello 
-- 
-- Student:  Isaac Lebwohl-Steiner 
-- 
-- Date:   October, 2014 
-- 
-- ****************************************************** 
-- ****************************************************** 
--    SPOOL SESSION 
-- ****************************************************** 
spool 2014ps3.lst 
-- ****************************************************** 
--    DROP TABLES 
-- Note:  Issue the appropiate commands to drop tables 
-- ****************************************************** 
DROP TABLE tborder purge; 

DROP TABLE tbcustomer purge; 

DROP TABLE tbitem purge; 

DROP TABLE tborderitem purge; 

DROP TABLE tbproduct purge; 

DROP TABLE tbvendor purge; 

DROP SEQUENCE seqorder; 

-- ****************************************************** 
--    DROP SEQUENCES 
-- Note:  Issue the appropiate commands to drop sequences 
-- ****************************************************** 
-- ****************************************************** 
--    CREATE SEQUENCES 
-- ****************************************************** 
CREATE SEQUENCE seqorder 
  MINVALUE 1 
  --I won't include a MAXVALUE, and so will use the default of 999999999999999999999999999 
  START WITH 1 
  INCREMENT BY 1 
  --If I knew how quickly orders came in, I could make a more informed decision about the cache 
  CACHE 30; 

-- ****************************************************** 
--    CREATE TABLES 
-- ****************************************************** 
CREATE TABLE tbcustomer 
  ( 
     customerid      CHAR(4) NOT NULL CONSTRAINT rg_customerid CHECK (customerid 
     BETWEEN 
     '1000' AND '4999') 
     CONSTRAINT pk_customer PRIMARY KEY, 
     customername    VARCHAR2(40) NOT NULL, 
     customeraddress VARCHAR2(50) NULL, 
     customercity    VARCHAR2(30) NULL, 
     customerstate   CHAR(2) NULL, 
     customerzip     VARCHAR2(10) NULL, 
     customercontact VARCHAR2(30) NULL, 
     customerphone   VARCHAR2(12) NULL, 
     customeremail   VARCHAR2(50) NULL 
  ); 

/* 

I needed to move the Product and Vendor tables up in the script so that 
I could reference them using foreign keys in the Item table. 

*/ 
CREATE TABLE tbproduct 
  ( 
     productid   CHAR(3) NOT NULL CONSTRAINT rg_productid CHECK (productid 
     BETWEEN 
     '100' AND '999') 
     CONSTRAINT pk_product PRIMARY KEY, 
     productname VARCHAR2(30) NOT NULL, 
     budgetsales NUMBER(4, 0) DEFAULT 0 NULL 
  ); 

CREATE TABLE tbvendor 
  ( 
     vendorid      CHAR(4) NOT NULL CONSTRAINT rg_vendorid CHECK (vendorid 
     BETWEEN '5000' 
     AND '9999') 
     CONSTRAINT pk_vendor PRIMARY KEY, 
     vendorname    VARCHAR2(25) NOT NULL, 
     vendoraddress VARCHAR2(50) NULL, 
     vendorcity    VARCHAR2(30) NULL, 
     vendorstate   CHAR(2) NULL, 
     vendorzip     VARCHAR2(10) NULL 
  ); 

CREATE TABLE tbitem 
  ( 
     productid CHAR(4) NOT NULL, 
          CONSTRAINT fk_product FOREIGN KEY (productid) REFERENCES tbproduct ( 
          productid), 
     vendorid  CHAR(4) NOT NULL, 
          CONSTRAINT fk_vendor FOREIGN KEY (vendorid) REFERENCES tbvendor ( 
     vendorid), 
          itemprice NUMBER(10, 2) DEFAULT 0.00 NULL CONSTRAINT rg_itemprice 
     CHECK ( 
          itemprice >= 0), 
     qoh       NUMBER(8, 0) DEFAULT 0 NOT NULL, 
     CONSTRAINT pk_item PRIMARY KEY (productid, vendorid) 
  ); 

CREATE TABLE tborder 
  ( 
     orderno    NUMBER(11, 0) NOT NULL CONSTRAINT pk_order PRIMARY KEY, 
     orderdate  DATE NOT NULL, 
     customerid CHAR(4) NOT NULL, 
     CONSTRAINT fk_customer FOREIGN KEY (customerid) REFERENCES tbcustomer ( 
     customerid) ON DELETE CASCADE 
  ); 

CREATE TABLE tborderitem 
  ( 
     orderno     NUMBER(11, 0) NOT NULL, 
          CONSTRAINT fk_order FOREIGN KEY (orderno) REFERENCES tborder (orderno) 
     ON 
          DELETE CASCADE, 
          orderitemno CHAR(2) NOT NULL, 
          productid   CHAR(3) NULL, 
          vendorid    CHAR(4) NULL, 
          quantity    NUMBER(4, 0) NULL, 
          itemprice   NUMBER(10, 2) NULL, 
     CONSTRAINT pk_orderitem PRIMARY KEY (orderno, orderitemno),
	 CONSTRAINT fk_item FOREIGN KEY (productid, vendorid) REFERENCES tbitem ( 
          productid, vendorid) ON DELETE CASCADE
  ); 

-- ****************************************************** 
--    POPULATE TABLES 
-- 
-- Note:  Follow instructions and data provided on PS-3 
--        to populate the tables 
-- ****************************************************** 
/* inventory tbcustomer */
INSERT INTO tbcustomer c (customerid,customername,customeraddress,customercity,customerstate,customerzip,customercontact,customerphone,customeremail)
		VALUES(1123,'Z Best','123 Main Street','Cambridge','MA','02139','Carol Jenkins','6175552222','jenkinsc@abc.com');

/* inventory tbitem */ 
/* inventory tborder */ 
/* inventory tborderitem */ 
/* inventory tbproduct */ 
/* inventory tbvendor */ 
-- ****************************************************** 
--    VIEW TABLES 
-- 
-- Note:  Issue the appropiate commands to show your data 
-- ****************************************************** 
SELECT * 
FROM   tbcustomer; 

SELECT * 
FROM   tbitem; 

SELECT * 
FROM   tborder; 

SELECT * 
FROM   tborderitem; 

SELECT * 
FROM   tbproduct; 

SELECT * 
FROM   tbvendor; 

-- ****************************************************** 
--    QUALITY CONTROLS 
-- 
-- Note:  Test only 5 constraints of the following types: 
--        *) Entity integrity 
--        *) Referential integrity 
--        *) Column constraints 
-- ****************************************************** 
-- ****************************************************** 
--    END SESSION 
-- ****************************************************** 
spool OFF 