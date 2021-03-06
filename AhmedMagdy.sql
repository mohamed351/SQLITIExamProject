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
go

create proc SP_Generate_Exam
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