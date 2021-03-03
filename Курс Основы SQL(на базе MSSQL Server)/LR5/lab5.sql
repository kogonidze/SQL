--------------Task 1--------------------
SELECT 
	last_name, 
	course, 
	faculty_name, 
	form_name,
	br_date
FROM stud
	JOIN process ON stud.id = process.stud_id 
		AND DATEDIFF(DAY, stud.br_date, GETDATE())/365 < 35
	JOIN hours ON process.hours_id = hours.id
	JOIN form ON hours.form_id = form.id
		AND form.form_name LIKE N'заочно'
	JOIN faculty ON hours.faculty_id = faculty.id

--------------Task 2--------------------
SELECT
	faculty_name,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
GROUP BY faculty_name

--------------Task 3--------------------
SELECT
	form_name,
	COUNT(last_name) as [count students]
FROM form
	LEFT JOIN hours ON form.id = hours.form_id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
GROUP BY form_name

--------------Task 4--------------------
SELECT
	faculty_name,
	COUNT(last_name) as [count students],
	AVG(CONVERT(float, DATEDIFF(DAY, br_date, '20211231'))/365)
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
GROUP BY faculty_name

--------------Task 5--------------------
SELECT
	last_name,
	s_name,
	in_date,
	faculty_name,
	course,
	form_name
FROM stud
	JOIN process ON stud.id = process.stud_id AND s_name IS NULL
	JOIN hours ON process.hours_id = hours.id
	JOIN faculty ON hours.faculty_id = faculty.id
	JOIN form ON hours.form_id = form.id

--------------Task 6--------------------
SELECT TOP 1 WITH TIES
	faculty_name,
	COUNT(last_name) as [count students]
FROM faculty
	JOIN hours ON faculty.id = hours.faculty_id
	JOIN process ON hours.id = process.hours_id
	JOIN stud ON process.stud_id = stud.id 
		AND YEAR(stud.in_date)=2015
GROUP BY faculty_name
ORDER BY COUNT(last_name) DESC

--------------Task 7--------------------
SELECT
	faculty_name,
	form_name,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id
	LEFT JOIN form ON hours.form_id = form.id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id 
		AND YEAR(stud.in_date)=2014
GROUP BY 
	faculty_name, 
	form_name

--------------Task 8--------------------
SELECT 
	faculty_name
FROM faculty
	JOIN hours ON faculty.id = hours.faculty_id
	JOIN form ON hours.form_id = form.id AND form.form_name LIKE N'заочно'
GROUP BY faculty_name

--------------Task 9--------------------
SELECT
	faculty_name,
	form_name,
	course
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id
	LEFT JOIN form ON hours.form_id = form.id
GROUP BY 
	faculty_name, 
	form_name, course

--------------Task 10--------------------
SELECT
	faculty_name,
	form_name,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id
	LEFT JOIN form ON hours.form_id = form.id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
GROUP BY 
	faculty_name, 
	form_name

--------------Task 11--------------------
--  если "всех студентов первого и третьего курсов для всех факультетов и форм" == 
-- 'для каждого факультета и каждой формы вывести число студентов первого и третьего курсов"
SELECT
	faculty_name,
	form_name,
	course,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id 
		AND (course = 1 OR course = 3)
	LEFT JOIN form ON hours.form_id = form.id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
GROUP BY
	faculty_name,
	form_name,
	course

--если подразумевается просто их суммарное количество
SELECT 
	COUNT(last_name) as [count students]
FROM hours
	LEFT JOIN process ON hours.id = process.hours_id  
		AND (course = 1 OR course = 3)
	LEFT JOIN stud ON process.stud_id = stud.id

--------------Task 12--------------------
-----аналогично Task 11, если нужен отчет по каждому факультету, форме и курсу
SELECT
	faculty_name,
	form_name,
	course,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id 
	LEFT JOIN form ON hours.form_id = form.id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
		AND stud.s_name IS NULL
GROUP BY
	faculty_name,
	form_name,
	course

---- если просто общее количество
SELECT 
	COUNT(last_name) as [count students]
FROM hours
	LEFT JOIN process ON hours.id = process.hours_id  
	LEFT JOIN stud ON process.stud_id = stud.id
		AND stud.s_name IS NULL

--------------Task 13--------------------
SELECT
	faculty_name,
	course,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id 
	LEFT JOIN form ON hours.form_id = form.id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
		AND stud.exm > 7.5
GROUP BY
	faculty_name,
	course

--------------Task 14--------------------
SELECT
	faculty_name,
	form_name,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id
	LEFT JOIN form ON hours.form_id = form.id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
		AND DATEDIFF(day, br_date, GETDATE())/365 > 45
GROUP BY
	faculty_name,
	form_name

--------------Task 15--------------------
SELECT
	faculty_name,
	form_name,
	course,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id
	LEFT JOIN form ON hours.form_id = form.id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
		AND DATEDIFF(day, br_date, GETDATE())/365 < 27
GROUP BY
	faculty_name,
	form_name, 
	course

--------------Task 16--------------------
SELECT
	faculty_name,
	COUNT(last_name) as [count students]
FROM faculty
	LEFT JOIN hours ON faculty.id = hours.faculty_id
	LEFT JOIN process ON hours.id = process.hours_id
	LEFT JOIN stud ON process.stud_id = stud.id
		AND stud.last_name LIKE N'С%'
GROUP BY
	faculty_name