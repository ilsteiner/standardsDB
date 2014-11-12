/*******************************************************
	Description: This is the DDL to create the database.

	Student: Isaac Lebwohl-Steiner

	Created: 11/11/2014
*******************************************************/

--Spool our session

spool standardsDB_DDL.sql

/*******************************************************
	Drop Tables

	TODO: Add all tables and drop them here.
*******************************************************/

/*******************************************************
	Drop other things

	TODO: Ensure everything is dropped correctly.
*******************************************************/

/*******************************************************
	Create tables
*******************************************************/

create table tbElement (
	symbol char(2) primary key,
	number char(3) not null,
	name varchar2(13) not null,
	density number(4,2) not null
	);

create table tbType (
	--TODO: Can this be a smallint? Does Oracle support that?
	typeID integer primary key,
	typeName varchar2(16) not null
	);

create table tbCertStatus (
	statusID integer primary key,
	statusDesc varchar2(16) not null
	);

