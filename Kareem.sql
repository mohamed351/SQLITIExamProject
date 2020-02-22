Create Proc SP_Add_Student
@fname nvarchar(200),
@lname nvarchar(200),
@username nvarchar(30),
@password nvarchar(30),
@trackID int
As
Begin Transaction
Begin Try
    Insert Into Student (FName,LName,Username,Password,TrackID) 
    Values(@fname,@lname,@username,@password,@trackID)
End try
Begin Catch
RollBack
End Catch
Commit
go

Create Proc SP_Update_Student
@StudentID int,
@fname nvarchar(200),
@lname nvarchar(200),
@username nvarchar(30),
@password nvarchar(30),
@trackID int
As
Begin Transaction
Begin Try
Update Student 
Set FName = @fname, Lname = @lname, Username =@username, Password = @password, TrackID = @TrackID
Where  ID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit
go
Create proc SP_GetAll_Student
As
Begin Transaction
Begin Try
Select * from Student 
End try
Begin Catch
RollBack
End Catch
Commit
go
Create proc SP_GetByID_Student
@StudentID int
As
Begin Transaction
Begin Try
Select * from Student where ID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit
go
Create proc SP_DeleteByID_Student
@StudentID int
As
Begin Transaction
Begin Try
Delete from Student where ID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit
go
Create proc SP_Login_Student
@Username nvarchar(30),
@Password nvarchar(30)
As
Begin Transaction
Begin Try
Select * from Student where username = @Username AND password = @Password
End try
Begin Catch
RollBack
End Catch
Commit
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
create proc SP_Add_StudentCourse
@StudentID int,
@CourseID int
AS
Begin Transaction
Begin Try
Insert into StudentCourse(StudentID,CourseID) values (@StudentID,@CourseID)
End try
Begin Catch
RollBack
End Catch
Commit

go

create proc SP_UpdateCourseID_StudentCourse
@StudentID int,
@OldCourseID int,
@NewCourseID int
AS
Begin Transaction
Begin Try
update StudentCourse set CourseID =@NewCourseID where  StudentID = @StudentID AND CourseID = @OldCourseID
End try
Begin Catch
RollBack
End Catch
Commit

go

Create proc SP_GetAll_StudentCourse
As
Begin Transaction
Begin Try
Select * from StudentCourse
End try
Begin Catch
RollBack
End Catch
Commit
go
Create proc SP_GetByStudentID_StudentCourse
@StudentID int
As
Begin Transaction
Begin Try
Select * from StudentCourse where StudentID= @StudentID
End try
Begin Catch
RollBack
End Catch
Commit
go

Create proc SP_GetByCourseID_StudentCourse
@CourseID int
As
Begin Transaction
Begin Try
Select * from StudentCourse where CourseID= @CourseID
End try
Begin Catch
RollBack
End Catch
Commit
go

Create proc SP_DeleteByStudentID_Student
@StudentID int
As
Begin Transaction
Begin Try
Delete from StudentCourse where StudentID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit
go

Create proc SP_DeleteByCourseID_Student
@StudentID int,
@CourseID int
As
Begin Transaction
Begin Try
Delete from StudentCourse where CourseID = @CourseID AND StudentID = @StudentID
End try
Begin Catch
RollBack
End Catch
Commit
go

