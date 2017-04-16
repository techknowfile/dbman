LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/person.csv' 
    INTO TABLE policedepartment.person
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/user.csv' 
    INTO TABLE policedepartment.user
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/StandardUser.csv' 
    INTO TABLE policedepartment.standard_user
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/Detective.csv' 
    INTO TABLE policedepartment.detective
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/Clerk.csv' 
    INTO TABLE policedepartment.clerk
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/crime.csv' 
    INTO TABLE policedepartment.crime
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/reportReportOnFiles.csv' 
    INTO TABLE policedepartment.report_reportson_files
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/investigationRelatesTo.csv' 
    INTO TABLE policedepartment.investigation_relatesto
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
# TODO: Assigned to - Foreign key constrain fails

LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/precinctCommandedBy.csv' 
    INTO TABLE policedepartment.precinct
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/statusOption.csv' 
    INTO TABLE policedepartment.statusoption
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/SuspectIsOn.csv' 
    INTO TABLE policedepartment.suspect_ison
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    
LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/statusHasStatusOption.csv' 
    INTO TABLE policedepartment.status_hasstatus_hasoption
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/OfficerEmployedBy.csv' 
    INTO TABLE policedepartment.officer_employedby
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'F:/Courses/CSE 412/Phase 2/MockData/worksOn.csv' 
    INTO TABLE policedepartment.workson
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES;
    

