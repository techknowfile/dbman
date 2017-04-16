USE policeDepartment;
START TRANSACTION;
LOAD DATA LOCAL INFILE '../MockData/person.csv' 
    INTO TABLE policeDepartment.Person
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '../MockData/user.csv' 
    INTO TABLE policeDepartment.User
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/StandardUser.csv' 
    INTO TABLE policeDepartment.Standard_User
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/Detective.csv' 
    INTO TABLE policeDepartment.Detective
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/Clerk.csv' 
    INTO TABLE policeDepartment.Clerk
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '../MockData/crime.csv' 
    INTO TABLE policeDepartment.Crime
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/reportReportOnFiles.csv' 
    INTO TABLE policeDepartment.Report_ReportsOn_Files
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/investigationRelatesTo.csv' 
    INTO TABLE policeDepartment.Investigation_RelatesTo
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/assignedTo.csv' 
    INTO TABLE policeDepartment.AssignedTo
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '../MockData/precinctCommandedBy.csv' 
    INTO TABLE policeDepartment.Precinct
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/statusOption.csv' 
    INTO TABLE policeDepartment.StatusOption
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/SuspectIsOn.csv' 
    INTO TABLE policeDepartment.Suspect_IsOn
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE '../MockData/statusHasStatusOption.csv' 
    INTO TABLE policeDepartment.Status_HasStatus_HasOption
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '../MockData/OfficerEmployedBy.csv' 
    INTO TABLE policeDepartment.Officer_EmployedBy
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '../MockData/worksOn.csv' 
    INTO TABLE policeDepartment.WorksOn
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
COMMIT;
