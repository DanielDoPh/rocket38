/*
2023 10 02 Mon MySQL Lesson6
Store producer
Function (customized)
Optical JOIN ... 
(auto update data across tables by FK, 
ex on delete/update...
Mode Cascade/No Action/Set null/set Default)
..

*/

use dbrocket38;

DROP PROCEDURE IF EXISTS getDpmtName;

DELIMITER $$
-- CREATE PROCEDURE getAllDpmtName (IN dpmtID int, OUT outAccountName)
CREATE PROCEDURE getAllDpmtName ( OUT outDpmtNames varchar(77))
	BEGIN
		SELECT departmentName 
        FROM department;
    END $$
DELIMITER ;
-- exec = CALL
-- set @variableName  = ''
-- CALL getAllDpmtName(1,@variableName);
-- view = SELECT 
-- Select @variableName 
-- can DECLARE a var in PROD and print (select) the var out,
-- CAN out-param a table
-- To compare with customized Function ~

/* FUNCTION return only 1 out param (required)
 CREATE FUNCTION functionName (invar datatype) RETURNS datatype
 	BEGIN
		DECLARE ...;
		SELECT ...;
		RETURN ...;
 	END
*/
-- exec = SELECT functionName

-- Q1 create Store in dpmtID out all account in the dpmt 
/* DROP PROCEDURE IF EXISTS getAllAccInDpmt;
DELIMETER $$
CREATE PROCEDURE getAllAccInDpmt
	(in dpmtID int)
	BEGIN
		SELECT ac.FullName
        FROM `account` as ac
        WHERE dpmtID = ac.FK_DepartmentID;
    END $$
DELIMETER ;
*/
call getAllAccInDpmt(2);

-- Q6 create a Store: IN inString, OUT GroupName (or-> AND) UserName contain the inString
-- Store create at ...
-- from Diep Tran, find_in_set 


DELIMITER $$
create procedure getACCOUNT_GROUP_CHUOI(in chuoi varchar(37), out fname varchar(37) , out out_groupname varchar(37))
begin 
select ac.FullName into fname  from `account` as ac where find_in_set(chuoi, ac.FullName) >0 limit 1;
select groupname into out_groupname  from `group` where find_in_set(chuoi, groupname) >0 limit 1 ;
end$$
DELIMITER ;

set @fname ='';
set @out_groupname ='';
call getACCOUNT_GROUP_CHUOI('n', @fname,@out_groupname);
select @fname,@out_groupname;

-- or just LOCATE is enough?
set @outfn = '', @outgrn='';
call getGrNameOrUsrNameByInput('N', @outfn, @outgrn);
select @outfn, @outgrn;


/*
'2023 10 04 01:10 PM Wed'
Extra assignment 6
*/
DROP database IF EXISTS dbasm6;
create database if not exists dbasm6;

use dbasm6;

create table employee (
	empID int AUTO_INCREMENT PRIMARY KEY,
    empLastName VARCHAR(37) not null,
    empFirstName VARCHAR(37) not null,
    empHireDate DATE,
    empStatus TINYINT(3),
    SupervisorID INT,
    SSN VARCHAR(37)
);

CREATE TABLE project (
	prjID int AUTO_INCREMENT PRIMARY KEY,
    managerID int,
    prjName TEXT not null,
	prjStartDate DATE,
    prjDescription TEXT,
    prjDetail TEXT,
    projCompletedOn DATE,
	FOREIGN KEY (managerID) REFERENCES employee (empID) on update CASCADE on DELETE CASCADE
);

CREATE TABLE Project_Module(
	ID int AUTO_INCREMENT PRIMARY KEY,
    prjID int,
    empID int,
    PlanDate DATE,
    CompletedOn DATE,
    `description` TEXT,
    FOREIGN KEY (prjID) REFERENCES project (prjID) on update CASCADE on DELETE CASCADE,
    FOREIGN KEY (empID) REFERENCES employee (empID) on update CASCADE on DELETE CASCADE
);

CREATE TABLE WorkDone(
	ID int AUTO_INCREMENT PRIMARY KEY,
    empID int,
    mdlID int,
    wdDate DATE,
    wdDescription TEXT,
    wdStatus TINYINT,
    FOREIGN KEY (mdlID) REFERENCES Project_Module (ID) on update CASCADE on DELETE CASCADE,
    FOREIGN KEY (empID) REFERENCES employee (empID) on update CASCADE on DELETE CASCADE
);

INSERT INTO `employee`
(
`empLastName`,
`empFirstName`,
`empHireDate`,
`empStatus`,
`SupervisorID`,
`SSN`)
VALUES
('Phùng Văn', 'Nhất', '2020-04-25', 1, 0, '0123456789'),
('Nguyễn Văn', 'Nhị', '2020-08-08', 1, 1, '0123456780'),
('Phạm Văn', 'Ba', '2021-01-19', 1, 1, '0123456781'),
('Trịnh Văn', 'Tứ', '2021-06-25', 1, 2, '0123456782'),
('Hoàng Quân', 'Ngũ', '2021-10-25', 1, 3, '0123456783')
;

