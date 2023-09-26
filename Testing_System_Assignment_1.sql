DROP DATABASE IF EXISTS dbrocket38;
CREATE DATABASE dbrocket38;
USE dbrocket38;
CREATE TABLE Department (
DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
DepartmentName VARCHAR(77));

CREATE TABLE Position (
PositionID INT AUTO_INCREMENT PRIMARY KEY,
PositionName VARCHAR(37)
);

CREATE TABLE Account (
	AcountID INT AUTO_INCREMENT PRIMARY KEY,
	Email VARCHAR(77),
	UserName VARCHAR(77),
	FullName VARCHAR(77),
	FK_DepartmentID INT,
	FK_PositionID INT,
	CreateDate DATE,
	FOREIGN KEY (FK_DepartmentID) REFERENCES Department (DepartmentID),
	FOREIGN KEY (FK_PositionID) REFERENCES Position (PositionID)
	);
    
    ALTER TABLE account
    RENAME COLUMN acountID to AccountID;

CREATE TABLE Trainee(
	TraineeID INT AUTO_INCREMENT PRIMARY KEY,
    Full_Name VARCHAR(77) NOT NULL,
    Birth_Date DATE NOT NULL,
    Gender ENUM ('Male','Female','Other'),
    ET_IQ INT,
    ET_Gmath INT,
    ET_English INT,
    Training_Class VARCHAR(17),
    Evalution_Notes TEXT,
    CONSTRAINT CHECK (ET_IQ > 0 & ET_IQ < 20),
    CHECK (ET_Gmath > 0 & ET_Gmath < 20),
    CHECK (ET_English > 0 & ET_English < 50)
);

ALTER TABLE Trainee
ADD COLUMN VTI_Account VARCHAR(77) UNIQUE NOT NULL;

use dbrocket38;
INSERT into department VALUE (1,'Marketing');
INSERT into department VALUE (2,'Sale');
INSERT into department VALUE (3,'Inventory');
INSERT into department VALUE (4,'CustomerCare');
INSERT into department VALUE (5,'TechSupport');
insert into Department (DepartmentName) values ('Finance'),('Transportation');
SELECT DepartmentName AS dn from department
	WHERE department.DepartmentID BETWEEN 2 and 4;

  /*
  2023 09 22 Fri, Lesson 2 Database (mySQL)
  */  
ALTER TABLE Position 
MODIFY COLUMN PositionName ENUM ('Dev','Test','Scrum Master', 'PM');

-- tbl 4 Group
CREATE TABLE `Group` (
	groupID INT AUTO_INCREMENT PRIMARY KEY,
    groupName VARCHAR(77),
	creatorID INT,
    createDate DATETIME,
    FOREIGN KEY (creatorID) REFERENCES Account(AccountID)
);
ALTER TABLE `Group` 
MODIFY COLUMN createDate DATE;

-- tbl 5 GroupAccount
CREATE TABLE GroupAccount (
	groupID INT PRIMARY KEY,
	accountID INT,
    joinDate DATETIME,
    FOREIGN KEY (accountID) REFERENCES Account(AccountID)
);
ALTER TABLE GroupAccount
MODIFY COLUMN joinDate DATE;

-- tbl 6 TypeQuestion
CREATE TABLE TypeQuestion (
	typeID INT AUTO_INCREMENT PRIMARY KEY,
	typeName ENUM ('Essay','Multiple-Choice')
);

-- tbl 7 CategoryQuestion
CREATE TABLE CategoryQuestion (
	categoryID INT AUTO_INCREMENT PRIMARY KEY,
	categoryName VARCHAR(37)
);

-- tbl 8 Question
CREATE TABLE Question (
	questionID INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT,
    categoryID INT,
    typeID int,
	creatorID INT,
    createDate DATETIME,
    FOREIGN KEY (categoryID) REFERENCES CategoryQuestion(categoryID),
    FOREIGN KEY (typeID) REFERENCES TypeQuestion(typeID),
    FOREIGN KEY (creatorID) REFERENCES Account(AccountID)
);
ALTER TABLE Question
MODIFY COLUMN createDate DATE;

-- tbl 9 Answer
CREATE TABLE Answer (
	answerID INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT,
    questionID INT,
    isCorrect BOOLEAN,
    FOREIGN KEY (questionID) REFERENCES Question(questionID)
);

-- tbl 10 Exam
CREATE TABLE Exam (
	examID INT AUTO_INCREMENT PRIMARY KEY,
    `code` VARCHAR(17),
    title TEXT,
    categoryID INT,
    duration INT,
	creatorID INT,
    createDate DATETIME,
    FOREIGN KEY (categoryID) REFERENCES CategoryQuestion(categoryID),
    FOREIGN KEY (creatorID) REFERENCES Account(AccountID)
);
ALTER TABLE Exam
MODIFY COLUMN createDate DATE;

-- tbl 11 ExamQuestion
CREATE TABLE ExamQuestion (
	examID INT PRIMARY KEY,
    questionID INT,
	FOREIGN KEY (questionID) REFERENCES Question(questionID)
);

-- Insert
insert into `position` (PositionName)
	VALUES 
		('Dev'), 
		('Test'), 
        ('Scrum Master'), 
        ('PM');

