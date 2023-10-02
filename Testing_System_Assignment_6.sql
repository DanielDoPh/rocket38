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

-- Q6 create a Store: IN inString, OUT GroupName or UserName contain the inString
-- Store create at ...
-- from Diep Tran and need to create Function find_in_set ? or just LOCATE is enough? :D


DELIMITER $$
create procedure getACCOUNT_GROUP_CHUOI(in chuoi varchar(37), out fname varchar(37) , out out_groupname varchar(37))
begin 
select ac.FullName into fname  from `account` as ac where find_in_set(chuoi, ac.FullName) >0 limit 1;
select groupname into out_groupname  from `group` where find_in_set(chuoi, groupname) >0 limit 1 ;
end$$
DELIMITER ;

set @fname ='';
set @out_groupname ='';
call getACCOUNT_GROUP_CHUOI('N', @fname,@out_groupname);
select @fname,@out_groupname;

--

set @outs = '';
call getGrNameOrUsrNameByInput('Độ', @outs);
select @outs;