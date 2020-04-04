-- 个人信息表
CREATE TABLE personaldetails(
    staffnumber VARCHAR2(10) PRIMARY KEY,
    familyname VARCHAR2(20) NOT NULL,
    givennames VARCHAR2(20) NOT NULL,
    streetaddress VARCHAR2(20) NOT NULL,
    suburb VARCHAR2(20) NOT NULL,
    "STATE" VARCHAR2(10) NOT NULL,
    postcode VARCHAR2(10) NOT NULL,
    gerder VARCHAR2(5) NOT NULL,
    dateofbirth DATE NOT NULL,
    telephoneno VARCHAR2(20) NOT NULL,
    "POSITION" VARCHAR2(20) NOT NULL,
    allocatedtoward VARCHAR2(20) NOT NULL,
    currentsalary VARCHAR2(10) NOT NULL,
    hoursperweek NUMBER(5,2) NOT NULL,
    salaryscale VARCHAR2(10) NOT NULL,
    permanentortemporary VARCHAR2(5) NOT NULL,
    paidweeklyormonthly VARCHAR2(5) NOT NULL
);

-- 数据更新记录表
CREATE TABLE personnel_officer_record(   
    staffnumber VARCHAR2(30)NOT NULL,
    update_type VARCHAR2(10)NOT NULL,
    sydate date NOT NULL,
    Personnelofficer_name VARCHAR2(50) NOT NULL
);

-- 学历资格表
CREATE TABLE qualifications(
    qualificationsid NUMBER(10) PRIMARY KEY,
    staffnumber  VARCHAR2(10) NOT NULL REFERENCES personaldetails(staffnumber),
    "TYPE" VARCHAR2(50) NOT NULL,
    dateawarded DATE NOT NULL,
    institution VARCHAR(50) NOT NULL
);


-- 工作经历表
CREATE TABLE workexperience(
    workexperienceid NUMBER(10) PRIMARY KEY,
    staffnumber VARCHAR2(10) NOT NULL REFERENCES personaldetails(staffnumber),
    "POSITION" VARCHAR2(20) NOT NULL,
    organisation VARCHAR2(20) NOT NULL,
    startdate DATE NOT NULL,
    finishdate DATE NOT null
);



-- 5a 创建新员工
INSERT INTO personaldetails(
    staffnumber, 
    familyname,  
    givennames,    
    streetaddress,
    suburb,
    "STATE",
    postcode,
    gerder,
    dateofbirth,
    telephoneno,
    "POSITION",
    allocatedtoward,
    currentsalary,
    hoursperweek,
    salaryscale,
    permanentortemporary,
    paidweeklyormonthly
)VALUES(
    'S4576','Samuels','Moira','49 School Road','Bedford','WA','6052','F',to_date('30-05-1990', 'dd-mm-yyyy'),'0150-456-3357',
    'Charge Nurse','11','68760','37.5','1C','P','M'
);



INSERT INTO qualifications(qualificationsid,staffnumber,"TYPE",dateawarded,institution)
VALUES(1,'S4576','BSc.(Nursing)',to_date('12-07-2010','dd-mm-yyyy'),'Curtain University');
INSERT INTO qualifications(qualificationsid,staffnumber,"TYPE",dateawarded,institution)
VALUES(2,'S4576','PostGraduateDiploma.(Geriatrics)',to_date('22-07-2012','dd-mm-yyyy'),'Enid Blyton University');

INSERT INTO workexperience(workexperienceid,staffnumber,"POSITION",organisation,startdate,finishdate)
VALUES(1,'S4576','Charge Nurse','Eastern Hospital',to_date('23-01-2011','dd-mm-yyyy'),to_date('01-05-2011','dd-mm-yyyy'));
INSERT INTO workexperience(workexperienceid,staffnumber,"POSITION",organisation,startdate,finishdate)
VALUES(2,'S4576','Charge Nurse','Eastern Hospital',to_date('01-06-2011','dd-mm-yyyy'),to_date('23-02-2012','dd-mm-yyyy'));


