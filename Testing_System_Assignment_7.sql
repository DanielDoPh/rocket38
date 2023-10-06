use dbrocket38;

-- 1
DROP TRIGGER IF EXISTS tgr_group_createDate;
 
DELIMITER $$
CREATE TRIGGER tgr_group_createDate 
BEFORE INSERT on `group`
FOR EACH ROW
BEGIN
	IF datediff( curdate(), NEW.`createDate`) > 365 THEN 
		SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'Field createDate can not less than 1 year from now';
    END IF;
END $$
DELIMITER ;

-- 2
DROP TRIGGER IF EXISTS tgr_SaleDpmt;

DELIMITER $$
CREATE TRIGGER tgr_SaleDpmt 
BEFORE INSERT on `account`
FOR EACH ROW
BEGIN
	IF NEW.`FK_DepartmentID` = 2 THEN 
		SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'Department Sale can not add more user';
    END IF;
END $$
DELIMITER ;


INSERT INTO `account` 
(
`Email`,
`UserName`,
`FullName`,
`FK_PositionID`,
`CreateDate`,
`birthday`,
`Age`)
VALUES
('tungpd1923@gmail.com', 'tungpd2', 'Phan Dinh Tung', 2,
curdate(),'1923-08-07', 100);

-- 3
DROP TRIGGER IF EXISTS tgr_groupUserMax5;

DELIMITER $$
CREATE TRIGGER tgr_groupUserMax5 
BEFORE INSERT on `groupaccount`
FOR EACH ROW
BEGIN
    DECLARE grcount int DEFAULT 0;
    SELECT COUNT(accountID) INTO grcount 
    FROM `groupaccount` 
    where groupID = NEW.`groupID`
    GROUP BY groupID;
	IF grcount >= 5 THEN 
		SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'A group can not have more than 5 users';
    END IF;
END $$
DELIMITER ;

INSERT INTO `dbrocket38`.`groupaccount`
(`groupID`, `accountID`, `joinDate`)
VALUES
(1, 6, '2314-4-5');

-- 6
INSERT INTO `dbrocket38`.`department`
(`DepartmentName`)
VALUES
	('waiting Department');

DROP TRIGGER IF EXISTS tgr_Account_emptyDpmtID;

DELIMITER $$
CREATE TRIGGER tgr_Account_emptyDpmtID 
BEFORE INSERT on `account`
FOR EACH ROW
BEGIN
	IF  NEW.`FK_DepartmentID` IS NULL OR NEW.`FK_DepartmentID`='' THEN 
		SET NEW.`FK_DepartmentID`= 8;
    END IF;
END $$
DELIMITER ;








