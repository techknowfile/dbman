CREATE DATABASE policeDepartment;

USE policeDepartment;

CREATE TABLE Person (
			ssn		INTEGER,
birthdate	DATE,
	name		CHAR(60),
	PRIMARY KEY(ssn));
	#CHECK ( ssn < 1000000000 )

CREATE TABLE Detective (
	ssn		INTEGER,
	PRIMARY KEY(ssn),
	FOREIGN KEY(ssn) REFERENCES Person(ssn)
		ON DELETE NO ACTION ON UPDATE NO ACTION);
#check that every detective is a standard user so they have access to reports

CREATE TABLE User (
ssn    		INTEGER,
username	VARCHAR(20) UNIQUE NOT NULL,
password	VARCHAR(20) NOT NULL,
PRIMARY KEY(ssn),
FOREIGN KEY(ssn) REFERENCES Person(ssn)
ON DELETE NO ACTION ON UPDATE NO ACTION);
#CHECK ( password LIKE '%!%' OR password LIKE '%@%' OR password LIKE '%#%'
#OR password LIKE '%$%' OR password LIKE '%\%%' OR password LIKE '%^%' OR
#password LIKE '%&%' OR password LIKE '%*%')

CREATE TABLE Clerk (
			ssn		INTEGER,
PRIMARY KEY(ssn),
FOREIGN KEY(ssn) REFERENCES User(ssn)
	ON DELETE NO ACTION ON UPDATE NO ACTION);
			# check that #clerks + #std users = # users

CREATE TABLE Standard_User (
	ssn		INTEGER,
PRIMARY KEY(ssn),
FOREIGN KEY(ssn) REFERENCES User(ssn)
	ON DELETE NO ACTION ON UPDATE NO ACTION);
#check that no standard user is a clerk

CREATE TABLE Crime (
	cName		VARCHAR(60),
	PRIMARY KEY(cName));
#CHECK ( cName LIKE '%_____%' ) # so it is not too short

CREATE TABLE Report_ReportsOn_Files (
reportNum	INTEGER,
cDatetime	DATETIME,
cAddress	VARCHAR(60),
cDescription	VARCHAR(500),
cName		VARCHAR(60),
clerkSsn	INTEGER,
PRIMARY KEY(reportNum),
FOREIGN KEY(cName) REFERENCES Crime(cName)
ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY(clerkSsn) REFERENCES Clerk(ssn)
ON DELETE NO ACTION ON UPDATE CASCADE);
# maybe check that description has at least 5 words

CREATE TABLE Investigation_RelatesTo (
iNumber	INTEGER,
reportNum	INTEGER UNIQUE NOT NULL,
PRIMARY KEY(iNumber),
FOREIGN KEY(reportNum) REFERENCES Report_ReportsOn_Files(reportNum)
ON DELETE NO ACTION ON UPDATE CASCADE);
			# maybe check that iNumber is positive

CREATE TABLE Suspect_IsOn (
ssn		INTEGER,
iNumber	INTEGER NOT NULL,
PRIMARY KEY(ssn, iNumber),
FOREIGN KEY(ssn) REFERENCES Person(ssn)
ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(iNumber) REFERENCES Investigation_RelatesTo(iNumber)
ON DELETE NO ACTION ON UPDATE CASCADE);
			# maybe check that no suspects are users
			# or maybe check that sNumber is positive

CREATE TABLE StatusOption (
	soName	CHAR(60),
	PRIMARY KEY(soName));
	#CHECK ( soName LIKE '%_____%' )

CREATE TABLE Status_HasStatus_HasOption (
	id INTEGER NOT NULL AUTO_INCREMENT,
	ssn		INTEGER NOT NULL,
    iNumber INTEGER NOT NULL,
	soName	CHAR(60),
	date		DATE NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(ssn, iNumber) REFERENCES Suspect_IsOn(ssn, iNumber)
    	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(soName) REFERENCES StatusOption(soName)
		ON DELETE NO ACTION ON UPDATE CASCADE);
#maybe check that no two statuses for same suspect have same date

CREATE TABLE AssignedTo (
ssn		INTEGER,
iNumber	INTEGER,
PRIMARY KEY(ssn, iNumber),
FOREIGN KEY(ssn) REFERENCES Detective(ssn)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(iNumber) REFERENCES Investigation_RelatesTo(iNumber)
ON DELETE CASCADE ON UPDATE CASCADE);
			# maybe check that no detective is a suspect

CREATE TABLE Precinct (
pName		VARCHAR(30),
phoneNum	VARCHAR(12) UNIQUE,
#cBadgeNum	INTEGER UNIQUE,
PRIMARY KEY(pName));
#FOREIGN KEY(cBadgeNum) REFERENCES Commander(cBadgeNum)
#Note: foreign key removed to remove circular foreign key references
#maybe check that name is at least five characters long

CREATE TABLE Officer_EmployedBy (
	ssn		INTEGER UNIQUE NOT NULL,
badgeNum	INTEGER,
	rank		VARCHAR(30),
	pName		VARCHAR(30),
	PRIMARY KEY(badgeNum),
	FOREIGN KEY(ssn) REFERENCES Person(ssn)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY(pName) REFERENCES Precinct(pName)
ON DELETE NO ACTION ON UPDATE CASCADE);
	# maybe check that badgeNum is positive or that rank at least 3 chars long

#CREATE TABLE Commander (
#	cBadgeNum	INTEGER,
#	PRIMARY KEY(cBadgeNum),
#	FOREIGN KEY(cBadgeNum) REFERENCES 
#	Officer_EmployedBy(badgeNum));
				# maybe check that their precinct has at least 3 officers

CREATE TABLE WorksOn (
	reportNum	INTEGER,
	badgeNum	INTEGER,
	PRIMARY KEY(reportNum),
	FOREIGN KEY(reportNum) REFERENCES Report_ReportsOn_Files(reportNum)
ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(badgeNum) REFERENCES Officer_EmployedBy(badgeNum)
ON DELETE CASCADE ON UPDATE CASCADE);
	# maybe check that reportNum is positive