-- 5b
CREATE TABLE patientdetails(
    patientnumber VARCHAR2(20) PRIMARY KEY,
    familyname VARCHAR2(50) NOT NULL,
    givennames VARCHAR2(50) NOT NULL,
    streetaddress VARCHAR2(50) NOT NULL,
    suburb VARCHAR2(50) NOT NULL,
    "STATE" VARCHAR2(50) NOT NULL,
    postcode VARCHAR2(50) NOT NULL,
    gender VARCHAR2(10) NOT NULL,
    dateofbirth date NOT NULL,
    maritalstatus VARCHAR2(10) NOT NULL,
    telephoneno VARCHAR2(50) NOT NULL
);

CREATE TABLE nextofkindetails(
    nextofkindetailsid NUMBER(10) PRIMARY KEY,
    patientnumber VARCHAR2(20) NOT NULL REFERENCES patientdetails(patientnumber),
    fullname VARCHAR2(50) NOT NULL,
    streetaddress VARCHAR2(100) NOT NULL,
    suburb VARCHAR2(50) NOT NULL,
    "STATE" VARCHAR2(50) NOT NULL,
    postcode VARCHAR2(10) NOT NULL,
    relationship VARCHAR2(50) NOT NULL,
    telephoneno VARCHAR2(30) NOT NULL
);

CREATE TABLE localdoctordetails(
    patientnumber VARCHAR2(20) NOT NULL REFERENCES patientdetails(patientnumber),
    fullname VARCHAR2(50) NOT NULL,
    streetaddress VARCHAR2(100) NOT NULL,
    suburb VARCHAR2(30) NOT NULL,
    "STATE" VARCHAR2(10) NOT NULL,
    postcode VARCHAR2(10) NOT NULL,
    providerno VARCHAR2(20) NOT NULL,
    telephoneno VARCHAR2(30) NOT NULL
);

INSERT INTO patientdetails(
    patientnumber,familyname,givennames,streetaddress,suburb,"STATE",postcode,gender,dateofbirth,maritalstatus,telephoneno
)VALUES('P10234','Phelps','Anne','67 Wellmeaning Way','Wellington','WA','6858','F',TO_DATE('10-12-1955','dd-mm-yyyy'),'M','0131-332-4158');

INSERT INTO nextofkindetails(
    nextofkindetailsid,patientnumber,fullname,streetaddress,suburb,"STATE",postcode,relationship,telephoneno
)VALUES(1,'P10234','James Phelps','67 Wellmeaning Way','Wellington','WA','6858','Spouse','0131-332-4158');

INSERT INTO localdoctordetails(
    patientnumber,fullname,streetaddress,suburb,"STATE",postcode,providerno,telephoneno
)VALUES('P10234','Dr Helen Pearson','47 Kennedy Street','Murrayville','WA','6855','1455784L','0131-332-6282');



-- 5c
CREATE TABLE wardinfo(
    weekbeginning DATE NOT NULL,
    wardnumber VARCHAR2(10) PRIMARY KEY,
    wardname VARCHAR2(30) NOT NULL,
    "LOCATION" VARCHAR2(30) NOT NULL,
    telephoneextension VARCHAR2(10) NOT NULL,
    chargenurse VARCHAR2(30) NOT NULL,
    staffnumber VARCHAR2(30) NOT NULL REFERENCES personaldetails(staffnumber)
);

CREATE TABLE staffallocationlisting(
    staffallocationlistingid NUMBER(10) NOT NULL,
    weekbeginning DATE NOT NULL,
    wardnumber VARCHAR2(10) NOT NULL REFERENCES wardinfo(wardnumber),
    staffno VARCHAR2(20) NOT NULL,
    "NAME" VARCHAR2(50) NOT NULL,
    "POSITION" VARCHAR2(30) NOT NULL,
    shift VARCHAR2(20)NOT NULL 
);
-- 病房病人信息报告表
CREATE TABLE wardpatientsreport(
    wardpatientsreportid NUMBER(10) NOT NULL PRIMARY KEY,
    wardnumber VARCHAR2(10) NOT NULL REFERENCES wardinfo(wardnumber),
    patientnumber VARCHAR(30) NOT NULL REFERENCES patientdetails(patientnumber),
    "NAME" VARCHAR2(30) NOT NULL,
    onwaitinglist DATE NOT NULL,
    expectedstay_days NUMBER(10) NOT NULL,
    dateplaced DATE NOT NULL,
    dateleave DATE NOT NULL,
    actualleave DATE,
    bednumber NUMBER(10) NOT NULL
);
drop table wardpatientsreport;

