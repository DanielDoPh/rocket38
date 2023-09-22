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

SELECT DepartmentName AS dn from department
	WHERE department.DepartmentID BETWEEN 2 and 4;

  /*
  2023 09 22, Lesson 2 Database (mySQL)
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

-- tbl 5 GroupAccount
CREATE TABLE GroupAccount (
	groupID INT PRIMARY KEY,
	accountID INT,
    joinDate DATETIME,
    FOREIGN KEY (accountID) REFERENCES Account(AccountID)
);

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

-- tbl 11 ExamQuestion
CREATE TABLE ExamQuestion (
	examID INT PRIMARY KEY,
    questionID INT,
	FOREIGN KEY (questionID) REFERENCES Question(questionID)
);
