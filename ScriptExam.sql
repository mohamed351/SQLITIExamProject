Create Database [ITIEXAMS]
GO
USE [ITIEXAMS]
GO
/****** Object:  UserDefinedTableType [dbo].[QuestionInfo]    Script Date: 2/25/2020 8:16:15 AM ******/
CREATE TYPE [dbo].[QuestionInfo] AS TABLE(
	[QuestionID] [int] NULL,
	[ChoiceID] [int] NULL,
	[ISCorrect] [bit] NULL,
	[QuestionSore] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ty_Answer_Question]    Script Date: 2/25/2020 8:16:15 AM ******/
CREATE TYPE [dbo].[ty_Answer_Question] AS TABLE(
	[QuestionID] [int] NULL,
	[AnswerID] [int] NULL,
	[QuestionText] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ty_Choocies]    Script Date: 2/25/2020 8:16:15 AM ******/
CREATE TYPE [dbo].[ty_Choocies] AS TABLE(
	[ChoiceText] [nvarchar](max) NULL,
	[IsCorrect] [bit] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[sp_Add_Question_Choice]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Select_Exam]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Select_ExamQuestions]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SP_StudentAnswer]    Script Date: 2/25/2020 8:16:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_StudentAnswer]
@ExamID int , 
@StudentID int,
@tbl_AnswerIt ty_Answer_Question readonly
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
/****** Object:  UserDefinedFunction [dbo].[TableChoociestoXml]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[ChociesOfAnswers]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Choice]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Exam]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[ExamQuestion]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Instructor]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[InstructorCourse]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Question]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Student]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[StudentAnswers]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[StudentCourse]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Subject]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Topic]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  Table [dbo].[Track]    Script Date: 2/25/2020 8:16:15 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[ConvertXmlToTableChoocies]    Script Date: 2/25/2020 8:16:15 AM ******/
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
