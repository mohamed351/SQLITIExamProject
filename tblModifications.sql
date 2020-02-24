Create table [Subject]
(
ID int primary key identity(1,1),
Name nvarchar(max)
)
go
Alter table Question
add SubjectID int 
go  --Select Question 
Alter table Question
add constraint fk_subject_Question foreign key (SubjectID) references [Subject](ID)
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