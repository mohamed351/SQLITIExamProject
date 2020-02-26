create proc SP_GetAll_Topic
as
	begin transaction
	begin try
		select * from Topic
	end try
	begin catch
		rollback;
	end catch
	commit;
go

create proc SP_GetById_Topic
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
go

create proc SP_Add_Topic
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
go

create proc SP_Update_Topic
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
go

create proc SP_Delete_Topic
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
go

create proc SP_GetAll_Track
as
	begin transaction
	begin try
		select * from Track
	end try
	begin catch
		rollback;
	end catch
	commit;
go

create proc SP_GetById_Track
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
go

create proc SP_Add_Track
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
go

create proc SP_Update_Track
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
go

create proc SP_Delete_Track
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
go

-- exam generation
create proc SP_Add_Question
@text nvarchar(50),
@typeOfQuestion nvarchar(50),
@questionScore int
as
	begin transaction
	begin try
		insert into Question
		values(@text, @typeOfQuestion, @questionScore)
	end try
	begin catch
		rollback;
	end catch
	commit;
go

create proc SP_Generate_Random_Exam
@examName nvarchar(20),
@duration int,
@fullMark int
as		
	insert into Exam values(@examName, @duration, @fullMark)
	insert into ExamQuestion (QuestionID, ExamID) 
	select top(10)ID from Question
	order by newid()			