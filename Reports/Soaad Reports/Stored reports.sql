

Create proc EXAMS.SP_GetGrade_Student
@ID int
as
SELECT        EXAMS.Student.FName ,EXAMS.Student.LName, EXAMS.StudentAnswers.Grade
FROM            EXAMS.Exam INNER JOIN
                         EXAMS.Student ON EXAMS.Exam.ID = EXAMS.Student.ID INNER JOIN
                         EXAMS.StudentAnswers ON EXAMS.Exam.ID = EXAMS.StudentAnswers.ExamID AND EXAMS.Student.ID = EXAMS.StudentAnswers.StudentID INNER JOIN
                         EXAMS.StudentCourse ON EXAMS.Student.ID = EXAMS.StudentCourse.StudentID
                        where  EXAMS.Student.ID= @ID

go

create proc EXAMS.SP_QuestionById 
@EXAMSID int
as
	SELECT EXAMS.ExamQuestion.QuestionID, EXAMS.Question.[Text],
	 EXAMS.Question.TypeOfQuestion, EXAMS.Question.QuestionScore
    FROM    EXAMS.Exam INNER JOIN
    EXAMS.ExamQuestion ON EXAMS.Exam.ID = EXAMS.ExamQuestion.ExamID INNER JOIN
    EXAMS.Question ON EXAMS.ExamQuestion.QuestionID = EXAMS.Question.ID
	where EXAMS.Exam.ID= @EXAMSID

go

create proc EXAMS.SP_TopicsByCouresID
@CouresID int
as
	SELECT        EXAMS.Topic.ID, EXAMS.Topic.Name, EXAMS.Course.ID 
FROM            EXAMS.Course INNER JOIN
                         EXAMS.Topic ON EXAMS.Course.TopicID = EXAMS.Topic.ID
                       where EXAMS.Course.ID=@CouresID

go

create proc EXAMS.SP_NameOfCourseNumberOfStudentByInstructorID
@InstructorID int
as
SELECT        EXAMS.Course.Name, EXAMS.Course.ID, count(EXAMS.Student.ID )
FROM            EXAMS.Course INNER JOIN
                         EXAMS.Instructor ON EXAMS.Course.ID = EXAMS.Instructor.ID INNER JOIN
                         EXAMS.InstructorCourse ON EXAMS.Course.ID = EXAMS.InstructorCourse.CourseID AND EXAMS.Instructor.ID = EXAMS.InstructorCourse.InstructorID INNER JOIN
                         EXAMS.Student ON EXAMS.Course.ID = EXAMS.Student.ID INNER JOIN
                         EXAMS.StudentCourse ON EXAMS.Course.ID = EXAMS.StudentCourse.CourseID AND EXAMS.Student.ID = EXAMS.StudentCourse.StudentID
						 where EXAMS.Instructor.ID=@InstructorID
						 /**************************Error*******************/
go

create proc EXAMS.QuestionAnswer
@EXAMSID int,
@studentID int
as
 SELECT        EXAMS.Question.Text, EXAMS.StudentAnswers.AnswerText
FROM            EXAMS.Exam INNER JOIN
     EXAMS.ExamQuestion ON EXAMS.Exam.ID = EXAMS.ExamQuestion.ExamID INNER JOIN
     EXAMS.Question ON EXAMS.ExamQuestion.QuestionID = EXAMS.Question.ID INNER JOIN
     EXAMS.Student ON EXAMS.Exam.ID = EXAMS.Student.ID INNER JOIN          
	 EXAMS.StudentAnswers ON EXAMS.Exam.ID = EXAMS.StudentAnswers.ExamID AND
	  EXAMS.Question.ID = EXAMS.StudentAnswers.QuestionID AND
	   EXAMS.Student.ID = EXAMS.StudentAnswers.StudentID
	   where EXAMS.Exam.ID=@EXAMSID and EXAMS.Student.ID= @studentID