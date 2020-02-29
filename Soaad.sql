--instructor + Course
create proc SP_Add_Instructor
 @name varchar(50),
 @password varchar(50),
 @username varchar(50)
 as
 insert into Instructor([Name],Username,[Password])
 values(@name,@username,@password)
  
 go 
 
 create proc SP_Update_Instructor
 @id int,
 @name varchar(50),
 @password varchar(50),
 @username varchar(50)
 as
 update Instructor
 set [Name]=@name,Username=@username,[Password]=@password
 where ID=@id
 
 go 
 
  create proc SP_GetAll_Instructor
  as
  select *from Instructor
  
go

  create proc SP_GetById_Instructor
  @id int 
  as
  select *from Instructor
  where ID=@id

go

  create proc SP_DeleteById_Instructor
  @id int
  as
  delete from Instructor
  where ID=@id

go 
  create proc SP_Login_Instructor
   @password varchar(50),
   @username varchar(50)
 as
 select * from Instructor
 where [Username]=@username and [Password]=@password
 
go
 
 create proc SP_Add_Course
 @name varchar(50),
 @topicId int
 as
 insert into Course([Name],[TopicID])
 values(@name,@topicId)
 
go

 create proc SP_Update_Course
 @id int,
 @name varchar(50),
 @topicId int
 as
 update Course
 set [Name]=@name ,[TopicID]=@topicId
 where [ID]=@id
 
go

 create proc SP_GetAll_Course
 as
 select * from Course
 
go

 create proc SP_GetById_Course
  @id int 
  as
  select *from Course
  where ID=@id

go

  create proc SP_DeleteById_Course
  @id int 
  as
  delete from Course
  where ID=@id