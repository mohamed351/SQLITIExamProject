-- ISCorrect not Correct Answer
Alter table [dbo].[Choice]
drop column [CorrectAnswer]
go
Alter table [dbo].[Choice]
add  IsCorrect bit not null
go
Create type ty_Choocies as table
(
 [ChoiceText] nvarchar(max),
 [IsCorrect] bit 
)
go
Create proc sp_Add_Question_Choice
@text nvarchar(max),
@typeOfQuestion nvarchar(20),
@questionScore int,
@tableChoocies ty_Choocies readonly --please see the video of type
as
begin try
begin transaction 
--normal insert
Insert into Question ([Text],TypeOfQuestion,QuestionScore) 
values
(@text,@typeOfQuestion,@questionScore);
-- get the the last identity
declare @Question as int =  IDENT_CURRENT('Question');
insert into Choice (QuestionID,ChoiceText,IsCorrect) select @Question,tbl.ChoiceText,tbl.IsCorrect  from @tableChoocies as tbl
commit transaction
end try
begin catch
 rollback transaction
end catch
GO
-- testing the procedure 
declare @testing_tbl as ty_Choocies
Insert into @testing_tbl (ChoiceText,IsCorrect) values('C#',1),
('PHP',0),('Ruby',0),('Python',0)
execute sp_Add_Question_Choice 'What is the best Langugue Ever','MCQ',5,@testing_tbl
Go 
--this is Procdure Return random Questions Order 
--There is another procdure that make 
Create proc SP_Select_Exam
@ExamID int
as
select  ID, [Text],TypeOfQuestion,QuestionScore from ExamQuestion as ex inner join Question as qu
on ex.QuestionID = qu.ID
where ExamID=@ExamID
order by newID() 
-- exam Model Answer
go
Create proc SP_Select_ExamQuestions
@examID int
as
Select * from Exam as ex
inner join ExamQuestion as ExQ
on ex.ID = ExQ.ExamID inner join Question as quest
on quest.ID = ExQ.QuestionID inner join Choice as cho
on cho.QuestionID = quest.ID
where ex.ID =@examID and cho.IsCorrect =1
go
Create proc [dbo].[sp_Select_Student_ExamReport]
@studentID int 
as
Select student.ID, FName,exm.Name as [Subject], sum(Grade) as Grade from Student as student inner join StudentAnswers as answer
on student.ID  = answer.StudentID inner join Exam as exm
on exm.ID = answer.ExamID
where student.ID =@studentID
group by  student.ID, FName,exm.Name  
GO
CREATE proc [dbo].[sp_Select_Student_Report]
@TrackID int 
as
Select distinct FName,LName ,trk.Name from Student as st 
inner join Track as trk
on st.TrackID =trk.ID
where TrackID=@TrackID
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



