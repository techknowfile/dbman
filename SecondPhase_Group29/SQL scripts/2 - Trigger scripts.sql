USE policeDepartment;
START TRANSACTION;
#Person
DELIMITER //
CREATE TRIGGER ssnLength BEFORE INSERT ON Person
FOR EACH ROW
BEGIN
            	IF new.ssn >= 1000000000 THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//

#Detective
#DELIMITER //
#CREATE TRIGGER detectiveUser BEFORE INSERT ON Detective
#FOR EACH ROW
#BEGIN
#IF (NEW.ssn) NOT IN (SELECT DISTINCT ssn FROM Standard_User) THEN
#SIGNAL SQLSTATE '45000';
#	        	END IF;
#END;//

#User
DELIMITER //
CREATE TRIGGER userPassword BEFORE INSERT ON User
FOR EACH ROW
BEGIN
IF NEW.password NOT LIKE '%!%' AND NEW.password NOT LIKE '%@%'
AND NEW.password NOT LIKE '%#%' AND NEW.password NOT LIKE '%$%'
AND NEW.password NOT LIKE '%\%%' AND NEW.password NOT LIKE '%^%'
AND NEW.password NOT LIKE '%&%' AND NEW.password NOT LIKE '%*%' THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//

#Clerk
#prevents insertion of row into Clerk that is already in Standard_User
DELIMITER //
CREATE TRIGGER clerkNotStduser BEFORE INSERT ON Clerk
FOR EACH ROW
BEGIN
IF (NEW.ssn) IN (SELECT DISTINCT ssn FROM Standard_User) THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//
 
#Standard_User
DELIMITER //
CREATE TRIGGER stduserNotClerk BEFORE INSERT ON Standard_User
FOR EACH ROW
BEGIN
IF (NEW.ssn) IN (SELECT DISTINCT ssn FROM Clerk) THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//
 
#Suspect_IsOn
DELIMITER //
CREATE TRIGGER suspectNotUser BEFORE INSERT ON Suspect_IsOn
FOR EACH ROW
BEGIN
IF (NEW.ssn) IN (SELECT DISTINCT ssn FROM User) THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//

#StatusOption
DELIMITER //
CREATE TRIGGER statusOptionName BEFORE INSERT ON StatusOption
FOR EACH ROW
BEGIN
    IF (NEW.soName NOT LIKE '%_____%') THEN
   	 SIGNAL SQLSTATE '45000';
    END IF;
END;//
#Note: StatusOption will not accept more than 4 spaces, if only spaces. However, if four spaces followed by another character, it will be accepted. Also, if other character followed by four other spaces, not accepted.

#Status_HasStatus_HasOption
DELIMITER //
CREATE TRIGGER dateLimit BEFORE INSERT ON Status_HasStatus_HasOption
FOR EACH ROW
BEGIN
            	IF (NEW.date < '1900-01-01') THEN
                            	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Date prior to 1900-01-01 not allowed!';
            	END IF;
END;//

#Investigation_RelatesTo
DELIMITER //
CREATE TRIGGER positiveINumber BEFORE INSERT ON Investigation_RelatesTo
FOR EACH ROW
BEGIN
            	IF (NEW.iNumber <= 0) THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//

#AssignedTo
DELIMITER //
CREATE TRIGGER userdetectiveNotSuspect BEFORE INSERT ON AssignedTo
FOR EACH ROW
BEGIN
            	IF NEW.ssn IN (SELECT DISTINCT ssn FROM suspect_ison) THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
#Note: This prevents insert into suspect, then insert the suspect into user, then insert suspect into detective, then insert suspect into assignedTo, the last of which should fail.

#Precinct
DELIMITER //
CREATE TRIGGER precinctName BEFORE INSERT ON Precinct
FOR EACH ROW
BEGIN
            	IF NEW.pName NOT LIKE '%___%' THEN
                            	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="Precinct name not like '%___%'";
            	END IF;
END;//
 
#Officer­_EmployedBy
DELIMITER //
CREATE TRIGGER positiveBadgeNum BEFORE INSERT ON Officer_EmployedBy
FOR EACH ROW
BEGIN
            	IF (NEW.badgeNum <= 0) THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//

