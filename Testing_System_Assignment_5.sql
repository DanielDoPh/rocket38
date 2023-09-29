/*
20230929 Fri, mySQL ls5
*/

use dbrocket38;

-- Q4 - pending
DROP VIEW if EXISTS v_dpmtC;
create view v_dpmtC as 
(
select ac.FK_DepartmentID, count(ac.FK_departmentID) as myCount
        from `account` as ac 
       -- where 
        GROUP BY ac.FK_DepartmentID
);
select max(mycount) FROM v_dpmtC;

create view v_mostStaffDpmt as 
select 
from
group by
having 
;
-- test in subquerry
select ac.FK_DepartmentID, count(ac.FK_departmentID) as mycount
        from account as ac 
        GROUP BY ac.FK_DepartmentID;
       
-- Q1
create view v_StaffInSale AS
	SELECT A.*, dp.DepartmentName
    FROM `account` as a
		join department AS dp on a.FK_DepartmentID = dp.DepartmentID
	WHERE dp.departmentName = 'Sale';
    
select * from v_StaffInSale;

-- Q2
create view v_accJoinMostGroup AS 
	SELECT a.AccountID, a.UserName, a.FullName
    FROM groupaccount as ga 
		join account as a on ga.AccountID = a.AccountID
	where a.AccountID IN (
			SELECT accountID FROM ;
    )
    ;
    
-- 

