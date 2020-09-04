-- Subject(SubjCode, Description)
-- PRIMARY KEY (SubjCode)

-- Student(StudentID, Surname, GivenName, Gender)
-- PRIMARY KEY(StudentID)

-- Teacher(StaffID, Surname, GivenName)
-- PRIMARY KEY(StaffID)

-- SubjectOffering(SubjCode, StaffID, Year, Semester, Fee, )
-- PRIMARY KEY (SubjCode, StaffID, Year, Semester)
-- FOREIGN KEY (SubjCode) REFERENCES Subject
-- FOREIGN KEY (StaffID) REFERENCES Teacher

-- Enrolment(StudentID, Year, Semester, StaffID, SubjCode, DateEnrolled, Grade)
-- PRIMARY KEY(StudentID, Year, Semester, StaffID, SubjCode)
-- FOREIGN KEY (StudentID) REFERENCES Student
-- FOREIGN KEY (Year, Semester, StaffID, SubjCode) REFERENCES Student

USE Build_Query_Challange;

IF OBJECT_ID('Enrolment') IS NOT NULL DROP TABLE Enrolment;
IF OBJECT_ID('SubjectOffering') IS NOT NULL DROP TABLE SubjectOffering;
IF OBJECT_ID('Subject') IS NOT NULL DROP TABLE Subject;
IF OBJECT_ID('Student') IS NOT NULL DROP TABLE Student;
IF OBJECT_ID('Teacher') IS NOT NULL DROP TABLE Teacher;

CREATE TABLE Subject
(
  SubjCode NVARCHAR(100),
  Description NVARCHAR(500),
  PRIMARY KEY(SubjCode)
);

CREATE TABLE Student
(
  StudentId NVARCHAR(10),
  Surname NVARCHAR(10) NOT NULL,
  GivenName NVARCHAR(100) NOT NULL,
  Gender NVARCHAR(1) CHECK(Gender IN('M', 'F', 'I')),
  PRIMARY KEY(StudentId)
);

CREATE TABLE Teacher
(
  StaffID INT CHECK(LEN(StaffID) = 8),
  Surname NVARCHAR(100) NOT NULL,
  GivenName NVARCHAR(100) NOT NULL,
  PRIMARY KEY(StaffID),
);

CREATE TABLE SubjectOffering
(
  SubjCode NVARCHAR(100),
  Year INT CHECK(LEN(Year) = 4),
  Semester INT CHECK(Semester IN (1,2)),
  Fee MONEY NOT NULL CHECK(Fee > 0),
  StaffID INT CHECK(LEN(StaffID) = 8),
  PRIMARY KEY(SubjCode,Year,Semester),
  FOREIGN KEY(StaffID) REFERENCES Teacher,
  FOREIGN KEY(SubjCode) REFERENCES [Subject]
);

CREATE TABLE Enrolment
(
  StudentId NVARCHAR(10),
  SubjCode NVARCHAR(100),
  Year INT CHECK(LEN(Year) = 4),
  Semester INT CHECK(Semester IN (1,2)),
  Grade NVARCHAR(2) CHECK(Grade IN('N', 'P', 'C','D','HD')),
  DateEnrolled date,
  PRIMARY KEY(StudentId,SubjCode,Year,Semester),
  FOREIGN KEY(StudentId) REFERENCES Student,
  FOREIGN KEY(SubjCode,Year,Semester) REFERENCES SubjectOffering
);

INSERT INTO Student
  (StudentId, Surname, GivenName, Gender)
VALUES
  ('s12233445', 'Baird', 'Tim', 'M'),
  ('s23344556', 'Nguyen', 'Anh', 'M'),
  ('s34455667', 'Hallinan', 'JamesM', 'M'),
  ('s34455668', 'Banfield', 'Samual', 'M');

INSERT INTO Teacher
  (StaffID, Surname, GivenName)
VALUES
  (98776655, 'Young', 'Angus'),
  (87665544, 'Scott', 'Bon'),
  (76554433, 'Slade', 'Chris');

INSERT INTO Subject
  (SubjCode, Description)
VALUES
  ('ICTPRG418', 'ApplySQLtoextract&manipulatedata'),
  ('ICTBSB430', 'CreateBasicDatabases'),
  ('ICTDBS205', 'DesignaDatabase');

INSERT INTO SubjectOffering
  (SubjCode, Year, Semester, Fee, StaffID)
VALUES
  ('ICTPRG418', 2019, 1, 200, 98776655),
  ('ICTPRG418', 2020, 1, 225, 98776655),
  ('ICTBSB430', 2020, 1, 200, 87665544),
  ('ICTBSB430', 2020, 2, 200, 76554433),
  ('ICTDBS205', 2019, 2, 225, 87665544);

INSERT INTO Enrolment
  (StudentId, SubjCode, Year, Semester, Grade, DateEnrolled)
VALUES
  ('s12233445', 'ICTPRG418', 2019, 1, 'D', '2019-2-25'),
  ('s23344556', 'ICTPRG418', 2019, 1, 'P', '2019-2-15'),
  ('s12233445', 'ICTPRG418', 2020, 1, 'C', '2020-1-30'),
  ('s23344556', 'ICTPRG418', 2020, 1, 'HD', '2-26-2020'),
  ('s34455667', 'ICTPRG418', 2020, 1, 'P', '2020-1-28'),
  ('s12233445', 'ICTBSB430', 2020, 1, 'C', '2020-2-8'),
  ('s23344556', 'ICTBSB430', 2020, 2, NULL, '2020-6-30'),
  ('s34455667', 'ICTBSB430', 2020, 2, NULL, '2020-7-3'),
  ('s23344556', 'ICTDBS205', 2019, 2, 'P', '2019-7-1'),
  ('s34455667', 'ICTDBS205', 2019, 2, 'N', '2019-7-13');



SELECT Stu.GivenName, Stu.Surname, E.SubjCode, Sub.Description,
  Offer.Year, Offer.Semester, Offer.Fee, T.GivenName, T.Surname
FROM Enrolment E
  LEFT JOIN Student Stu ON Stu.StudentId = E.StudentId
  LEFT JOIN Subject Sub ON Sub.SubjCode = E.SubjCode
  LEFT JOIN SubjectOffering Offer ON Offer.SubjCode = E.SubjCode AND Offer.Year = E.Year AND Offer.Semester = E.Semester
  LEFT JOIN Teacher T ON T.StaffID = Offer.StaffID

SELECT [year], semester, COUNT(*)
FROM Enrolment
GROUP BY [year], semester
ORDER BY [year], semester;

SELECT *
FROM Enrolment E
  INNER JOIN SubjectOffering O ON O.SubjCode = E.SubjCode AND O.Year = E.Year AND O.Semester = E.Semester
WHERE(Fee = (
SELECT MAX(Fee)
FROM SubjectOffering)
)



IF OBJECT_ID('Task1') IS NOT NULL DROP VIEW Task1;
GO
CREATE VIEW Task1
AS
  SELECT Stu.GivenName AS StuGivenName, Stu.Surname AS StuSurName, E.SubjCode, Sub.Description, Offer.Year, Offer.Semester, Offer.Fee, T.GivenName, T.Surname
  FROM Enrolment E
    LEFT JOIN Student Stu ON Stu.StudentId = E.StudentId
    LEFT JOIN Subject Sub ON Sub.SubjCode = E.SubjCode
    LEFT JOIN SubjectOffering Offer ON Offer.SubjCode = E.SubjCode AND Offer.Year = E.Year AND Offer.Semester = E.Semester
    LEFT JOIN Teacher T ON T.StaffID = Offer.StaffID