#Report_ReportsOn_Files
DELIMITER //
CREATE TRIGGER minReportLength BEFORE INSERT ON Report_ReportsOn_Files
FOR EACH ROW
BEGIN
            	IF (NEW.cDescription NOT LIKE '_% _% _% _% _%') THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
#Note: can get away with fewer than five words with extra spaces

#WorksOn
DELIMITER //
CREATE TRIGGER positiveReportNum BEFORE INSERT ON WorksOn
FOR EACH ROW
BEGIN
            	IF (NEW.reportNum <= 0) THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
 
#Crime
DELIMITER //
CREATE TRIGGER minCNameLength BEFORE INSERT ON Crime 
FOR EACH ROW
BEGIN
            	IF (NEW.cName NOT LIKE '%_____%') THEN
                            	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Crime name length not like '%_____%'";
            	END IF;
END;//


#ASSERTION everySuspectHasStatus
#DELIMITER //
#CREATE TRIGGER everySuspectHasStatus AFTER INSERT ON Suspect_IsOn
#FOR EACH ROW
#BEGIN
#        	IF (SELECT COUNT(DISTINCT sNumber) FROM Suspect_IsOn) - (SELECT COUNT(DISTINCT sNumber) FROM Status_HasStatus_HasOption) >= 1 THEN
#                            	SIGNAL SQLSTATE '45000';
#            	END IF;
#END;//
#Note: it only allows at most 1 suspect without a status, rather than 0
# since AFTER INSERT, it may allow the insert

#ASSERTION everyInvestigationHasDetective
#DELIMITER //
#CREATE TRIGGER everyInvestigationHasDetective AFTER INSERT ON Investigation_RelatesTo
#FOR EACH ROW
#BEGIN
#        	IF (SELECT COUNT(DISTINCT iNumber) FROM Investigation_RelatesTo) - (SELECT COUNT(DISTINCT iNumber) FROM AssignedTo) >= 1 THEN
#                            	SIGNAL SQLSTATE '45000';
#            	END IF;
#END;//
#Note: it only allows at most 1 investigation without a detective, rather than 0
# since AFTER INSERT, it may allow the insert


#UPDATE TRIGGERS

#Person
DELIMITER //
CREATE TRIGGER ssnLength2 BEFORE UPDATE ON Person
FOR EACH ROW
BEGIN
            	IF new.ssn >= 1000000000 THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
 
#Detective
DELIMITER //
CREATE TRIGGER detectiveUser2 BEFORE UPDATE ON Detective
FOR EACH ROW
BEGIN
IF (NEW.ssn) NOT IN (SELECT DISTINCT ssn FROM Standard_User) THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//

#User
DELIMITER //
CREATE TRIGGER userPassword2 BEFORE UPDATE ON User
FOR EACH ROW
BEGIN
IF NEW.password NOT LIKE '%!%' AND NEW.password NOT LIKE '%@%'
AND NEW.password NOT LIKE '%#%' AND NEW.password NOT LIKE '%$%'
AND NEW.password NOT LIKE '%\%%' AND NEW.password NOT LIKE '%^%'
AND NEW.password NOT LIKE '%&%' AND NEW.password NOT LIKE '%*%' THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//

#Clerk
#prevents insertion of row into Clerk that is already in Standard_User
DELIMITER //
CREATE TRIGGER clerkNotStduser2 BEFORE UPDATE ON Clerk
FOR EACH ROW
BEGIN
IF (NEW.ssn) IN (SELECT DISTINCT ssn FROM Standard_User) THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//
 
#Standard_User
DELIMITER //
CREATE TRIGGER stduserNotClerk2 BEFORE UPDATE ON Standard_User
FOR EACH ROW
BEGIN
IF (NEW.ssn) IN (SELECT DISTINCT ssn FROM Clerk) THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//
 
#Suspect_IsOn
DELIMITER //
CREATE TRIGGER suspectNotUser2 BEFORE UPDATE ON Suspect_IsOn
FOR EACH ROW
BEGIN
IF (NEW.ssn) IN (SELECT DISTINCT ssn FROM User) THEN
SIGNAL SQLSTATE '45000';
	        	END IF;
END;//

