USE [master]
GO
/****** Object:  Database [ITIEXAMS]    Script Date: 2/29/2020 5:21:55 PM ******/
CREATE DATABASE [ITIEXAMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ITIEXAMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ITIEXAMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ITIEXAMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ITIEXAMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ITIEXAMS] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ITIEXAMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ITIEXAMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ITIEXAMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ITIEXAMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ITIEXAMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ITIEXAMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [ITIEXAMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ITIEXAMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ITIEXAMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ITIEXAMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ITIEXAMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ITIEXAMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ITIEXAMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ITIEXAMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ITIEXAMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ITIEXAMS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ITIEXAMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ITIEXAMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ITIEXAMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ITIEXAMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ITIEXAMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ITIEXAMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ITIEXAMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ITIEXAMS] SET RECOVERY FULL 
GO
ALTER DATABASE [ITIEXAMS] SET  MULTI_USER 
GO
ALTER DATABASE [ITIEXAMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ITIEXAMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ITIEXAMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ITIEXAMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ITIEXAMS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ITIEXAMS', N'ON'
GO
ALTER DATABASE [ITIEXAMS] SET QUERY_STORE = OFF
GO
USE [ITIEXAMS]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [ITIEXAMS]
GO
/****** Object:  UserDefinedTableType [dbo].[TY_Choices]    Script Date: 2/29/2020 5:21:56 PM ******/
CREATE TYPE [dbo].[TY_Choices] AS TABLE(
	[ChoiceText] [nvarchar](max) NULL,
	[IsCorrect] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TY_Question_Answer]    Script Date: 2/29/2020 5:21:56 PM ******/
CREATE TYPE [dbo].[TY_Question_Answer] AS TABLE(
	[QuestionID] [int] NULL,
	[AnswerID] [int] NULL,
	[QuestionText] [nvarchar](max) NULL
)
GO
/****** Object:  Table [dbo].[ChociesOfAnswers]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChociesOfAnswers](
	[ChoiceTitle] [nvarchar](max) NULL,
	[ExamID] [int] NULL,
	[StudentID] [int] NULL,
	[Iscorrect] [bit] NULL,
	[ID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Choice]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Choice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChoiceText] [nvarchar](max) NOT NULL,
	[QuestionID] [int] NULL,
	[IsCorrect] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Course]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[TopicID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Exam]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Duration] [int] NULL,
	[FullMark] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExamQuestion]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamQuestion](
	[ExamID] [int] NOT NULL,
	[QuestionID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC,
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Username] [nvarchar](30) NULL,
	[Password] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InstructorCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorCourse](
	[CourseID] [int] NOT NULL,
	[InstructorID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Question]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[TypeOfQuestion] [nvarchar](20) NOT NULL,
	[QuestionScore] [int] NOT NULL,
	[SubjectID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FName] [nvarchar](200) NOT NULL,
	[LName] [nvarchar](200) NOT NULL,
	[Username] [nvarchar](30) NULL,
	[Password] [nvarchar](30) NULL,
	[TrackID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentAnswers]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAnswers](
	[ExamID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[Grade] [int] NOT NULL,
	[AnswerNumber] [int] NOT NULL,
	[AnswerText] [nvarchar](max) NOT NULL,
	[IsCorrect] [bit] NOT NULL,
	[ID] [int] NOT NULL,
 CONSTRAINT [PK_StudentAnswers_1] PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC,
	[StudentID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentCourse](
	[StudentID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC,
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Subject]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Topic]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Track]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ChociesOfAnswers]  WITH CHECK ADD  CONSTRAINT [FK_ChociesOfAnswers_StudentAnswers] FOREIGN KEY([ExamID], [StudentID], [ID])
REFERENCES [dbo].[StudentAnswers] ([ExamID], [StudentID], [ID])
GO
ALTER TABLE [dbo].[ChociesOfAnswers] CHECK CONSTRAINT [FK_ChociesOfAnswers_StudentAnswers]
GO
ALTER TABLE [dbo].[Choice]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([ID])
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD FOREIGN KEY([TopicID])
REFERENCES [dbo].[Topic] ([ID])
GO
ALTER TABLE [dbo].[ExamQuestion]  WITH CHECK ADD FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ID])
GO
ALTER TABLE [dbo].[ExamQuestion]  WITH CHECK ADD FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([ID])
GO
ALTER TABLE [dbo].[InstructorCourse]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[InstructorCourse]  WITH CHECK ADD FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [fk_subject_Question] FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([ID])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [fk_subject_Question]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([TrackID])
REFERENCES [dbo].[Track] ([ID])
GO
ALTER TABLE [dbo].[StudentAnswers]  WITH CHECK ADD  CONSTRAINT [FK__StudentAn__ExamI__300424B4] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ID])
GO
ALTER TABLE [dbo].[StudentAnswers] CHECK CONSTRAINT [FK__StudentAn__ExamI__300424B4]
GO
ALTER TABLE [dbo].[StudentAnswers]  WITH CHECK ADD  CONSTRAINT [FK__StudentAn__Stude__31EC6D26] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[StudentAnswers] CHECK CONSTRAINT [FK__StudentAn__Stude__31EC6D26]
GO
ALTER TABLE [dbo].[StudentCourse]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[StudentCourse]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Course]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 create proc [dbo].[SP_Add_Course]
 @name varchar(50),
 @topicId int
 as
 insert into Course([Name],[TopicID])
 values(@name,@topicId)
 

GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Exam]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Exam
create proc [dbo].[SP_Add_Exam]
@name nvarchar(30),
@duration int ,
@fullmark int 



As
begin transaction
begin try 
insert into Exam(Name,Duration,FullMark)
values(@name,@duration,@fullmark)
end try
begin catch
RollBack
end catch
commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Instructor]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--instructor + Course
create proc [dbo].[SP_Add_Instructor]
 @name varchar(50),
 @password varchar(50),
 @username varchar(50)
 as
 insert into Instructor([Name],Username,[Password])
 values(@name,@username,@password)
  

GO
/****** Object:  StoredProcedure [dbo].[SP_Add_InstructorCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[SP_Add_InstructorCourse](@CourseId int , @InstructorId int)
 as
Begin Transaction
Begin Try
INSERT INTO InstructorCourse VALUES (@CourseId , @InstructorId)
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Question]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- exam generation
create proc [dbo].[SP_Add_Question]
@text nvarchar(50),
@typeOfQuestion nvarchar(50),
@questionScore int,
@SubjectID int 
as
	begin transaction
	begin try
		insert into Question
		values(@text, @typeOfQuestion, @questionScore,@SubjectID)
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Question_Choice]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Used to Add Question With their choices
Create proc [dbo].[SP_Add_Question_Choice]
@text nvarchar(max),
@typeOfQuestion nvarchar(20),
@questionScore int,
@tableChoocies TY_Choices readonly 
as
begin try
begin transaction 
Insert into Question ([Text],TypeOfQuestion,QuestionScore) 
values
(@text,@typeOfQuestion,@questionScore);
declare @Question as int =  IDENT_CURRENT('Question');
insert into Choice (QuestionID,ChoiceText,IsCorrect) select @Question,tbl.ChoiceText,tbl.IsCorrect  from @tableChoocies as tbl
commit transaction
end try
begin catch
 rollback transaction
end catch

GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Student]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[SP_Add_Student]
@fname nvarchar(200),
@lname nvarchar(200),
@username nvarchar(30),
@password nvarchar(30),
@trackID int
As
Begin Transaction
Begin Try
    Insert Into Student (FName,LName,Username,Password,TrackID) 
    Values(@fname,@lname,@username,@password,@trackID)
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Add_StudentCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Add_StudentCourse]
@StudentID int,
@CourseID int
AS
Begin Transaction
Begin Try
Insert into StudentCourse(StudentID,CourseID) values (@StudentID,@CourseID)
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Subject]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Subjects


--Subject StoredProcedure

create proc [dbo].[SP_Add_Subject] 
@Name nvarchar(max)
As
begin transaction
begin try 
insert into Subject
values(@Name)
end try
begin catch
RollBack
end catch
commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Topic]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Add_Topic]
@name nvarchar(50)
as
	begin transaction
	begin try
		insert into Topic
		values (@name)
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_Add_Track]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Add_Track]
@name nvarchar(50)
as
	begin transaction
	begin try
		insert into Track
		values (@name)
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Subject]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[SP_Delete_Subject] 
@Subid int
As
begin transaction
begin try 
delete from Subject
where @Subid = ID
end try
begin catch
RollBack
end catch
commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Topic]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Delete_Topic]
@id int
as
	begin transaction
	begin try
		delete from Topic
		where id = @id
	end try
	begin catch
		rollback;
	end catch
		commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_Delete_Track]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Delete_Track]
@id int
as
	begin transaction
	begin try
		delete from Track
		where id = @id
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteByCourseID_StudentCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_DeleteByCourseID_StudentCourse]
@StudentID int,
@CourseID int
As
Begin Transaction
Begin Try
Delete from StudentCourse where CourseID = @CourseID AND StudentID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteById_Course]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create proc [dbo].[SP_DeleteById_Course]
  @id int 
  as
  delete from Course
  where ID=@id
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteById_Instructor]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create proc [dbo].[SP_DeleteById_Instructor]
  @id int
  as
  delete from Instructor
  where ID=@id


GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteByID_instructorCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[sp_DeleteByID_instructorCourse](@CourseId int)
  as
  Begin Transaction
Begin Try
  delete from instructorCourse where CourseID = @CourseId
  End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteByID_Student]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_DeleteByID_Student]
@StudentID int
As
Begin Transaction
Begin Try
Delete from Student where ID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteByStudentID_StudentCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_DeleteByStudentID_StudentCourse]
@StudentID int
As
Begin Transaction
Begin Try
Delete from StudentCourse where StudentID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_ExamCorrection]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exam Answers & Correction
CREATE proc [dbo].[SP_ExamCorrection]
@ExamID int , 
@StudentID int,
@tbl_AnswerIt TY_Question_Answer readonly
as
begin try
begin transaction
Insert into StudentAnswers (ID,ExamID,StudentID,AnswerNumber,AnswerText,IsCorrect,Grade)
Select tbl.QuestionID,@ExamID,@StudentID,tbl.AnswerID as ChoiceID ,tbl.QuestionText , (Case when ch.ID= tbl.AnswerID then 1 else 0 end) as ISCorrect , (Case when ch.ID= tbl.AnswerID then QuestionScore else 0 end) as Grade    from  @tbl_AnswerIt as tbl inner join Question as quest
on tbl.QuestionID = quest.ID inner join Choice as ch
on ch.QuestionID = quest.ID where ch.IsCorrect=1
 
Insert into  ChociesOfAnswers(ID,ExamID,StudentID,ChoiceTitle,Iscorrect)
Select  tbl.QuestionID, @ExamID,@StudentID , cho.ChoiceText, IsCorrect from @tbl_AnswerIt as tbl inner join Question as qu
inner join Choice as cho
on cho.QuestionID = qu.ID
on tbl.QuestionID = qu.ID 
commit transaction
end try
begin catch
rollback transaction
end catch

GO
/****** Object:  StoredProcedure [dbo].[SP_Generate_Exam]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Generate_Exam]
@exam_name nvarchar(20),
@duration int,
@fullmark int,
@mcq_count int,
@tf_count int,
@subject_id int
as
	begin try
		begin transaction
			insert into Exam values(@exam_name, @duration, @fullmark)
			declare @exam_id int = IDENT_CURRENT('Exam')			
			insert into ExamQuestion
			select @exam_id, ID from
			(select * from (
				select top(@mcq_count)@exam_id as exam_id, * from Question
				where TypeOfQuestion = 'mcq' and SubjectID = @subject_id
				order by newid()
			) as mcq
			union
			select * from (
				select top(@tf_count)@exam_id as exam_id, * from Question
				where TypeOfQuestion = 't/f' and SubjectID = @subject_id
				order by newid()
			) as tf) as a
		commit;
	end try
	begin catch
		rollback;
	end catch
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAll_Course]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[SP_GetAll_Course]
 as
 select * from Course
 

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAll_Exam]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_GetAll_Exam]
AS
begin Transaction
begin try
Select *from Exam
end try 
begin catch
rollback
end catch
commit


GO
/****** Object:  StoredProcedure [dbo].[SP_GetAll_Instructor]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
  create proc [dbo].[SP_GetAll_Instructor]
  as
  select *from Instructor
  

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAll_instructorCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create proc [dbo].[SP_GetAll_instructorCourse] 
  as
  Begin Transaction
Begin Try
  select * from instructorCourse 
  End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_GetAll_Student]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_GetAll_Student]
As
Begin Transaction
Begin Try
Select * from Student 
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_GetAll_StudentCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_GetAll_StudentCourse]
As
Begin Transaction
Begin Try
Select * from StudentCourse
End try
Begin Catch
RollBack
End Catch
Commit

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAll_Topic]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_GetAll_Topic]
as
	begin transaction
	begin try
		select * from Topic
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAll_Track]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_GetAll_Track]
as
	begin transaction
	begin try
		select * from Track
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllSubject_Subject]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_GetAllSubject_Subject] 
As
begin transaction
begin try 
select * from Subject
end try
begin catch
RollBack
end catch
commit


GO
/****** Object:  StoredProcedure [dbo].[SP_GetByCourseID_StudentCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_GetByCourseID_StudentCourse]
@CourseID int
As
Begin Transaction
Begin Try
Select * from StudentCourse where CourseID= @CourseID
End try
Begin Catch
RollBack
End Catch
Commit

GO
/****** Object:  StoredProcedure [dbo].[SP_GetById_Course]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[SP_GetById_Course]
  @id int 
  as
  select *from Course
  where ID=@id


GO
/****** Object:  StoredProcedure [dbo].[SP_GetById_Exam]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create Proc [dbo].[SP_GetById_Exam]
@ExamID int
AS
begin Transaction 
begin try
Select * from Exam where ID=@ExamID
end try
begin catch
rollback
end catch
commit

GO
/****** Object:  StoredProcedure [dbo].[SP_GetById_Instructor]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create proc [dbo].[SP_GetById_Instructor]
  @id int 
  as
  select *from Instructor
  where ID=@id


GO
/****** Object:  StoredProcedure [dbo].[SP_GetByID_instructorcourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[SP_GetByID_instructorcourse] (@id int)
  as
  Begin Transaction
Begin Try
  select * from instructor ins join instructorCourse INC 
  on ins.ID = INC.instructorID 
  where INC.instructorID = @id
  End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_GetByID_Student]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_GetByID_Student]
@StudentID int
As
Begin Transaction
Begin Try
Select * from Student where ID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_GetById_Subject]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_GetById_Subject] 
@Subid int
As
begin transaction
begin try 
select * from Subject
where @Subid = ID
end try
begin catch
RollBack
end catch
commit


GO
/****** Object:  StoredProcedure [dbo].[SP_GetById_Topic]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_GetById_Topic]
@id int
as
	begin transaction
	begin try
		select * from Topic
		where id = @id
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_GetById_Track]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_GetById_Track]
@id int
as
	begin transaction
	begin try
		select * from Track
		where id = @id
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetByIDCourseData_instructorCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- OPTIONAL sp To GetCourse name using joins from instructor_Course
create proc [dbo].[sp_GetByIDCourseData_instructorCourse]
@Courseid int
as
Begin Transaction 
Begin Try
 select * from Course c join InstructorCourse inc 
 on c.ID = inc.CourseID
 where inc.CourseID = @CourseId
 End try
Begin Catch
RollBack
End Catch
Commit
--amany
GO
/****** Object:  StoredProcedure [dbo].[SP_GetByStudentID_StudentCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SP_GetByStudentID_StudentCourse]
@StudentID int
As
Begin Transaction
Begin Try
Select * from StudentCourse where StudentID= @StudentID
End try
Begin Catch
RollBack
End Catch
Commit

GO
/****** Object:  StoredProcedure [dbo].[SP_Login_Instructor]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create proc [dbo].[SP_Login_Instructor]
   @password varchar(50),
   @username varchar(50)
 as
 select * from Instructor
 where [Username]=@username and [Password]=@password
 

GO
/****** Object:  StoredProcedure [dbo].[SP_Login_Student]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[SP_Login_Student]
@Username nvarchar(30),
@Password nvarchar(30)
As
Begin Transaction
Begin Try
Select * from Student where username = @Username AND password = @Password
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Select_ExamQuestions]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Show Correct Answer -- Model Answer
Create proc [dbo].[SP_Select_ExamQuestions]
@examID int
as
Select * from Exam as ex
inner join ExamQuestion as ExQ
on ex.ID = ExQ.ExamID inner join Question as quest
on quest.ID = ExQ.QuestionID inner join Choice as cho
on cho.QuestionID = quest.ID
where ex.ID =@examID and cho.IsCorrect =1

GO
/****** Object:  StoredProcedure [dbo].[SP_Select_InsructorReport]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--report Insructors
CREATE proc [dbo].[SP_Select_InsructorReport]
@InstructorID int 
as
Select ins.Name as InsructorName  ,ISNULL(course.Name,'No Course Teach') as CourseName , count(studentcourse.StudentID) as ANumberOfStudent from Instructor as ins 
left join InstructorCourse as cou
on ins.ID = cou.InstructorID left join Course as course
on course.ID = cou.CourseID left join StudentCourse  as studentcourse
on studentcourse.CourseID = course.ID 
where ins.ID = @InstructorID
group by ins.Name ,course.ID ,course.Name

GO
/****** Object:  StoredProcedure [dbo].[SP_Select_Student_ExamReport]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Show Just Grade without percennt
Create proc [dbo].[SP_Select_Student_ExamReport]
@studentID int 
as
Select student.ID, FName,exm.Name as [Subject], sum(Grade) as Grade from Student as student inner join StudentAnswers as answer
on student.ID  = answer.StudentID inner join Exam as exm
on exm.ID = answer.ExamID
where student.ID =@studentID
group by  student.ID, FName,exm.Name  

GO
/****** Object:  StoredProcedure [dbo].[SP_Select_Student_Report]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- stored for Reports
-- Get Students In Track Report
CREATE proc [dbo].[SP_Select_Student_Report]
@TrackID int 
as
Select distinct FName,LName ,trk.Name from Student as st 
inner join Track as trk
on st.TrackID =trk.ID
where TrackID=@TrackID

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Course]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create proc [dbo].[SP_Update_Course]
 @id int,
 @name varchar(50),
 @topicId int
 as
 update Course
 set [Name]=@name ,[TopicID]=@topicId
 where [ID]=@id
 

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Instructor]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 create proc [dbo].[SP_Update_Instructor]
 @id int,
 @name varchar(50),
 @password varchar(50),
 @username varchar(50)
 as
 update Instructor
 set [Name]=@name,Username=@username,[Password]=@password
 where ID=@id
 

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_instructorCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  create proc [dbo].[SP_Update_instructorCourse](@CourseId int ,@InstructorId int )
  as
   Begin Transaction
   Begin Try
  update InstructorCourse 
  Set InstructorID = @InstructorId
  where CourseID = @CourseId
  End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Student]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[SP_Update_Student]
@StudentID int,
@fname nvarchar(200),
@lname nvarchar(200),
@username nvarchar(30),
@password nvarchar(30),
@trackID int
As
Begin Transaction
Begin Try
Update Student 
Set FName = @fname, Lname = @lname, Username =@username, Password = @password, TrackID = @TrackID
Where  ID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Subject]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Update_Subject] 
@Subname nvarchar(max),
@Subid int
As
begin transaction
begin try 
update Subject
set Name = @Subname
where @Subid = ID
end try
begin catch
RollBack
end catch
commit


GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Topic]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Update_Topic]
@name nvarchar(50),
@id int
as
	begin transaction
	begin try
		update Topic
		set [name] = @name
		where id = @id
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_Update_Track]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_Update_Track]
@id int,
@name nvarchar(50)
as
	begin transaction
	begin try
		update Track
		set [name] = @name
		where id = @id
	end try
	begin catch
		rollback;
	end catch
	commit;

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCourseID_StudentCourse]    Script Date: 2/29/2020 5:21:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_UpdateCourseID_StudentCourse]
@StudentID int,
@OldCourseID int,
@NewCourseID int
AS
Begin Transaction
Begin Try
update StudentCourse set CourseID =@NewCourseID where  StudentID = @StudentID AND CourseID = @OldCourseID
End try
Begin Catch
RollBack
End Catch
Commit


GO
USE [master]
GO
ALTER DATABASE [ITIEXAMS] SET  READ_WRITE 
GO
