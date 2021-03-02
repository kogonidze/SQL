--------------Task 1--------------------
Select last_name 
From stud
Where last_name LIKE N'%б%' or last_name LIKE N'%о%'

--------------Task 2--------------------
Select * 
From stud
Where last_name LIKE N'К%' and s_name IS NULL

--------------Task 3---------------------
Select *
From stud
Where len(last_name) >= 8

--или

Select *
From stud
Where last_name LIKE '________%'

--------------Task 4----------------------
Select *
From stud
Where len(last_name) <> 7 and last_name LIKE N'%а%'

--или

Select *
From stud
Where len(last_name) != 7 and last_name LIKE N'%а%'

--------------Task 5-----------------------
Select *
From stud
Where faculty=N'ФПМ' and form=N'очная' and (year=1 or year=2)
Order by s_name

--------------Task 6-----------------------
Select *
From stud
Where faculty=N'ФПК' and form=N'заочная' and exm > 6
Order by exm desc

--------------Task 7------------------------
Select distinct last_name, faculty, form 
From teach
Where faculty=N'ФПК'
Order by form, last_name

--------------Task 8------------------------
Select distinct last_name
From teach
Where faculty=N'ФПМ' and year=1 and hours>100

--------------Task 9------------------------
Select distinct last_name
From teach
Where s_name IS NULL and DATEDIFF(day, start_work_date, GETDATE())/365 > 3

--------------Task 10-----------------------
Select distinct subj
From teach
Where faculty=N'ФПМ' and year=3

--------------Task 11-----------------------
Select subj, year, form, f_name+' '+s_name+' '+last_name as N'ФИО'
From teach
Where faculty=N'ФПК' and hours>100

--------------Task 12-----------------------
Select subj, faculty, year, form, f_name+' '+last_name as N'ФИО'
From teach
Where s_name IS NULL

--------------Task 13-----------------------
Select distinct last_name
From teach
Where DATEDIFF(day, br_date, '20210101')/365 > 30

--------------Task 14-----------------------
Select distinct last_name
From teach
Where DATEDIFF(day, br_date, GETDATE())/365 between 35 and 40
Order by last_name

--------------Task 15-----------------------
Select distinct last_name, br_date
From teach
Where MONTH(br_date) = 10
Order by br_date