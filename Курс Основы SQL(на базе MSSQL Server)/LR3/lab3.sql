-------------Task 1--------------
Select faculty, form, avg(exm) as [avg exm]
From stud
Where form=N'заочная'
Group by faculty, form

-------------Task 2---------------
Select faculty, year, max(exm) as [max exm]
From stud
Group by faculty, year

-------------Task 3---------------
Select faculty, avg(exm) as [avg exm]
From stud
Group by faculty
Having avg(exm) > 7

-------------Task 4---------------
Select faculty, year, form, avg(exm) as [avg exm]
From stud
Group by faculty, year, form
Having avg(exm) > 7.5

-------------Task 5----------------
Select faculty, year, min(exm) as [min exm]
From stud
Group by faculty, year

-------------Task 6----------------
Select faculty, form, min(exm) as [min exm]
From stud
Group by faculty, form
Having min(exm)>6

-------------Task 7----------------
Select faculty, year, form, avg(all_h-inclass_h) as [sampo]
From stud
Where year = 3 and faculty = N'ФПК'
Group by faculty, year, form

-------------Task 8----------------
Select faculty, year, form, avg(all_h-inclass_h) as [sampo]
From stud
Group by faculty, year, form
Having avg(all_h-inclass_h) > 150

-------------Task 9-----------------
Select last_name + ' ' + f_name as [FIO] , count(distinct subj) as [subjects]
From teach
Group by last_name + ' ' + f_name

-------------Task 10----------------
Select faculty, count(distinct last_name + ' ' + f_name) as [teachers]
From teach
Group by faculty

-------------Task 11----------------
Select subj, max(hours) as [max hours]
From teach
Group by subj

-------------Task 12----------------
Select last_name + ' ' + f_name as [FIO], count(distinct subj) as [subjects]
From teach
Group by last_name + ' ' + f_name
Having count(distinct subj) > 1

-------------Task 13-----------------
Select count(distinct subj) as [subjects], faculty, year
from teach
Where year = 2
Group by faculty, year

-------------Task 14-----------------
Select count(distinct subj) as [subjects], faculty
from teach
Where s_name is NULL
Group by faculty