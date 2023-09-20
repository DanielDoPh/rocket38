drop database if exists dbrocket38;
create database dbrocket38;
use dbrocket38;
create table Department (
DepartmentID int auto_increment primary key,
DepartmentName Varchar(77));

create table Position (
PositionID int auto_increment primary key,
PositionName Varchar(37)
);

create table Account (
	AcountID int auto_increment primary key,
	Email Varchar(77),
	UserName varchar(77),
	FullName varchar(77),
	FK_DepartmentID int,
	FK_PositionID int,
	CreateDate date,
	foreign key (FK_DepartmentID) references Department (DepartmentID),
	foreign key (FK_PositionID) references Position (PositionID)
	);

create table Trainee(
	TraineeID int auto_increment primary key,
    Full_Name varchar(77) not null,
    Birth_Date date not null,
    Gender enum ('Male','Female','Other'),
    ET_IQ int,
    ET_Gmath int,
    ET_English int,
    Training_Class varchar(17),
    Evalution_Notes text,
    constraint check (ET_IQ > 0 & ET_IQ < 20),
    check (ET_Gmath > 0 & ET_Gmath < 20),
    check (ET_English > 0 & ET_English < 50)
);

alter table Trainee
add column VTI_Account varchar(77) unique not null;

