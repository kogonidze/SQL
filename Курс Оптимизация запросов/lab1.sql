--1 
SELECT DISTINCT stud.last_name
FROM teach
JOIN work ON teach.id = work.teach_id AND teach.last_name = N'Круглов'
JOIN hours ON work.hours_id = hours.id
JOIN process ON process.hours_id = hours.id
JOIN stud ON process.stud_id = stud.id


SELECT COUNT(DISTINCT stud.last_name) as count_students
FROM teach
JOIN work ON teach.id = work.teach_id AND teach.last_name = N'Скворцов'
JOIN hours ON work.hours_id = hours.id
JOIN process ON process.hours_id = hours.id
JOIN stud ON process.stud_id = stud.id

SELECT AVG(stud.exm) as avg_exam, subj
FROM teach 
JOIN work ON teach.id = work.teach_id AND teach.last_name = N'Сидоренко'
JOIN subj ON work.subj_id = subj.id
JOIN hours ON work.hours_id = hours.id
JOIN process ON process.hours_id = hours.id
JOIN stud ON process.stud_id = stud.id
GROUP BY subj

--2
CREATE TABLE #lab1(
	student_name nvarchar(25),
	teacher_name nvarchar(25),
	subj nvarchar(150),
	stud_exm float)

INSERT INTO #lab1 
SELECT stud.last_name as student_name, 
	teach.last_name as teacher_name, 
	subj,
	stud.exm as stud_exm
FROM teach
JOIN work ON teach.id = work.teach_id
JOIN subj ON work.subj_id = subj.id
JOIN hours ON work.hours_id = hours.id
JOIN process ON process.hours_id = hours.id
JOIN stud ON process.stud_id = stud.id

--3
SELECT DISTINCT student_name 
FROM #lab1
WHERE teacher_name = N'Круглов'

SELECT COUNT(DISTINCT student_name) as count_students
FROM #lab1
WHERE teacher_name = N'Скворцов'

SELECT AVG(stud_exm) as avg_exam, subj
FROM #lab1
WHERE teacher_name = N'Сидоренко'
GROUP BY subj

--5
GO
CREATE PROC prepod_inf_1 @name nvarchar(25)
AS
BEGIN
	SELECT DISTINCT stud.last_name
	FROM teach
	JOIN work ON teach.id = work.teach_id AND teach.last_name = @name
	JOIN hours ON work.hours_id = hours.id
	JOIN process ON process.hours_id = hours.id
	JOIN stud ON process.stud_id = stud.id

	SELECT COUNT(DISTINCT stud.last_name) as count_students
	FROM teach
	JOIN work ON teach.id = work.teach_id AND teach.last_name = @name
	JOIN hours ON work.hours_id = hours.id
	JOIN process ON process.hours_id = hours.id
	JOIN stud ON process.stud_id = stud.id

	SELECT AVG(stud.exm) as avg_exam, subj
	FROM teach 
	JOIN work ON teach.id = work.teach_id AND teach.last_name = @name
	JOIN subj ON work.subj_id = subj.id
	JOIN hours ON work.hours_id = hours.id
	JOIN process ON process.hours_id = hours.id
	JOIN stud ON process.stud_id = stud.id
	GROUP BY subj
END

GO
EXEC prepod_inf_1 N'Скворцов'

--6
GO
CREATE PROC prepod_inf_2 @name nvarchar(25)
AS
BEGIN
	SELECT DISTINCT student_name 
	FROM #lab1
	WHERE teacher_name = @name

	SELECT COUNT(DISTINCT student_name) as count_students
	FROM #lab1
	WHERE teacher_name = @name

	SELECT AVG(stud_exm) as avg_exam, subj
	FROM #lab1
	WHERE teacher_name = @name
	GROUP BY subj
END
GO

EXEC prepod_inf_2 N'Скворцов'

--7
GO
CREATE PROC prepod_inf_3 @name nvarchar(25)
AS
BEGIN
	DECLARE @lab1 TABLE(
	student_name nvarchar(25),
	teacher_name nvarchar(25),
	subj nvarchar(150),
	stud_exm float)

	INSERT INTO @lab1 
	SELECT stud.last_name as student_name, 
		teach.last_name as teacher_name, 
		subj,
		stud.exm as stud_exm
	FROM teach
	JOIN work ON teach.id = work.teach_id
	JOIN subj ON work.subj_id = subj.id
	JOIN hours ON work.hours_id = hours.id
	JOIN process ON process.hours_id = hours.id
	JOIN stud ON process.stud_id = stud.id

	SELECT DISTINCT student_name 
	FROM @lab1
	WHERE teacher_name = @name

	SELECT COUNT(DISTINCT student_name) as count_students
	FROM @lab1
	WHERE teacher_name = @name

	SELECT AVG(stud_exm) as avg_exam, subj
	FROM @lab1
	WHERE teacher_name = @name
	GROUP BY subj
END
GO

EXEC prepod_inf_3 N'Скворцов'

--8
GO
EXEC prepod_inf_1 N'Скворцов'

GO
EXEC prepod_inf_2 N'Скворцов'

GO
EXEC prepod_inf_3 N'Скворцов'

--9
SELECT
(SELECT COUNT(*)
FROM faculty
JOIN hours ON faculty.id = hours.faculty_id AND faculty.faculty_name = N'ФПК' and hours.course = 1
JOIN process ON hours.id = process.hours_id
GROUP BY hours.course) as N'1 курс',
(SELECT COUNT(*)
FROM faculty
JOIN hours ON faculty.id = hours.faculty_id AND faculty.faculty_name = N'ФПК' and hours.course = 2
JOIN process ON hours.id = process.hours_id
GROUP BY hours.course) as N'2 курс',
(SELECT COUNT(*)
FROM faculty
JOIN hours ON faculty.id = hours.faculty_id AND faculty.faculty_name = N'ФПК' and hours.course = 3
JOIN process ON hours.id = process.hours_id
GROUP BY hours.course) as N'3 курс'

--10
GO
WITH tmp(course_num, students_count)
AS(
SELECT hours.course as course_num, COUNT(*) as students_count
FROM faculty
JOIN hours ON faculty.id = hours.faculty_id AND faculty.faculty_name = N'ФПК'
JOIN process ON hours.id = process.hours_id
GROUP BY hours.course
)
SELECT
(SELECT students_count FROM tmp WHERE course_num = 1) as N'1 курс',
(SELECT students_count FROM tmp WHERE course_num = 2) as N'2 курс',
(SELECT students_count FROM tmp WHERE course_num = 3) as N'3 курс'

