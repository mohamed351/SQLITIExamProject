 create proc SP_Add_InstructorCourse(@CourseId int , @InstructorId int)
 as
Begin Transaction
Begin Try
INSERT INTO InstructorCourse VALUES (@CourseId , @InstructorId)
End try
Begin Catch
RollBack
End Catch
Commit

go

  create proc SP_Update_instructorCourse(@CourseId int ,@InstructorId int )
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

go
  create proc SP_GetAll_instructorCourse 
  as
  Begin Transaction
Begin Try
  select * from instructorCourse 
  End try
Begin Catch
RollBack
End Catch
Commit

go

 create proc SP_GetByID_instructorcourse (@id int)
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

go

 create proc sp_DeleteByID_instructorCourse(@CourseId int)
  as
  Begin Transaction
Begin Try
  delete from instructorCourse where CourseID = @CourseId
  End try
Begin Catch
RollBack
End Catch
Commit

go
-- Subjects


--Subject StoredProcedure

create proc SP_Add_Subject 
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

go

create proc SP_GetAllSubject_Subject 
As
begin transaction
begin try 
select * from Subject
end try
begin catch
RollBack
end catch
commit

go

create proc SP_GetById_Subject 
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

go

create proc SP_Update_Subject 
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

go


create proc SP_Delete_Subject 
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

go
-- OPTIONAL sp To GetCourse name using joins from instructor_Course
create proc sp_GetByIDCourseData_instructorCourse
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