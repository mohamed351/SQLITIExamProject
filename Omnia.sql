--Exam
create proc SP_Add_Exam
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

go

Create proc SP_GetAll_Exam
AS
begin Transaction
begin try
Select *from Exam
end try 
begin catch
rollback
end catch
commit

go


Create Proc SP_GetById_Exam
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
go