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
