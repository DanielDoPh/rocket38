drop database if exists dbrocket38;
create database dbrocket38;
use dbrocket38;
create table Department (
DepartmentID int auto_increment primary key,
DepartmentName Varchar(77));

create table Position (
PositionID int auto_increment primary key,
PositionName Varchar(77));
alter table position modify column PositionName Varchar(37);

create table Account_ (
AcountID int auto_increment primary key,
Email Varchar(77),
UserName varchar(77),
FullName varchar(77),
DepartmentID int,
PositionID int,
CreateDate date
);