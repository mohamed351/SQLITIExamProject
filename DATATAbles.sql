--Insert Data in tables

--insert Data in topic Table
SP_Add_Topic 'Programing'
SP_Add_Topic 'Data Base'
SP_Add_Topic 'Networking'

go

--insert Data in Track Table
SP_Add_Track 'OS'
SP_Add_Track 'SD'
SP_Add_Track 'Mobile'
SP_Add_Track 'Elearning'

go
--insert Data in exam Question table

--insert Data in student table
insert into Student VALUES ('Ahmed','Magdy','AH','123456',1)
insert into Student VALUES ('kareem','shreef','KS','123456',1)
insert into Student VALUES ('Mohamed','Beshr','MB','123456',2)
insert into Student VALUES ('Omnia','Ahmed','OA','123456',2)
insert into Student VALUES ('Soad','Mohamed','SM','123456',3)
insert into Student VALUES ('Amany','Badr','AB','123456',4)

go
--insert Data in Exam
 SP_Add_Exam 'Exam1',1,10
 SP_Add_Exam 'Exam2',1,10
 SP_Add_Exam 'Exam3',1,10
 SP_Add_Exam 'Exam4',1,10
 SP_Add_Exam 'Exam5',1,10
 go
 --insert Data in Instractor
 SP_Add_Instructor 'Ahmed','AH',123456
 SP_Add_Instructor 'Mohamed','MO',123456
 SP_Add_Instructor 'Kareem','KA',123456
go
 --insert Data in Course
 SP_Add_Course 'C#',1
 SP_Add_Course 'JAVA'1
 SP_Add_Course 'SQL',2
 SP_Add_Course 'ERD',2
 SP_Add_Course 'CCNA',3
 SP_Add_Course 'CCNP',3
 go
 --insert Data in Subject
 SP_Add_Subject  'C#'
SP_Add_Subject  'Java'
SP_Add_Subject  'SQL'
SP_Add_Subject  'ERD'
SP_Add_Subject  'CCNA'
SP_Add_Subject  'CCNP'
go