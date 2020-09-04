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

IF OBJECT_ID('Subject') IS NOT NULL DROP TABLE Subject;
IF OBJECT_ID('Student') IS NOT NULL DROP TABLE Student;
IF OBJECT_ID('Teacher') IS NOT NULL DROP TABLE Teacher;
IF OBJECT_ID('SubjectOffering') IS NOT NULL DROP TABLE SubjectOffering;
IF OBJECT_ID('Enrolment') IS NOT NULL DROP TABLE Enrolment;

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
  StaffID INT,
  PRIMARY KEY(SubjCode,Year,Semester),
  FOREIGN KEY(StaffID) REFERENCES Teacher,
  FOREIGN KEY(SubjCode) REFERENCES Subject
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