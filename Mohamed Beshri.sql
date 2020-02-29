-- ISCorrect not Correct Answer
--Types 
-- used this type in Stored Procdure SP_Add_Question_Choice
Create type TY_Choices as table
(
 [ChoiceText] nvarchar(max),
 [IsCorrect] bit 
)
GO
--used this type in Stored Procdure SP_ExamCorrection
CREATE TYPE [dbo].[TY_Question_Answer] AS TABLE(
	[QuestionID] [int] NULL,
	[AnswerID] [int] NULL,
	[QuestionText] [nvarchar](max) NULL
)
-- end types
GO
--Used to Add Question With their choices
Create proc SP_Add_Question_Choice
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
-- Show Correct Answer -- Model Answer
Create proc SP_Select_ExamQuestions
@examID int
as
Select * from Exam as ex
inner join ExamQuestion as ExQ
on ex.ID = ExQ.ExamID inner join Question as quest
on quest.ID = ExQ.QuestionID inner join Choice as cho
on cho.QuestionID = quest.ID
where ex.ID =@examID and cho.IsCorrect =1
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
Create proc [dbo].[sp_Select_Student_ExamReport2]
@studentID int 
as
Select student.ID, FName,exm.Name as [Subject],exm.FullMark , sum(Grade) as Grade from Student as student inner join StudentAnswers as answer
on student.ID  = answer.StudentID inner join Exam as exm
on exm.ID = answer.ExamID
where student.ID =@studentID
group by  student.ID, FName,exm.Name ,exm.FullMark
GO
-------------------------- Report
Create proc SP_ExamQuestion_Report
@ExamID int
AS
Select ex.Name,q.[Text] , ch.ChoiceText, IsCorrect from Exam  as ex
inner join ExamQuestion as question
on ex.ID = question.ExamID
inner join Question as q
on q.ID = question.QuestionID
inner join Choice as ch
on ch.QuestionID = q.ID
where ex.ID =1






