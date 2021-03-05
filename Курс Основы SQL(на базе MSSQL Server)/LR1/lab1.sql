CREATE DATABASE Kotok COLLATE Cyrillic_General_CI_AS
GO

USE Kotok;

------------- Task 1 ----------
CREATE TABLE Students
(
	id INT NOT NULL IDENTITY,
	name NVARCHAR(50) NOT NULL,
	lastName NVARCHAR(50) NOT NULL,
	patronymic NVARCHAR(50) NOT NULL,
	groupId INT,
	birthDate DATE NOT NULL,
	CONSTRAINT PK_Students PRIMARY KEY(id)
);

CREATE TABLE Groups
(
	id INT NOT NULL IDENTITY,
	groupNumber NVARCHAR(20) NOT NULL,
	course INT NOT NULL,
	CONSTRAINT PK_Groups PRIMARY KEY(id)
);

CREATE TABLE Plans
(
	groupId INT NOT NULL,
	subjectId INT NOT NULL,
	CONSTRAINT PK_Plans PRIMARY KEY(groupId, subjectId)
);

CREATE TABLE Subjects
(
	id INT NOT NULL identity,
	subjectName NVARCHAR(50) NOT NULL,
	numbersOfHours INT NOT NULL,
	CONSTRAINT PK_Subjects PRIMARY KEY(id)
);
GO

--------------Task 2-----------------

ALTER TABLE Students 
ADD CONSTRAINT FK_to_Groups FOREIGN KEY (groupId) REFERENCES Groups(id)

ALTER TABLE Plans
ADD CONSTRAINT FK_to_Subjects FOREIGN KEY(subjectId) REFERENCES Subjects(id)

ALTER TABLE Plans 
ADD CONSTRAINT FK_to_GroupsFromPlans FOREIGN KEY(groupId) REFERENCES Groups(id)
GO

--------------Task 3-----------------
INSERT INTO Subjects
VALUES
('Физика', 200), 
('Математика', 120), 
('Основы алгоритмизации', 70),
('Проектирование БД',130), 
('Средства визуального программирования', 90), 
('Объектно-ориентированное программирование', 70)

INSERT INTO Groups
VALUES
('ПО135', 1),
('ПО134',1),
('ПО235',2),
('ПО335', 3)

INSERT INTO Students
VALUES
('П.', 'Федоренко', 'Р.', 1, '19971225'),
('П', 'Михеенок', 'Г.', 2, '19930205'),
('Н.', 'Савицкаян', '', 3, '19870922'),
('М.', 'Ковальчук', 'Е.', 3, '19920617'),
('Н.', 'Заболотная', 'Г.', 4, '19920618'),
('Н.', 'Шарапо', '', 4, '19920814')

INSERT INTO Plans 
VALUES
(1,1), 
(2,1), 
(1,2), 
(2,2), 
(3,3), 
(3,4),
(4,5), 
(4,6)
GO

----- проверка на соответствие созданных таблиц заданию -------
SELECT
	Students.lastName, 
	Students.name, 
	Students.patronymic, 
	Students.birthDate, 
	Groups.groupNumber, 
	Groups.course 
FROM Students 
	JOIN Groups on Students.groupId = Groups.id

SELECT DISTINCT
	Subjects.subjectName, 
	Groups.course, 
	Subjects.numbersOfHours 
FROM Subjects
	JOIN Plans ON Subjects.id = Plans.subjectId
	JOIN Groups ON Groups.id = Plans.groupId
ORDER BY course
GO

-------------Task 4-------------------
UPDATE Students 
SET groupId = 2 
WHERE groupId = 1
GO

SELECT *
FROM Students 
WHERE groupId = 1

-------------Task 5-------------------
DELETE FROM Plans
WHERE groupId = 1

DELETE FROM Groups
WHERE id = 1
GO

SELECT *
FROM Plans
WHERE groupId = 1

SELECT * 
FROM Groups 
WHERE id = 1

-------------Task 6-------------------
UPDATE Subjects 
SET numbersOfHours = 30 
WHERE subjectName = 'Средства визуального программирования' 
	OR subjectName = 'Объектно-ориентированное программирование'
GO

SELECT * 
FROM Subjects

-------------Task 7-------------------
ALTER TABLE Subjects
ADD FormOfControl NVARCHAR(50) DEFAULT('Экзамен') WITH VALUES
GO

UPDATE Subjects
SET FormOfControl = 'Зачет' 
WHERE subjectName = 'Основы алгоритмизации'
GO

SELECT * 
FROM Subjects

-------------Task 8-------------------
ALTER TABLE Students 
DROP COLUMN patronymic
GO

SELECT *
FROM Students
