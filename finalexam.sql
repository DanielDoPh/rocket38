DROP DATABASE IF EXISTS finalExam;

CREATE DATABASE finalExdb;

USE finalExdb;
-- 1
CREATE TABLE IF NOT EXISTS Country (
	ID TINYINT AUTO_INCREMENT PRIMARY KEY,
	`Name` VARCHAR(117)
);

CREATE TABLE IF NOT EXISTS Location (
	ID TINYINT AUTO_INCREMENT PRIMARY KEY,
	streetAddr TEXT,
    postalCode VARCHAR(17),
    countryID TINYINT,
    FOREIGN KEY (countryID) REFERENCES Country (ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Employee (
	ID INT AUTO_INCREMENT PRIMARY KEY,
	fullName TEXT,
    email VARCHAR(77),
    locationID TINYINT,
    FOREIGN KEY (locationID) REFERENCES Location (ID) ON UPDATE CASCADE ON DELETE CASCADE
);

-- insert
INSERT INTO `finalexdb`.`country`
	(`Name`)
VALUES
	('Viet Nam'),('China'),('Korea'),('America');
    
INSERT INTO `finalexdb`.`location`
(`streetAddr`, `postalCode`, `countryID`)
VALUES
('No 1 Nguyen Chi Thanh, Ngoc Khanh Ward, Ba Dinh District, Ha Noi', '1234567890', 1),
('No 2 Nguyen Chi Thanh, Ngoc Khanh Ward, Ba Dinh District, Ha Noi', '1234567892', 1),
('No 3 Nguyen Chi Thanh, Ngoc Khanh Ward, Ba Dinh District, Ha Noi', '1234567893', 2),
('No 4 Nguyen Chi Thanh, Ngoc Khanh Ward, Ba Dinh District, Ha Noi', '1234567894', 2),
('No 5 Nguyen Chi Thanh, Ngoc Khanh Ward, Ba Dinh District, Ha Noi', '1234567895', 3),
('No 6 Nguyen Chi Thanh, Ngoc Khanh Ward, Ba Dinh District, Ha Noi', '1234567896', 3),
('No 7 Nguyen Chi Thanh, Ngoc Khanh Ward, Ba Dinh District, Ha Noi', '1234567897', 4)
;

INSERT INTO `finalexdb`.`employee`
(`fullName`, `email`, `locationID`)
VALUES
('Nguyen Van A','anv@mail.com',1),
('Nguyen Van B','bnv@mail.com',1),
('Nguyen Van C','cnv@mail.com',2),
('Nguyen Van D','dnv@mail.com',3),
('Nguyen Van E','env@mail.com',3),
('Nguyen Van F','fnv@mail.com',4),
('Nguyen Van G','gnv@mail.com',5),
('Nguyen Van H','hnv@mail.com',6),
('Nguyen Van I','inv@mail.com',7)
;
INSERT INTO `finalexdb`.`employee`
(`fullName`, `email`, `locationID`)
VALUES
('Nguyen Van J','nn03@gmail.com',3);

-- 2
-- 2a Lấy tất cả các nhân viên thuộc Việt nam
SELECT em.FullName , cnt.`name`
FROM employee AS em 
	JOIN location AS loc ON em.locationID = loc.ID
    JOIN country AS cnt ON loc.countryID = cnt.ID
WHERE cnt.ID =1;

-- 2b Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"
SELECT em.FullName , cnt.`name`
FROM employee AS em 
	/*LEFT*/ JOIN location AS loc ON em.locationID = loc.ID
    /*RIGHT*/ JOIN country AS cnt ON loc.countryID = cnt.ID
WHERE em.email = 'nn03@gmail.com';

-- 2c Thống kê mỗi country, mỗi location có bao nhiêu employee đang làm việc. (2 ? 1)
-- By location
SELECT loc.ID, COUNT(em.ID), loc.postalCode
FROM employee AS em 
	JOIN location AS loc ON em.locationID = loc.ID
    -- JOIN country AS cnt ON loc.countryID = cnt.ID
GROUP BY loc.ID;

-- By country
SELECT cnt.ID, COUNT(em.ID), cnt.`name`
FROM employee AS em 
	JOIN location AS loc ON em.locationID = loc.ID
    JOIN country AS cnt ON loc.countryID = cnt.ID
GROUP BY cnt.ID;

-- 1 By location and country
SELECT cnt.`name`, loc.streetAddr, COUNT(em.ID) as NumOfEmp
FROM employee AS em 
	JOIN location AS loc ON em.locationID = loc.ID
    JOIN country AS cnt ON loc.countryID = cnt.ID
GROUP BY cnt.ID, loc.ID;

-- 3 Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 10 employee
DROP TRIGGER IF EXISTS tgr_1CountryMax10em;

DELIMITER $$
CREATE TRIGGER tgr_1CountryMax10em 
BEFORE INSERT on `employee`
FOR EACH ROW
BEGIN
	DECLARE countEmInCnt INT DEFAULT 0 ;
	DECLARE cntID INT;
	
    SELECT loc.CountryID INTO cntID
	FROM  location as loc
	WHERE loc.ID = NEW.locationID;
    
    SELECT COUNT(em.ID) INTO countEmInCnt
	FROM employee AS em 
		JOIN location AS loc ON em.locationID = loc.ID
		JOIN country AS cnt ON loc.countryID = cnt.ID
	WHERE cntID  = cnt.ID
	GROUP BY cnt.ID;
    -- select @countEmInCnt
    
	IF countEmInCnt >= 10 THEN 
		SIGNAL SQLSTATE '12345' -- 
        SET MESSAGE_TEXT = 'A country can add just 10 ems';
    END IF;
END $$
DELIMITER ;

-- 10 ing, loc 3 9em, loc 4 1em in China
INSERT INTO `finalexdb`.`employee`
	(`fullName`, `email`, `locationID`)
VALUES
	('Nguyen Van K','knv@mail.com',3),
	('Nguyen Van L','lnv@mail.com',3),
	('Nguyen Van M','mnv@mail.com',3),
	('Nguyen Van N','nnv@mail.com',3),
	('Nguyen Van O','onv@mail.com',3),
	('Nguyen Van P','pnv@mail.com',3)
    ;
    
-- over 10
    
INSERT INTO `finalexdb`.`employee`
	(`fullName`, `email`, `locationID`)
VALUES
	('Nguyen Van Q','qnv@mail.com',4);	

INSERT INTO `finalexdb`.`employee`
	(`fullName`, `email`, `locationID`)
VALUES
	('Nguyen Van R','rnv@mail.com',5),
	('Nguyen Van S','snv@mail.com',6)
	;

-- 4 Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở
-- location đó sẽ có location_id = null
DROP TRIGGER IF EXISTS tgr_delA;

DELIMITER $$
CREATE TRIGGER tgr_1CountryMax10em 
BEFORE INSERT on `employee`
FOR EACH ROW
BEGIN
	DECLARE countEmInCnt INT DEFAULT 0 ;
	DECLARE cntID INT;
	
    SELECT loc.CountryID INTO cntID
	FROM  location as loc
	WHERE loc.ID = NEW.locationID;
    
    SELECT COUNT(em.ID) INTO countEmInCnt
	FROM employee AS em 
		JOIN location AS loc ON em.locationID = loc.ID
		JOIN country AS cnt ON loc.countryID = cnt.ID
	WHERE cntID  = cnt.ID
	GROUP BY cnt.ID;
    -- select @countEmInCnt
    
	IF countEmInCnt >= 10 THEN 
		SIGNAL SQLSTATE '12345' -- 
        SET MESSAGE_TEXT = 'A country can add just 10 ems';
    END IF;
END $$
DELIMITER ;










