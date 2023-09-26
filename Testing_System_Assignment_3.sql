drop database if exists dbr38asm3;
create database if not EXISTS dbr38asm3;

use dbr38asm3;
drop table departments;
create table if not EXISTS departments(
	dpmtID INT AUTO_INCREMENT PRIMARY KEY,
    dpmtName VARCHAR(37) NOT NULL,
    dpmtDescription TEXT,
    createAt DATETIME NOT NULL,
    updateAt DATETIME DEFAULT CURRENT_TIMESTAMP
	);
    alter table departments 
	MODIFY COLUMN updateAt DATETIME DEFAULT CURRENT_TIMESTAMP;
    alter table departments
    -- MODIFY dpmtName VARCHAR(37) NOT NULL;
    MODIFY createAt DATETIME NOT NULL;
create table if not EXISTS users(
	usrID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(37),
    lastName VARCHAR(37),
    email VARCHAR(97),
    phone VARCHAR(20),
    employeeID VARCHAR(10), -- -
    avatar TEXT,
    dpmtID INT,
    gender TINYINT,
    age INT, -- NG in real, need Bday field
    createAt DATETIME,
    updateAt DATETIME,
    FOREIGN KEY (dpmtID) REFERENCES departments (dpmtID)
	);
	alter table users 
	MODIFY COLUMN updateAt DATETIME DEFAULT CURRENT_TIMESTAMP;
    
create table user_department(
	usr_dpmtID int PRIMARY KEY AUTO_INCREMENT,
    usrID INT,
    dpmtID INT,
    startDate DATE,
    endDate DATE,
    createAt DATETIME,
    updateAt DATETIME,
    FOREIGN KEY (dpmtID) REFERENCES departments (dpmtID),
    FOREIGN KEY (usrID) REFERENCES users (usrID)
);
    alter table user_department 
	MODIFY COLUMN updateAt DATETIME DEFAULT CURRENT_TIMESTAMP;

create table roles(
	roleID INT PRIMARY KEY AUTO_INCREMENT,
    roleName VARCHAR(37),
    createAt DATETIME,
    updateAt DATETIME
);
	alter table roles 
	MODIFY COLUMN updateAt DATETIME DEFAULT CURRENT_TIMESTAMP;
create table user_role(
	usr_roleID INT PRIMARY KEY AUTO_INCREMENT,
    usr_dpmtID INT,
    roleID INT,
    startDate DATE,
    endDate DATE,
    createAt DATETIME,
    updateAt DATETIME,
    FOREIGN KEY (roleID) REFERENCES roles (roleID),
    FOREIGN KEY (usr_dpmtID) REFERENCES user_department (usr_dpmtID)
);
    alter table user_role 
	MODIFY COLUMN updateAt DATETIME DEFAULT CURRENT_TIMESTAMP;

create table salary(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    usr_roleID INT,
    totalSalary DOUBLE(12,2),
    `month` VARCHAR(2),
    `year` VARCHAR(4),
    createAt DATETIME,
    updateAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usr_roleID) REFERENCES user_role (usr_roleID)
);
create table salaryDetailType (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(10),
    createAt DATETIME,
    updateAt DATETIME
);
    alter table salarydetailtype 
	MODIFY COLUMN updateAt DATETIME DEFAULT CURRENT_TIMESTAMP;
create table salaryDetail(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    amount DOUBLE(12,2),
    salaryID INT,
    salaryDetailTypeID INT,
    operation TINYINT
);
	alter table salarydetail
    add FOREIGN KEY (salaryDetailTypeID) REFERENCES salaryDetailType (ID);

-- Insert
insert into departments (dpmtName, dpmtDescription, createAt)
VALUES 
	('Admin', 'Adminnistrative','2023-01-01'),
    ('HR', 'Human & Resources','2023-01-01'),
    ('IT', 'Information Technology','2023-01-01'),
    ('Delivery', 'Delivery','2023-01-01')
    ;
select * from departments;

insert into roles (roleName, createAt)
values
	('Director','2023-01-10'),
    ('Manager','2023-01-12'),
    ('Deputy Manager','2023-01-12'),
    ('Staff','2023-01-15'),
    ('Collaborator','2023-03-01')
    ;
select * from roles;

insert into salarydetailtype (name,createAt)
VALUEs
	('Basic wage','2023-01-01'),
    ('Allowance','2023-01-01'),
    ('Reward','2023-01-01'),
    ('Income Tax','2023-01-01'),
    ('Insurance','2023-01-01')
    ;
    select * from salarydetailtype;
    
-- Tạo 15 user Trong đó
-- 5 user thuộc 2 phòng ban khác nhau? 
-- 3 user có 2 role khác nhau trong 1 phòng? 
-- INSERT INTO user?

