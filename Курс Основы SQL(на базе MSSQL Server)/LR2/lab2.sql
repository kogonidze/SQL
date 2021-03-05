--------------Task 1--------------------
SELECT last_name 
FROM stud
WHERE last_name LIKE N'%б%'
	OR last_name LIKE N'%о%'

--------------Task 2--------------------
SELECT * 
FROM stud
WHERE last_name LIKE N'К%' 
	AND s_name IS NULL

--------------Task 3---------------------
SELECT *
FROM stud
WHERE LEN(last_name) >= 8

--или

SELECT *
FROM stud
WHERE last_name LIKE '________%'

--------------Task 4----------------------
SELECT *
FROM stud
WHERE LEN(last_name) <> 7 
	AND last_name LIKE N'%а%'

--или

SELECT *
FROM stud
WHERE LEN(last_name) != 7 
	AND last_name LIKE N'%а%'

--------------Task 5-----------------------
SELECT *
FROM stud
WHERE faculty=N'ФПМ' 
	AND form=N'очная' 
	AND (year=1 OR year=2)
ORDER BY s_name

--------------Task 6-----------------------
SELECT *
FROM stud
WHERE faculty=N'ФПК' 
	AND form=N'заочная' 
	AND exm > 6
ORDER BY exm DESC

--------------Task 7------------------------
SELECT DISTINCT
	last_name, 
	faculty, 
	form 
FROM teach
WHERE faculty=N'ФПК'
ORDER BY form, last_name

--------------Task 8------------------------
SELECT DISTINCT last_name
FROM teach
WHERE faculty=N'ФПМ' 
	AND year=1 AND hours>100

--------------Task 9------------------------
SELECT DISTINCT last_name
FROM teach
WHERE s_name IS NULL 
	AND DATEDIFF(day, start_work_date, GETDATE())/365 > 3

--------------Task 10-----------------------
SELECT DISTINCT subj
FROM teach
WHERE faculty=N'ФПМ' 
	AND year=3

--------------Task 11-----------------------
SELECT 
	subj, 
	year, 
	form, 
	f_name+' '+s_name+' '+last_name AS N'ФИО'
FROM teach
WHERE faculty=N'ФПК' 
	AND hours>100

--------------Task 12-----------------------
SELECT 
	subj, 
	faculty, 
	year, 
	form, 
	f_name+' '+last_name AS N'ФИО'
FROM teach
WHERE s_name IS NULL

--------------Task 13-----------------------
SELECT DISTINCT last_name
FROM teach
WHERE DATEDIFF(day, br_date, '20210101')/365 > 30

--------------Task 14-----------------------
SELECT DISTINCT last_name
FROM teach
WHERE DATEDIFF(day, br_date, GETDATE())/365 BETWEEN 35 AND 40
ORDER BY last_name

--------------Task 15-----------------------
SELECT DISTINCT 
	last_name, 
	br_date
FROM teach
WHERE MONTH(br_date) = 10
ORDER BY br_date

