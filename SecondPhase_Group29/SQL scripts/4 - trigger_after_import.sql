#Detective
DELIMITER //
CREATE TRIGGER detectiveUser BEFORE INSERT ON Detective
FOR EACH ROW
BEGIN
    IF (NEW.ssn) NOT IN (SELECT DISTINCT ssn FROM Standard_User) THEN
        SIGNAL SQLSTATE '45000';
	        	END IF;
END;//

#ASSERTION everySuspectHasStatus
DELIMITER //
CREATE TRIGGER everySuspectHasStatus AFTER INSERT ON Suspect_IsOn
FOR EACH ROW
BEGIN
        	IF (SELECT COUNT(DISTINCT ssn) FROM Suspect_IsOn) - (SELECT COUNT(DISTINCT ssn) FROM Status_HasStatus_HasOption) >= 1 THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
#Note: it only allows at most 1 suspect without a status, rather than 0
#since AFTER INSERT, it may allow the insert

#ASSERTION everyInvestigationHasDetective
DELIMITER //
CREATE TRIGGER everyInvestigationHasDetective AFTER INSERT ON Investigation_RelatesTo
FOR EACH ROW
BEGIN
        	IF (SELECT COUNT(DISTINCT iNumber) FROM Investigation_RelatesTo) - (SELECT COUNT(DISTINCT iNumber) FROM AssignedTo) >= 1 THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
#Note: it only allows at most 1 investigation without a detective, rather than 0
# since AFTER INSERT, it may allow the insert


#ASSERTION everyInvestigationHasDetective2
DELIMITER //
CREATE TRIGGER everyInvestigationHasDetective2 AFTER UPDATE ON Investigation_RelatesTo
FOR EACH ROW
BEGIN
        	IF (SELECT COUNT(DISTINCT iNumber) FROM Investigation_RelatesTo) - (SELECT COUNT(DISTINCT iNumber) FROM AssignedTo) >= 1 THEN
                            	SIGNAL SQLSTATE '45000';
            	END IF;
END;//
#Note: it only allows at most 1 investigation without a detective, rather than 0
# since AFTER INSERT, it may allow the insert

DELIMITER ;
