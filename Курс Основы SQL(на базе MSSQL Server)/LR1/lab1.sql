create database Kotok COLLATE Cyrillic_General_CI_AS

use Kotok

------------- Task 1 ----------

create table Students(
id int not null identity,
name nvarchar(50) not null,
lastName nvarchar(50) not null,
patronymic nvarchar(50) not null,
groupId int,
birthDate date not null,
CONSTRAINT PK_Students Primary key(id)
);

create table Groups(
id int not null identity,
groupNumber nvarchar(20) not null,
course int not null,
CONSTRAINT PK_Groups Primary key(id)
);

create table Plans(
groupId int not null,
subjectId int not null,
CONSTRAINT PK_Plans Primary key(groupId, subjectId)
);

create table Subjects(
id int not null identity,
subjectName nvarchar(50) not null,
numbersOfHours int not null,
CONSTRAINT PK_Subjects Primary key(id)
);

--------------Task 2-----------------

Alter table Students add CONSTRAINT FK_to_Groups foreign key (groupId) references Groups(id)
Alter table Plans add CONSTRAINT FK_to_Subjects foreign key(subjectId) references Subjects(id)
Alter table Plans add CONSTRAINT FK_to_GroupsFromPlans foreign key(groupId) references Groups(id)

--------------Task 3-----------------

Insert into Subjects values ('Физика', 200), ('Математика', 120), ('Основы алгоритмизации', 70),
('Проектирование БД',130), ('Средства визуального программирования', 90), ('Объектно-ориентированное программирование', 70)

Insert into Groups values('ПО135', 1), ('ПО134',1), ('ПО235',2), ('ПО335', 3)

Insert into Students values('П.', 'Федоренко', 'Р.', 1, '19971225'), ('П', 'Михеенок', 'Г.', 2, '19930205'),
('Н.', 'Савицкаян', '', 3, '19870922'), ('М.', 'Ковальчук', 'Е.', 3, '19920617'), ('Н.', 'Заболотная', 'Г.', 4, '19920618'),
('Н.', 'Шарапо', '', 4, '19920814')

Insert into Plans values(1,1), (2,1), (1,2), (2,2), (3,3), (3,4), (4,5), (4,6)

----- проверка на соответствие созданных таблиц заданию -------
Select Students.lastName, Students.name, Students.patronymic, Students.birthDate, Groups.groupNumber, Groups.course from Students 
Inner join Groups
on Students.groupId = Groups.id

Select Distinct Subjects.subjectName, Groups.course, Subjects.numbersOfHours from Subjects
join Plans
on Subjects.id = Plans.subjectId
join Groups
on Groups.id = Plans.groupId
Order by course

-------------Task 4-------------------
Update Students set groupId = 2 where groupId = 1

select * from Students where groupId = 1

-------------Task 5-------------------
Delete from Plans where groupId = 1
Delete from Groups where id = 1

select * from Plans where groupId = 1
select * from Groups where id = 1

-------------Task 6-------------------
Update Subjects set numbersOfHours = 30 where subjectName = 'Средства визуального программирования' 
or subjectName = 'Объектно-ориентированное программирование'

select * from Subjects

-------------Task 7-------------------
Alter table Subjects Add FormOfControl nvarchar(50) default('Экзамен') with values

Update Subjects set FormOfControl = 'Зачет' where subjectName = 'Основы алгоритмизации'

select * from Subjects

-------------Task 8-------------------

Alter table Students Drop column patronymic

select * from Students