INSERT INTO `project`
(
`managerID`,
`prjName`,
`prjStartDate`,
`prjDescription`,
`prjDetail`,
`projCompletedOn`)
VALUES
(1, 'Hát', '2020-05-02','Mô tả gì đó', 'Detail ư?' ,'2020-09-30'),
(2, 'Múa', '2020-08-20','Mô tả gì đó', 'Detail ư?' ,'2020-11-30'),
(1, 'Nhảy', '2020-07-07','Mô tả gì đó', 'Detail ư?' ,'2020-10-31'),
(3, 'Ngủ', '2021-03-08','Mô tả gì đó', 'Detail ư?' ,'2021-04-29'),
(4, 'Lăn', '2021-07-21','Mô tả gì đó', 'Detail ư?' ,'2021-09-30')
;

INSERT INTO `project_module`
(
`prjID`,
`empID`,
`PlanDate`,
`CompletedOn`,
`description`)
VALUES
(1,1, '2020-05-22', '2020-05-19', 'Chân'),
(1,2, '2020-08-22', '2020-08-18', 'Bánh xe'),
(2,1, '2020-09-01', '2020-08-29', 'Tay'),
(2,2, '2020-09-10', '2020-09-07', 'Bụng'),
(3,1, '2020-07-31', '2020-07-28', 'Vai'),
(3,2, '2020-08-14', '2020-08-07', 'Cổ'),
(4,3, '2021-03-31', '2021-03-25', 'Lưng')
;

INSERT INTO `workdone`
(
`empID`,
`mdlID`,
`wdDate`,
`wdDescription`,
`wdStatus`)
VALUES
(1, 1, '2020-05-03', 'Mô tả work done 1 d2', 0),
(1, 1, '2020-05-04', 'Mô tả work done 1 d3', 0),
(1, 1, '2020-05-05', 'Mô tả work done 1 d4', 0),
(1, 1, '2020-05-06', 'Mô tả work done 1 d5', 0),
(1, 1, '2020-05-07', 'Mô tả work done 1 d6', 0),
(1, 1, '2020-05-08', 'Mô tả work done 1 d7', 0),
(1, 1, '2020-05-09', 'Mô tả work done 1 d8', 0)
;

-- Questions
-- b, Viết stored procedure (không có parameter) để Remove tất cả thông tin
-- project đã hoàn thành sau 3 tháng kể từ ngày hiện. In số lượng record đã
-- remove từ các table liên quan trong khi removing (dùng lệnh print)

create table tbl1(
	f1 int PRIMARY KEY AUTO_INCREMENT,
    f2 int,
    f3 int 
);
create table tbl2(
	f21 int PRIMARY KEY AUTO_INCREMENT,
    f22 int,
    f1 int,
    FOREIGN KEY (f1) REFERENCES tbl1 (f1) ON UPDATE CASCADE ON DELETE CASCADE
);

insert into tbl1 (f1, f2 , f3)
values 
	(2,1,5), (3,1,3);
insert into tbl2 ( f22 , f1)
values 
	(3,2), (2,2), (4,2);   
select * from tbl2;


DROP PROCEDURE IF EXISTS RemovePrjAfter3M;

DELIMITER $$
CREATE PROCEDURE RemovePrjAfter3M ()
BEGIN 
	DELETE from tbl1 where f1=2;
	select ROW_COUNT();
END $$
DELIMITER ;

Call RemovePrjAfter3M();

-- c.Viết stored procedure (có parameter) để in ra các module đang được thực hiện

DROP PROCEDURE IF EXISTS WorkingModule;

DELIMITER $$
CREATE PROCEDURE WorkingModule (IN stt int)
BEGIN 
	select pm.ID as ModuleID, pm.prjID as ProjectID, wd.wdStatus as Status,
		wd.wdDate as Dates, wd.wdDescription as Descrpts
    from Project_module as pm 
		join workdone as wd on pm.ID = wd.mdlID
	where wd.wdStatus =0;
END $$
DELIMITER ;

Call WorkingModule(0);

-- d, Viết hàm (có parameter) trả về thông tin 1 nhân viên đã tham gia làm mặc
-- 	dù không ai giao việc cho nhân viên đó (trong bảng Works)

DROP FUNCTION IF EXISTS WhoThat;

DELIMITER $$
CREATE FUNCTION WhoThat (smtIN int) returns int
BEGIN 
	DECLARE empID int;
    SELECT rs.thatOne into empID from 
	(SELECT pm.ID as ModuleID, pm.prjID as ProjectID, pm.empID as defaultOne,
    wd.empID as thatOne , wd.wdDate as Dates
    from workdone as wd
		join Project_module as pm on pm.ID = wd.mdlID
	where wd.empID <> pm.empID limit 1) as rs;
    RETURN empID;
END $$
DELIMITER ;

select WhoThat (1);

set @empID =0;
    SELECT rs.thatOne into @empID from 
	(SELECT pm.ID as ModuleID, pm.prjID as ProjectID, pm.empID as defaultOne,
    wd.empID as thatOne , wd.wdDate as Dates
    from workdone as wd
		join Project_module as pm on pm.ID = wd.mdlID
	where wd.empID <> pm.empID limit 1) as rs;

select @empID as thatOne;


