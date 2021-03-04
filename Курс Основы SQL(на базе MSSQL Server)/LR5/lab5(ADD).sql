--------------Task 1-----------------
SELECT
	last_name,
	hours.course,
	faculty.faculty_name
FROM stud
	JOIN process ON stud.id = process.stud_id
	JOIN hours ON process.hours_id = hours.id
	JOIN faculty ON hours.faculty_id = faculty.id
	JOIN (SELECT
				course,
				faculty_name
		  FROM stud
				JOIN process ON stud.id = process.stud_id 
					AND stud.last_name = N'Бежик'
				JOIN hours ON process.hours_id = hours.id
				JOIN faculty ON hours.faculty_id = faculty.id) tmp on tmp.course = hours.course 
					AND tmp.faculty_name = faculty.faculty_name

--------------Task 2-------------------
SELECT
	last_name,
	exm,
	faculty.faculty_name
FROM stud
	JOIN process ON stud.id = process.stud_id 
		AND stud.exm > (SELECT exm
						FROM stud
						WHERE last_name = N'Ботяновский')
	JOIN hours ON process.hours_id = hours.id
	JOIN faculty ON hours.faculty_id = faculty.id
	JOIN (SELECT faculty.faculty_name
			FROM stud
				JOIN process ON stud.id = process.stud_id 
					AND stud.last_name = N'Ботяновский'
				JOIN hours ON process.hours_id = hours.id
				JOIN faculty ON hours.faculty_id = faculty.id) tmp ON tmp.faculty_name = faculty.faculty_name

----------------Task 3-----------------
SELECT
	last_name,
	stud.exm,
	faculty.faculty_name
FROM stud
	JOIN process ON stud.id = process.stud_id 
	JOIN hours ON process.hours_id = hours.id
	JOIN faculty ON hours.faculty_id = faculty.id
	JOIN (SELECT
				AVG(exm) as exm,
				faculty.faculty_name
			FROM stud
				JOIN process ON stud.id = process.stud_id
				JOIN hours ON process.hours_id = hours.id
				JOIN faculty ON hours.faculty_id = faculty.id
			GROUP BY faculty.faculty_name) tmp on tmp.faculty_name = faculty.faculty_name AND tmp.exm > stud.exm

---------------Task 4-------------------
SELECT
	last_name,
	faculty.faculty_name,
	form.form_name
FROM stud
	JOIN process ON stud.id = process.stud_id 
		AND stud.s_name IS NOT NULL
	JOIN hours ON process.hours_id = hours.id
	JOIN faculty ON hours.faculty_id = faculty.id
	JOIN form ON hours.form_id = form.id
	JOIN (SELECT
				faculty.faculty_name,
				form.form_name
			FROM stud
				JOIN process ON stud.id = process.stud_id 
					AND stud.s_name IS NULL
				JOIN hours ON process.hours_id = hours.id
				JOIN faculty ON hours.faculty_id = faculty.id
				JOIN form ON hours.form_id = form.id
			GROUP BY 
				faculty.faculty_name, 
				form.form_name
	) tmp ON tmp.faculty_name = faculty.faculty_name 
			AND tmp.form_name = form.form_name

---------------Task 5---------------------
SELECT
	last_name,
	br_date,
	faculty.faculty_name
FROM stud
	JOIN process ON stud.id = process.stud_id 
		AND YEAR(stud.br_date) < 
			(SELECT YEAR(br_date) FROM stud WHERE last_name = N'Бежик')
	JOIN hours ON process.hours_id = hours.id
	JOIN faculty ON hours.faculty_id = faculty.id
	JOIN (SELECT
				faculty.faculty_name
			FROM stud
				JOIN process ON stud.id = process.stud_id 
					AND stud.last_name = N'Бежик'
				JOIN hours ON process.hours_id = hours.id
				JOIN faculty ON hours.faculty_id = faculty.id
			GROUP BY 
				faculty.faculty_name
	) tmp ON tmp.faculty_name = faculty.faculty_name 

---------------Task 6---------------------
SELECT
	last_name,
	exm,
	faculty.faculty_name
FROM stud
	JOIN process ON stud.id = process.stud_id
	JOIN hours ON process.hours_id = hours.id
	JOIN faculty ON hours.faculty_id = faculty.id
	JOIN (SELECT 
				faculty_name, 
				MAX(exm) AS [max exm] 
			FROM stud
				JOIN process ON stud.id = process.stud_id
				JOIN hours ON process.hours_id = hours.id
				JOIN faculty ON hours.faculty_id = faculty.id
			GROUP BY faculty_name) tmp ON tmp.faculty_name = faculty.faculty_name 
											AND tmp.[max exm] = stud.exm
--------------Task 7-----------------------
SELECT
	last_name,
	exm,
	hours.course
FROM stud
	JOIN process ON stud.id = process.stud_id
	JOIN hours ON process.hours_id = hours.id
	JOIN (SELECT
				course,
				MIN(exm) AS [min exm]
			FROM stud
				JOIN process ON stud.id = process.stud_id 
				JOIN hours ON process.hours_id = hours.id
			GROUP BY course) tmp ON tmp.course = hours.[course] 
									AND tmp.[min exm] = stud.exm
