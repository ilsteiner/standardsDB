/*******************************************************
	Description: This is the DDL to create the database.

	Student: Isaac Lebwohl-Steiner

	Created: 11/11/2014
*******************************************************/

--Spool our session

spool standardsDB_DDL.lst

/*******************************************************
	Drop Tables

	TODO: Add all tables and drop them here.
*******************************************************/

DROP TABLE tbStandardComponent PURGE;
DROP TABLE tbPartComponent PURGE;
DROP TABLE tbStandard PURGE;
DROP TABLE tbPart PURGE;
DROP TABLE tbCertification PURGE;
DROP TABLE tbStandardType PURGE;
DROP TABLE tbTechnician PURGE;
DROP TABLE tbCertStatus PURGE;
DROP TABLE tbElement PURGE;

/*******************************************************
	Drop other things

	TODO: Ensure everything is dropped correctly.
*******************************************************/

DROP SEQUENCE seq_tbCertification;

DROP SEQUENCE seq_tbPart;

DROP SEQUENCE seq_tbStandard;

/*******************************************************
	Create tables
*******************************************************/

create table tbElement (
	symbol varchar2(3) primary key,
	atomicNumber varchar2(3) not null,
	name varchar2(13) not null,
	density number(4,2)
	);

create table tbCertStatus (
	statusID char(1) primary key,
	statusDesc varchar2(16) not null
	);

create table tbTechnician (
	technicianID char(3) primary key,
	name varchar2(512) not null,
	title varchar2(256)
	);

create table tbStandardType (
	typeID char(1) primary key,
	typeDesc varchar2(32) not null
	);

create table tbCertification (
	certNumber char(11) primary key,
	technicianID char(3) not null,
	statusID char(1) not null,
	certDate date,
	constraint format_certNumber
	check (REGEXP_LIKE(certNumber,'C[0-9]{10}')),
	constraint fk_technician_tbCertification
	foreign key (technicianID)
	references tbTechnician(technicianID),
	constraint fk_status_tbCertification
	foreign key (statusID)
	references tbCertStatus(statusID)
	);

create table tbPart (
	partNumber char(11) primary key,
	typeID char(1),
	targetValue number(5,0) not null,
	price number(8,2),
	stock number(5,0) default 0 not null,
	platedElement varchar2(2),
	custom char(1) not null,
	constraint format_partNumber_tbPart
	check (REGEXP_LIKE(partNumber,'P[0-9]{10}')),
	constraint bool_custom_tbPart
	check (custom in('Y','N')),
	constraint fk_symbol_tbPart
	foreign key (platedElement)
	references tbElement(symbol),
	constraint fk_typeID_tbPart
	foreign key (typeID)
	references tbStandardType(typeID)
	);

create table tbStandard (
	serialNumber char(11) primary key,
	partNumber char(11) not null,
	certNumber char(11),
	actualValue number(8,2),
	constraint format_serialNumber_tbStandard
	check (REGEXP_LIKE(serialNumber,'S[0-9]{10}')),
	constraint fk_partNumber_tbStandard
	foreign key (partNumber)
	references tbPart(partNumber),
	constraint fk_certNumber_tbStandard
	foreign key (certNumber)
	references tbCertification(certNumber)
	);

create table tbPartComponent (
	partNumber char(11),
	symbol varchar2(3),
	composition number(3,0),
	constraint format_composition_tbPartCo
	check (composition between 1 and 100),
	constraint fk_partNumber_tbPartCompone
	foreign key (partNumber)
	references tbPart(partNumber),
	constraint fk_symbol_tbPartComponent
	foreign key (symbol)
	references tbElement(symbol),
	constraint pk_tbPartComponent
	primary key (partNumber,symbol)
	);

create table tbStandardComponent (
	serialNumber char(11),
	symbol varchar2(3),
	partNumber char(11) not null,
	composition number(3,0) not null,
	constraint format_composition
	check (composition between 1 and 100),
	constraint fk_serialNumber_tbStandardComp
	foreign key (serialNumber)
	references tbStandard(serialNumber),
	constraint fk_pComponent_tbStandardCompon
	foreign key (symbol,partNumber)
	references tbPartComponent(symbol,partNumber),
	constraint pk_tbStandardComponent
	primary key (serialNumber,symbol)
	);

