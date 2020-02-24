USE [master]
GO
/****** Object:  Database [ITIEXAMS]    Script Date: 2/24/2020 10:31:15 AM ******/
CREATE DATABASE [ITIEXAMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ITIEXAMS', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ITIEXAMS.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ITIEXAMS_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ITIEXAMS_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ITIEXAMS] SET COMPATIBILITY_LEVEL = 110
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
ALTER DATABASE [ITIEXAMS] SET AUTO_CREATE_STATISTICS ON 
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
ALTER DATABASE [ITIEXAMS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ITIEXAMS]
GO
/****** Object:  UserDefinedTableType [dbo].[ty_Choocies]    Script Date: 2/24/2020 10:31:15 AM ******/
CREATE TYPE [dbo].[ty_Choocies] AS TABLE(
	[ChoiceText] [nvarchar](max) NULL,
	[IsCorrect] [bit] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[sp_Add_Question_Choice]    Script Date: 2/24/2020 10:31:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Add_Question_Choice]
@text nvarchar(max),
@typeOfQuestion nvarchar(20),
@questionScore int,
@SubjectID int,
@tableChoocies ty_Choocies readonly --please see the video of type
as
begin try
begin transaction 
--normal insert
Insert into Question ([Text],TypeOfQuestion,QuestionScore,SubjectID) 
values
(@text,@typeOfQuestion,@questionScore,@SubjectID);
-- get the the last identity
declare @Question as int =  IDENT_CURRENT('Question');
insert into Choice (QuestionID,ChoiceText,IsCorrect) select @Question,tbl.ChoiceText,tbl.IsCorrect  from @tableChoocies as tbl
commit transaction
end try
begin catch
 rollback transaction
end catch
GO
/****** Object:  StoredProcedure [dbo].[SP_Select_Exam]    Script Date: 2/24/2020 10:31:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SP_Select_Exam]
@ExamID int
as
select  ID, [Text],TypeOfQuestion,QuestionScore from ExamQuestion as ex inner join Question as qu
on ex.QuestionID = qu.ID
where ExamID=@ExamID
order by newID() 

GO
/****** Object:  StoredProcedure [dbo].[SP_Select_ExamQuestions]    Script Date: 2/24/2020 10:31:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_Select_ExamQuestions]
@examID int
as
Select * from Exam as ex
inner join ExamQuestion as ExQ
on ex.ID = ExQ.ExamID inner join Question as quest
on quest.ID = ExQ.QuestionID inner join Choice as cho
on cho.QuestionID = quest.ID
where ex.ID =@examID and cho.IsCorrect =1
GO
/****** Object:  UserDefinedFunction [dbo].[TableChoociestoXml]    Script Date: 2/24/2020 10:31:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[TableChoociestoXml](@QuestionID int)
returns xml
as 
begin 
declare @x as xml=(
select * from Choice where QuestionID =1 for xml auto
)
return @x
end 

GO
/****** Object:  Table [dbo].[Choice]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[Exam]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[ExamQuestion]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[Instructor]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[InstructorCourse]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[Question]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[Student]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[StudentAnswers]    Script Date: 2/24/2020 10:31:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAnswers](
	[ExamID] [int] NOT NULL,
	[QuestionID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[Grade] [int] NOT NULL,
	[AnswerNumber] [int] NOT NULL,
	[AnswerText] [nvarchar](max) NOT NULL,
	[IsCorrect] [bit] NOT NULL,
	[Chocies] [xml] NOT NULL,
 CONSTRAINT [PK__StudentA__819BE275F5ACE0A0] PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC,
	[QuestionID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentCourse]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[Subject]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[Topic]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  Table [dbo].[Track]    Script Date: 2/24/2020 10:31:15 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[ConvertXmlToTableChoocies]    Script Date: 2/24/2020 10:31:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[ConvertXmlToTableChoocies](@XmlValue xml)
returns table
return(
 select tabl.Col.value('@ID','int') as ID , tabl.Col.value('@ChoiceText','nvarchar(max)') as  ChoiceText , 
 tabl.Col.value('@QuestionID','int') as QuestionID , tabl.Col.value('@IsCorrect','bit') as IsCorrect
  from @xmlValue.nodes('//Choice') tabl(Col)
)

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
ALTER TABLE [dbo].[StudentAnswers]  WITH CHECK ADD  CONSTRAINT [FK__StudentAn__Quest__30F848ED] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([ID])
GO
ALTER TABLE [dbo].[StudentAnswers] CHECK CONSTRAINT [FK__StudentAn__Quest__30F848ED]
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
USE [master]
GO
ALTER DATABASE [ITIEXAMS] SET  READ_WRITE 
GO
