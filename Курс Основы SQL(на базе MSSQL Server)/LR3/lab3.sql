-------------Task 1--------------
SELECT
	faculty, 
	form, 
	AVG(exm) AS [avg exm]
FROM stud
WHERE form=N'заочная'
GROUP BY 
	faculty, 
	form

-------------Task 2---------------
SELECT 
	faculty, 
	year, 
	MAX(exm) AS [max exm]
FROM stud
GROUP BY
	faculty, 
	year

-------------Task 3---------------
SELECT
	faculty, 
	AVG(exm) AS [avg exm]
FROM stud
GROUP BY faculty
HAVING AVG(exm) > 7

-------------Task 4---------------
SELECT 
	faculty, 
	year, 
	form, 
	AVG(exm) AS [avg exm]
FROM stud
GROUP BY
	faculty, 
	year, 
	form
HAVING AVG(exm) > 7.5

-------------Task 5----------------
SELECT 
	faculty, 
	year, 
	MIN(exm) AS [min exm]
FROM stud
GROUP BY
	faculty, 
	year

-------------Task 6----------------
SELECT
	faculty, 
	form, 
	MIN(exm) AS [min exm]
FROM stud
GROUP BY faculty, form
HAVING MIN(exm)>6

-------------Task 7----------------
SELECT
	faculty,
	year, 
	form, 
	AVG(all_h-inclass_h) AS [sampo]
FROM stud
WHERE year = 3 
	AND faculty = N'ФПК'
GROUP BY
	faculty, 
	year, 
	form

-------------Task 8----------------
SELECT
	faculty, 
	year, 
	form, 
	AVG(all_h-inclass_h) AS [sampo]
FROM stud
GROUP BY
	faculty, 
	year,
	form
HAVING AVG(all_h-inclass_h) > 150

-------------Task 9-----------------
SELECT
	last_name + ' ' + f_name AS [FIO], 
	COUNT(DISTINCT subj) AS [subjects]
FROM teach
GROUP BY last_name + ' ' + f_name

-------------Task 10----------------
SELECT
	faculty, 
	COUNT(DISTINCT last_name + ' ' + f_name) AS [teachers]
FROM teach
GROUP BY faculty

-------------Task 11----------------
SELECT
	subj, 
	MAX(hours) AS [max hours]
FROM teach
GROUP BY subj

-------------Task 12----------------
SELECT
	last_name + ' ' + f_name AS [FIO], 
	COUNT(DISTINCT subj) AS [subjects]
FROM teach
GROUP BY last_name + ' ' + f_name
HAVING COUNT(DISTINCT subj) > 1

-------------Task 13-----------------
SELECT 
	COUNT(DISTINCT subj) AS [subjects],
	faculty, 
	year
FROM teach
WHERE year = 2
GROUP BY
	faculty, 
	year

-------------Task 14-----------------
SELECT
	COUNT(DISTINCT subj) AS [subjects], 
	faculty
FROM teach
WHERE s_name is NULL
GROUP BY faculty