/*******************************************************
	Create sequences
*******************************************************/

CREATE SEQUENCE seq_tbCertification
	MINVALUE 1111111111
	MAXVALUE 9999999999;

CREATE SEQUENCE seq_tbPart
	MINVALUE 1111111111
	MAXVALUE 9999999999;

CREATE SEQUENCE seq_tbStandard
	MINVALUE 1111111111
	MAXVALUE 9999999999;

/*******************************************************
	Create triggers
*******************************************************/

CREATE OR REPLACE TRIGGER trg_platedElement
	BEFORE INSERT OR UPDATE ON tbPart
	FOR EACH ROW
BEGIN
	--If the plated element was not specified
	IF :new.platedElement is null THEN
		--If the standard is Plated, it must have a plated element
		IF :new.typeID = 'P' THEN
			RAISE_APPLICATION_ERROR(-200001,'Plated standards must have a specified plated element.');
		END IF;
	--If the plated element was specified
	ELSE
		--If the standard is not plated, it should not have a plated element
		IF :new.typeID != 'P' THEN
			:new.platedElement := null;
		END IF;
	END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_autoIncCertNumber
	BEFORE INSERT ON tbCertification
	FOR EACH ROW
BEGIN
	--Creates a new certification number using the correct format
	SELECT 'C' || TO_CHAR(seq_tbCertification.NEXTVAL,'FM0000000000')
	INTO :new.certNumber
	FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_autoIncPartNumber
	BEFORE INSERT ON tbPart
	FOR EACH ROW
BEGIN
	--Creates a new part number using the correct format
	SELECT 'P' || TO_CHAR(seq_tbPart.NEXTVAL,'FM0000000000')
	INTO :new.partNumber
	FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_autoIncSerialNumber
	BEFORE INSERT ON tbStandard
	FOR EACH ROW
BEGIN
	--Creates a new standard serial number using the correct format
	SELECT 'S' || TO_CHAR(seq_tbStandard.NEXTVAL,'FM0000000000')
	INTO :new.serialNumber
	FROM dual;
END;
/

--Trigger to ensure that product compositions always sum to 100%
CREATE OR REPLACE TRIGGER trg_productComposition
	BEFORE INSERT or UPDATE or DELETE
	ON tbPartComponent
	FOR EACH ROW
DECLARE
	compositionSum number;
BEGIN
	SELECT
	sum(composition)
	INTO compositionSum
	FROM tbPartComponent
	WHERE partNumber = :new.partNumber;

	IF(compositionSum > 100) THEN
		RAISE_APPLICATION_ERROR(-200001,'Total composition for part '||:new.partNumber||' ('||:new.symbol||') was '||compositionSum||'%. It should not be more than 100%.');
	ELSIF(compositionSum < 100) THEN
		DBMS_OUTPUT.put_line('Total composition for part '||:new.partNumber||' ('||:new.symbol||') was '||compositionSum||'%. It should not be less than 100%.');
	END IF;
END;
/

--Trigger to ensure that standard compositions always sum to 100%
CREATE OR REPLACE TRIGGER trg_standardComposition
	BEFORE INSERT or UPDATE or DELETE
	ON tbStandardComponent
	FOR EACH ROW
DECLARE
	compositionSum number;
BEGIN
	SELECT
	sum(composition)
	INTO compositionSum
	FROM tbStandardComponent
	WHERE serialNumber = :new.serialNumber;

	IF(compositionSum > 100) THEN
		RAISE_APPLICATION_ERROR(-200001,'Total composition for standard '||:new.serialNumber||' ('||:new.symbol||') was '||compositionSum||'%. It should not be more than 100%.');
	ELSIF(compositionSum < 100) THEN
		DBMS_OUTPUT.put_line('Total composition for standard '||:new.serialNumber||' ('||:new.symbol||') was '||compositionSum||'%. It should not be less than 100%.');
	END IF;
END;
/

SPOOL OFF