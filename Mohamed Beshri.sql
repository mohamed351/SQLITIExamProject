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