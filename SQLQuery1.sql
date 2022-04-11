CREATE DATABASE P203University

USE P203University

CREATE TABLE Groups
(
	Id INT,
	No NVARCHAR(10),
	StudentLimit TINYINT
)

CREATE TABLE Students
(
	Id INT,
	FullName NVARCHAR(30),
	BirthDate DATETIME2,
	GroupNo NVARCHAR(10),
	Gender BIT
)

DROP TABLE Groups

CREATE TABLE Groups
(
	Id INT PRIMARY KEY,
	No NVARCHAR(10) NOT NULL,
	StudentLimit INT CHECK(StudentLimit>=0)
)

CREATE TABLE Groups
(
	Id INT PRIMARY KEY,
	No NVARCHAR(10) NOT NULL,
	StudentLimit INT CONSTRAINT GRP_SL_CHECK CHECK(StudentLimit>=0)
)

ALTER TABLE Groups
DROP CONSTRAINT GRP_SL_CHECK

ALTER TABLE Groups
ADD CONSTRAINT GRP_SL_CHECK CHECK(StudentLimit>=0)

DROP TABLE Students

CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY ,
	FullName NVARCHAR(30) NOT NULL,
	Email NVARCHAR(100) CONSTRAINT STD_EMAIL_UNQ UNIQUE,
	BirthDate DATETIME2,
	GENDER BIT 
)

ALTER TABLE Students
ALTER COLUMN FullName NVARCHAR(25)


ALTER TABLE Students
ALTER COLUMN FullName NVARCHAR(25) NOT NULL

ALTER TABLE Students
ADD AvgPoint INT CONSTRAINT STD_AVGP_CHECK CHECK(AvgPoint>=0)

ALTER TABLE Students
DROP CONSTRAINT STD_AVGP_CHECK
ALTER TABLE Students
DROP COLUMN AvgPoint

ALTER TABLE Students
ADD GroupId INT CONSTRAINT FK_Students_GroupId FOREIGN KEY (GroupId) REFERENCES Groups(Id)



INSERT INTO Groups (No,StudentLimit)
VALUES
('BP202',12)

INSERT INTO Groups (No,StudentLimit)
VALUES
('BP204',12),
('BP201',18),
('BP203',20)


SELECT * FROM Groups WHERE StudentLimit<12

UPDATE Groups
SET StudentLimit=12
WHERE StudentLimit<12

INSERT INTO Groups 
VALUES
('AP205',10),
('AP206',1),
('AP207',4)

SELECT * FROM Groups WHERE StudentLimit>=0 AND StudentLimit<10
SELECT * FROM Groups WHERE StudentLimit BETWEEN 0 AND 9


DELETE FROM Groups
WHERE StudentLimit BETWEEN 0 AND 9

SELECT * FROM Groups WHERE No != 'AP203'

SELECT * FROM Groups WHERE No LIKE '%A%'

SELECT * FROM Groups WHERE No LIKE 'B%'

SELECT * FROM Groups WHERE No LIKE '%3'

SELECT * FROM Groups WHERE StudentLimit=10 OR StudentLimit=18 OR StudentLimit=20
SELECT * FROM Groups WHERE StudentLimit IN (10,20)

CREATE TABLE Teachers
(
	Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(10) NOT NULL CONSTRAINT TCH_NM_CHECK CHECK(LEN(Name)>2),
	Surname NVARCHAR(10) NOT NULL CONSTRAINT  TCH_SNM_CHECK CHECK(LEN(Surname)>2),
	Salary DECIMAL(18,2)
)

INSERT INTO Teachers
VALUES
('Akif','Abbaszade',400),
('Hikmet','Abbasov',4500),
('Nermin','Abbaszade',2500)

SELECT * FROM Teachers
SELECT Id,Name,Surname FROM Teachers

SELECT Id, Name+ ' '+Surname AS 'FullName',LEN(Name+' '+Surname) AS 'FullNameLen' FROM Teachers

SELECT * FROM Groups 

SELECT * FROM Students

SELECT COUNT(Id) FROM Students WHERE GroupId=1

SELECT 
G.Id,
G.No,
G.StudentLimit,
(SELECT COUNT(Id) FROM Students  WHERE GroupId=G.Id) AS 'StudentCount' 
FROM Groups AS G