select * from `position`;

insert into Account 
(Email,
UserName,
FullName,
FK_DepartmentID,
`FK_PositionID`,
`CreateDate`
)
	VALUES 
	('dopv@amail.com','dopv','Phùng Văn Độ',1,1,'2023-09-22'), 
	('dopv2@amail.com','dopv2','Phùng Văn Độ2',2,3,'2023-09-22'), 
	('dopv3@amail.com','dopv3','Phùng Văn Độ3',3,2,'2023-09-22'), 
	('dopv4@amail.com','dopv4','Phùng Văn Độ4',4,1,'2023-09-22'),
	('dopv5@amail.com','dopv5','Phùng Văn Độ5',5,4,'2023-09-22')
    ;
select * from `account`;
        
-- Them bang 4 5 6, moi bang 5 ban ghi
INSERT INTO `Group` 
	(groupName, creatorID, createDate)
VALUES
	('Nhóm 6',1, now()),
    ('Nhóm 7',2, now()+2)
    ;
select * from `group`;
-- 5
INSERT INTO GroupAccount 
	(groupID, accountID, joinDate)
VALUES
	(1, 1, current_date()),
    (2, 2, current_date()+2),
    (3, 3, current_date()-3),
    (4, 4, current_date()+4),
    (5, 5, current_date()-5)
    ;
select * from GroupAccount;
-- 6
INSERT INTO TypeQuestion 
	(typeName)
VALUES
	(1),
    (2),
    (1),
    (2),
    (2)
    ;
select * from TypeQuestion;

-- 7
use dbrocket38;
insert into CategoryQuestion
(categoryName)
VALUES 
	('Java'), 
    ('.NET'),
    ('SQL'),
    ('Postman'),
    ('Ruby'),
	('Python'),
    ('MySQL');

-- 8
insert into Question
(content, categoryID, typeID, creatorID, createDate)
VALUES 
	('What is this?',1,2,1,curdate()-7), 
    ('What is that?',2,3,2,curdate()-6), 
    ('What are these?',3,4,3,curdate()-5), 
    ('What are those?',4,5,4,curdate()-1), 
    ('Which ball is not expensive?',5,1,1,curdate()-7),
	('What does the dog eat?',5,4,5,curdate()-2),
    ('What kind of dog does we have?',6,3,4,curdate()-3);
/*
2023 09 25 Mon lesson 3 mySQL
*/
-- Q2 Lay ra tat ca cac phong ban
use dbrocket38;

select * from Department;

-- Q3 get ID of 'Sale' department
select departmentID from Department WHERE DepartmentName = 'Sale';

-- Q6 Name of group join in before ... 25/09/2023, then after
SELECT * from `group`;
insert into `group` (groupName, creatorID, createDate)
values 
	('Golden', 4, curdate() + 3),
	('Alaska', 4, curdate() + 4),
    ('Husky', 4, curdate() -7),
    ('Pug', 4, curdate() + 2);
    
select groupName from `group`
	WHERE createDate > '2023-09-25';

-- SELECT column_name(s) FROM tbl_name WHERE column_name LIKE 'D%o';
-- SELECT DISTINCT column_name FROM <...>;
/* 
SELECT 
column_name(s) 
FROM  tbl1 JOIN tbl2 ON tbl1.field = tbl2.field;
can JOIN 1 or multi tables.
*/

select * from account where accountID = 4;
update account set fullname = 'Nguyễn Văn Bốn' where accountID=4;
update account set createdate = '2003-10-04' where username = 'dopv3';


/*GROUP BY : Thống kê dữ liệu theo nhóm, có thể GROUP BY nhiều cột.,
kết hợp function tính toán count, sum, max, min, avg
(vd tính độ tuổi trung bình theo phòng ban: 
select Dpmt_Name, avg(age) join department vs account as ac  on (id = id ...) 
group by ac.departmentName
HAVING (thêm điều kiện) ví dụ trung bình trên 23 tuổi
*/

ALTER table account add column birthday Date;
ALTER table account add column Age int;
update account set FullName = 'Nguyễn Bá Lộc',username='locnb1' where accountid =5;
update account set age = 2023-date_format(birthday,'%Y');

-- Tính tuổi các nhân viên
select username, fullname, age from account;

-- Lấy 2 nhân trẻ tuổi nhất 
select username, fullname, age from `account`
order BY age asc limit 2;
-- Tính độ tuổi trung binh nhân viên theo phòng ban, theo chuc vu
select /*dp.DepartmentName,*/ ps.PositionName, avg(age) 
from `account` as ac join department as dp on ac.FK_DepartmentID = dp.DepartmentID 
join position as ps on ac.FK_PositionID = ps.PositionID
GROUP BY /*dp.departmentName,*/ ps.positionName;

-- Count staff group by department
select dp.departmentName, count(ac.FK_DepartmentID) as QuantityOfStaff
from account as ac join department as dp on ac.FK_DepartmentID = dp.DepartmentID
group by dp.departmentName;

-- Get the longest name 
select *, char_length(fullname) as cl from account
order by char_length(fullname) desc
limit 1;