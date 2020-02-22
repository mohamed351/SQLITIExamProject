create database ITIEXAMS
go
use ITIEXAMS
go
create table Track(
	ID int identity(1,1) primary key,
	[Name] nvarchar(200) not null
)
go
create table Student(
	ID int identity(1,1) primary key,
	[FName] nvarchar(200) not null,
	[LName] nvarchar(200) not null,
	Username nvarchar(30) unique,
	[Password] nvarchar(30),
	TrackID int references Track(ID)
)
go
create table Topic(
	ID int identity(1,1) primary key,
	[Name] nvarchar(30) not null

)
go
create table Course(
	ID int identity(1,1) primary key,
	[Name] nvarchar(40) not null,
	TopicID int references Topic(ID) 
)
go
create table Instructor(
	ID int identity(1,1) primary key,
	[Name] nvarchar(200) not null,
	Username nvarchar(30) unique,
	[Password] nvarchar(30)
)
go
create table InstructorCourse(
	CourseID int references Course(ID),
	InstructorID int references Instructor(ID),
	primary key(CourseID, InstructorID)
)
go
create table StudentCourse(
	StudentID int references Student(ID),
	CourseID int references Course(ID)
	primary key(StudentID, CourseID)
)
go
create table Exam(
	ID int identity(1,1) primary key,
	[Name] nvarchar(30) not null,
	Duration int,
	FullMark int
)
go 
create table Question(
	ID int identity(1,1) primary key,
	Text nvarchar(max) not null,
	TypeOfQuestion nvarchar(20) not null,
	QuestionScore int not null
)
-- we can a rule on the typeofquestion column to make it check whether 
-- a entered is in a predefined range or not
go
create table ExamQuestion(
	ExamID int references Exam(ID),
	QuestionID int references Question(ID),
	primary key(ExamID, QuestionID)
)
go
create table Choice(
	ID int identity(1,1) primary key,
	CorrectAnswer nvarchar(max) not null,
	ChoiceText nvarchar(max) not null,
	QuestionID int references Question(ID)
)
go
create table StudentAnswers(
	ExamID int references Exam(ID),
	QuestionID int references Question(ID),
	StudentID int references Student(ID),
	Grade int not null,
	AnswerNumber int not null,
	AnswerText nvarchar(max) not null,
	IsCorrect bit not null
	primary key(ExamID, QuestionID, StudentID)
)