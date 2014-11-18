/*******************************************************
	Description: This is the DDL to create the database.

	Student: Isaac Lebwohl-Steiner

	Created: 11/18/2014
*******************************************************/

--Spool our session

spool standardsDB_DDL.sql

/*******************************************************
	Insert the data
*******************************************************/

--Insert the Element data
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('H','1','Hydrogen',0.0899);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('He','2','Helium',0.1785);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Li','3','Lithium',0.54);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Be','4','Beryllium',1.85);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('B','5','Boron',2.46);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('C','6','Carbon',2.26);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('N','7','Nitrogen',1.251);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('O','8','Oxygen',1.429);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('F','9','Fluorine',1.696);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ne','10','Neon',0.9);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Na','11','Sodium',0.97);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Mg','12','Magnesium',1.74);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Al','13','Aluminum',2.7);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Si','14','Silicon',2.33);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('P','15','Phosphorus',1.82);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('S','16','Sulfur',1.96);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Cl','17','Chlorine',3.214);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ar','18','Argon',1.784);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('K','19','Potassium',0.86);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ca','20','Calcium',1.55);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Sc','21','Scandium',2.99);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ti','22','Titanium',4.51);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('V','23','Vanadium',6.11);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Cr','24','Chromium',7.14);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Mn','25','Manganese',7.47);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Fe','26','Iron',7.87);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Co','27','Cobalt',8.9);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ni','28','Nickel',8.91);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Cu','29','Copper',8.92);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Zn','30','Zinc',7.14);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ga','31','Gallium',5.9);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ge','32','Germanium',5.32);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('As','33','Arsenic',5.73);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Se','34','Selenium',4.82);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Br','35','Bromine',3.12);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Kr','36','Krypton',3.75);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Rb','37','Rubidium',1.53);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Sr','38','Strontium',2.63);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Y','39','Yttrium',4.47);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Zr','40','Zirconium',6.51);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Nb','41','Niobium',8.57);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Mo','42','Molybdenum',10.28);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Tc','43','Technetium',11.5);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ru','44','Ruthenium',12.37);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Rh','45','Rhodium',12.45);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Pd','46','Palladium',12.02);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ag','47','Silver',10.49);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Cd','48','Cadmium',8.65);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('In','49','Indium',7.31);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Sn','50','Tin',7.31);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Sb','51','Antimony',6.7);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Te','52','Tellurium',6.24);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('I','53','Iodine',4.94);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Xe','54','Xenon',0.01);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Cs','55','Cesium',1.88);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ba','56','Barium',3.51);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('La','57','Lanthanum',6.15);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ce','58','Cerium',6.69);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Pr','59','Praseodymium',6.64);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Nd','60','Neodymium',7.01);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Pm','61','Promethium',7.26);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Sm','62','Samarium',7.35);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Eu','63','Europium',5.24);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Gd','64','Gadolinium',7.9);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Tb','65','Terbium',8.22);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Dy','66','Dysprosium',8.55);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ho','67','Holmium',8.8);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Er','68','Erbium',9.07);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Tm','69','Thulium',9.32);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Yb','70','Ytterbium',6.57);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Lu','71','Lutetium',9.84);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Hf','72','Hafnium',13.31);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ta','73','Tantalum',16.65);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('W','74','Tungsten',19.25);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Re','75','Rhenium',21.02);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Os','76','Osmium',22.61);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ir','77','Iridium',22.65);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Pt','78','Platinum',21.09);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Au','79','Gold',19.3);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Hg','80','Mercury',13.53);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Tl','81','Thallium',11.85);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Pb','82','Lead',11.34);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Bi','83','Bismuth',9.78);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Po','84','Polonium',9.2);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('At','85','Astatine',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Rn','86','Radon',0.01);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Fr','87','Francium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ra','88','Radium',5);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Ac','89','Actinium',10.07);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Th','90','Thorium',11.72);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Pa','91','Protactinium',15.37);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('U','92','Uranium',19.05);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Np','93','Neptunium',20.45);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Pu','94','Plutonium',19.82);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Am','95','Americium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Cm','96','Curium',13.51);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Bk','97','Berkelium',14.78);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Cf','98','Californium',15.1);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Es','99','Einsteinium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Fm','100','Fermium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Md','101','Mendelevium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('No','102','Nobelium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Lr','103','Lawrencium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Rf','104','Rutherfordium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Db','105','Dubnium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Sg','106','Seaborgium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Bh','107','Bohrium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Hs','108','Hassium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Mt','109','Meitnerium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uun','110','Ununnilium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uuu','111','Unununium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uub','112','Ununbium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uut','113','Ununtrium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uuq','114','Ununquadium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uup','115','Ununpentium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uuh','116','Ununhexium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uus','117','Ununseptium',null);
INSERT INTO tbElement (symbol,atomicNumber,name,density) VALUES ('Uuo','118','Ununoctium',null);