INSERT INTO wardinfo(
    weekbeginning,wardnumber,wardname,"LOCATION",telephoneextension,chargenurse,staffnumber
)VALUES(TO_DATE('09-01-2012','dd-mm-yyyy'),'11','Orthopaedic','Block E','7711','Moira Samuel','S4576');



-- 6
-- 6a
CREATE OR REPLACE VIEW View_A
    AS
    SELECT s.wardnumber,count(s."NAME") as bieming
    from staffallocationlisting s
    group by s.wardnumber
    ;
select * from view_a;

-- 6b
CREATE OR REPLACE VIEW View_B
    AS
    SELECT onwaitinglist,patientnumber,"NAME"
    FROM wardpatientsreport 
    WHERE TO_CHAR(dateplaced,'mm-yyyy')=TO_CHAR(SYSDATE,'mm-yyyy')
    ;
select * from view_b;


-- 6c
CREATE OR REPLACE VIEW View_C
    AS
    SELECT "NAME",dateplaced,dateleave,bednumber
    FROM  wardpatientsreport WHERE dateplaced BETWEEN sysdate-interval '1' year AND SYSDATE and wardnumber = 11
    ;

select * from view_C;

-- 6d
CREATE OR REPLACE VIEW View_D
    AS
    SELECT w.dateplaced, l.fullname, l.streetaddress, l.telephoneno, l.providerno ,COUNT(l.patientnumber) AS bieming2
    FROM localdoctordetails l ,wardpatientsreport w
    WHERE w.dateplaced >= add_months(sysdate,-6) and w.dateplaced <= sysdate
    group by w.dateplaced,l.fullname, l.streetaddress, l.telephoneno, l.providerno
    ;

select * from view_d;


-- set serveroutput on; 
-- 7a
/** 
    1 如果当前时间减去病人离开的时间小于0则获取到正在被占用的床位总数(iExists)。
    2 如果正在被占用的床位总数(iExists)大于或等于0并且不超过医院中的床位总数,则能够执行插入病人数据的操作。            
*/
DECLARE
iExists INT;
BEGIN
  SELECT COUNT(*) INTO iExists FROM wardpatientsreport WHERE TRUNC(SYSDATE) - dateleave < 0 ;
  IF iExists >= 0 AND iExists < 240 THEN
    INSERT INTO wardpatientsreport (wardpatientsreportid,wardnumber,patientnumber,"NAME",onwaitinglist, 		
expectedstay_days,dateplaced,dateleave,bednumber) 
VALUES(9,'12','P20003','zhoubotong',TO_DATE('31-3-2020','dd-mm-yyyy'),3,TO_DATE('31-3-2020','dd-mm-yyyy'),
TO_DATE('3-4-2020','dd-mm-yyyy'),66);
    END IF;
END;


-- 7b
/**
一个触发器tri_one,当personaldetails(员工个人信息表)被人事干事 Linghu Chong 执行update操作后,将在
personnel_officer_record(数据更新记录表)中插入一条数据,包含：
被更新人的员工编号,操作类型,执行更新的时间,负责更新员工信息的人姓名.
*/
create or replace trigger tri_one 
after update on personaldetails 
for each row
begin
    insert into personnel_officer_record(staffnumber,update_type,sydate,Personnelofficer_name)
    values(:old.staffnumber,'UPDATE',sysdate,'Linghu Chong');
end;

-- update personaldetails set postcode = '9990' where staffnumber = 'S0980';