#StatusOption
DELIMITER //
CREATE TRIGGER statusOptionName2 BEFORE UPDATE ON StatusOption
FOR EACH ROW
BEGIN
    IF (NEW.soName NOT LIKE '%_____%') THEN
   	 SIGNAL SQLSTATE '45000';
    END IF;
END;//
#Note: StatusOption will not accept more than 4 spaces, if only spaces. However, if four spaces followed by another character, it will be accepted. Also, if other character followed by four other spaces, not accepted.

#Status_HasStatus_HasOption
DELIMITER //
CREATE TRIGGER dateLimit2 BEFORE UPDATE ON Status_HasStatus_HasOption
FOR EACH ROW
BEGIN
            	IF (NEW.date < '1900-01-01') THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//

#Investigation_RelatesTo
DELIMITER //
CREATE TRIGGER positiveINumber2 BEFORE UPDATE ON Investigation_RelatesTo
FOR EACH ROW
BEGIN
            	IF (NEW.iNumber <= 0) THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//

#AssignedTo
DELIMITER //
CREATE TRIGGER detectiveNotSuspect2 BEFORE UPDATE ON AssignedTo
FOR EACH ROW
BEGIN
            	IF NEW.ssn IN (SELECT DISTINCT ssn FROM suspect_ison) THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
#Note: This prevents insert into suspect, then insert the suspect into user, then insert suspect into detective, then insert suspect into assignedTo, the last of which should fail.

#Precinct
DELIMITER //
CREATE TRIGGER precinctName2 BEFORE UPDATE ON precinct
FOR EACH ROW
BEGIN
            	IF NEW.pName NOT LIKE '%_____%' THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
 
#Officer­_EmployedBy
DELIMITER //
CREATE TRIGGER positiveBadgeNum2 BEFORE UPDATE ON Officer_EmployedBy
FOR EACH ROW
BEGIN
            	IF (NEW.badgeNum <= 0) THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//

 
#Report_ReportsOn_Files
DELIMITER //
CREATE TRIGGER minReportLength2 BEFORE UPDATE ON Report_ReportsOn_Files
FOR EACH ROW
BEGIN
            	IF (NEW.cDescription NOT LIKE '_% _% _% _% _%') THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
#Note: can get away with fewer than five words with extra spaces

#WorksOn
DELIMITER //
CREATE TRIGGER positiveReportNum2 BEFORE UPDATE ON WorksOn
FOR EACH ROW
BEGIN
            	IF (NEW.reportNum <= 0) THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
 
#Crime
DELIMITER //
CREATE TRIGGER minCNameLength2 BEFORE UPDATE ON Crime
FOR EACH ROW
BEGIN
            	IF (NEW.cName NOT LIKE '%_____%') THEN
                            	SIGNAL SQLSTATE '45000' SET message_text = "Crime name not like '%_____%'";
            	END IF;
END;//

#ASSERTION everySuspectHasStatus2
#DELIMITER //
#CREATE TRIGGER everySuspectHasStatus2 AFTER UPDATE ON Suspect_IsOn
#FOR EACH ROW
#BEGIN
#        	IF (SELECT COUNT(DISTINCT sNumber) FROM suspect_ison) - (SELECT COUNT(DISTINCT sNumber) FROM Status_HasStatus_HasOption) >= 1 THEN
#                            	SIGNAL SQLSTATE '45000' SET message_text = "Every suspect doesn't have a status.";
#            	END IF;
#END;//
#Note: it only allows at most 1 suspect without a status, rather than 0
# since AFTER INSERT, it may allow the insert

#ASSERTION everyInvestigationHasDetective2
#DELIMITER //
#CREATE TRIGGER everyInvestigationHasDetective2 AFTER UPDATE ON Investigation_RelatesTo
#FOR EACH ROW
#BEGIN
#        	IF (SELECT COUNT(DISTINCT iNumber) FROM Investigation_RelatesTo) - (SELECT COUNT(DISTINCT iNumber) FROM AssignedTo) >= 1 THEN
#                            	SIGNAL SQLSTATE '45000';
#            	END IF;
#END;//
#Note: it only allows at most 1 investigation without a detective, rather than 0
# since AFTER INSERT, it may allow the insert

DELIMITER ;
COMMIT;
