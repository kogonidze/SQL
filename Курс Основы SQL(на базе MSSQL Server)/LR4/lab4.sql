--------------Task 1--------------------
SELECT 
	TOP 1 subj, 
	hours
FROM teach
ORDER BY hours DESC

--или

SELECT
	TOP 1 subj,
	max(hours)
FROM teach
GROUP BY subj

--------------Task 2--------------------
SELECT
	subj, 
	hours
FROM teach
WHERE hours in 
	(SELECT 
		max(hours) 
	FROM teach)

--или

SELECT 
	TOP 1 WITH TIES subj, 
	hours
FROM teach
ORDER BY hours DESC

--------------Task 3--------------------
SELECT
	TOP 1 faculty, 
	COUNT(br_date) as [count people]
FROM stud
WHERE DATEDIFF(day, br_date, getdate()) / 365 < 35
GROUP BY faculty
ORDER BY [count people] DESC

--------------Task 4--------------------
SELECT
	TOP 1 faculty, 
	COUNT(last_name) as [count people]
FROM stud
WHERE 
	year = 1 
	AND (
		form = N'очная' or form = N'заочная'
	)
GROUP BY faculty
ORDER BY [count people] DESC

--------------Task 5--------------------
SELECT
	TOP 1 faculty, 
	COUNT(last_name) as [count people]
FROM stud
WHERE form = N'заочная' 
GROUP BY faculty
ORDER BY [count people]

--------------Task 6--------------------
SELECT
	last_name, 
	exm
FROM stud
WHERE exm = 
	(SELECT
		max(exm) 
	FROM stud)

--или 

SELECT
	TOP 1 last_name, 
	exm
FROM stud
ORDER BY exm DESC

--------------Task 7--------------------
SELECT
	TOP 5 WITH TIES last_name, 
	exm
FROM stud
ORDER BY exm DESC

--------------Task 8--------------------
SELECT
	last_name, 
	exm
FROM stud
WHERE exm > 
	(SELECT
		max(exm)/1.2 
	FROM stud)

--------------Task 9--------------------
SELECT
	last_name, 
	exm
FROM stud
WHERE exm IN 
	(SELECT
		max(exm)
	FROM stud)

--------------Task 10--------------------
SELECT
	last_name, 
	faculty
FROM stud
WHERE faculty IN 
	(SELECT
		TOP 1 faculty
	FROM stud 
	GROUP BY faculty
	ORDER BY COUNT(last_name) DESC)

--------------Task 11--------------------
SELECT DISTINCT form
FROM stud

--------------Task 12--------------------
SELECT 
	CONVERT
	(
		float, 
			(SELECT 
				COUNT(last_name)
			FROM stud
			WHERE s_name IS NULL)
	)
	/
	(	
		SELECT
			COUNT(last_name) 
		FROM stud
	) as [percent of foreign students]
