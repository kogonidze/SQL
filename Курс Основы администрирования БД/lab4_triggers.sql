--1
USE motocars
GO

CREATE TRIGGER TR_Clients_AID
ON clients AFTER INSERT, DELETE
AS
	SELECT COUNT(*) as count_clients FROM clients
GO

INSERT INTO clients VALUES (N'Сидоров', '375291234567')

DELETE FROM clients WHERE client_name = N'Сидоров'

--2
CREATE TRIGGER TR_Clients_AU
ON clients AFTER UPDATE
AS
	DECLARE @old_name varchar(20) ,
			@new_name varchar(20)
	
	SELECT @old_name=client_name FROM deleted
	SELECT @new_name=client_name FROM inserted

	PRINT N'фамилия ' + @old_name + N' изменена на ' + @new_name
GO

UPDATE clients SET client_name=N'Коток' WHERE client_name=N'Сидоров'
UPDATE clients SET client_name=N'Сидоров' WHERE client_name=N'Коток'

--3
CREATE TRIGGER TR_Clients_ID
ON clients INSTEAD OF DELETE
AS
	IF NOT EXISTS(SELECT COUNT(TABLE_NAME) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'arch_sale')
		BEGIN
			CREATE TABLE arch_sale(
				id int not null identity  primary key,
				shop_name nvarchar(50) NOT NULL,
				shop_address nvarchar(50) NOT NULL,
				client_name nvarchar(50) NOT NULL,
				car nvarchar(50) NOT NULL,
				price int NOT NULL,
				sale_date date NOT NULL,
				operation_date	date NOT NULL,
				operation_user nvarchar(50) NOT NULL
				)
		END

	IF (SELECT COUNT(id) FROM deleted) <= 1
		BEGIN
			INSERT INTO arch_sale
			SELECT shops.shop_name, 
				shops.shop_address, 
				deleted.client_name, 
				cars.car_name, 
				cars.car_price, 
				sales.sale_date,
				CONVERT(DATE, GETDATE()),
				CURRENT_USER
			FROM sales
			JOIN deleted ON sales.id_client = deleted.id
			JOIN shops ON sales.id_shop = shops.id
			JOIN cars ON sales.id_car = cars.id

			DELETE FROM sales WHERE id IN (SELECT sales.id FROM SALES
												JOIN deleted ON sales.id_client = deleted.id
												JOIN shops ON sales.id_shop = shops.id
												JOIN cars ON sales.id_car = cars.id)

			DELETE FROM clients WHERE id in (SELECT id FROM deleted)
		END
	ELSE
		BEGIN
			PRINT N'Допустимо удалять не более одного клиента в рамках одной операции!'
		END
GO

DELETE FROM clients WHERE client_name = N'Михайлов'

--4
CREATE TRIGGER TR_Sales_AU
ON sales AFTER UPDATE
AS
	DECLARE @old_date date,
			@new_date date,
			@id_sale int,
			@operation_type_msg nvarchar(150)
	IF (SELECT COUNT(TABLE_NAME) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'edit_log') = 0
		BEGIN
			CREATE TABLE edit_log(
				id int not null identity  primary key,
				operation_user nvarchar(50) NOT NULL,
				operation_type nvarchar(150) NOT NULL,
				operation_date	date NOT NULL)
		END

	SELECT @old_date = sale_date FROM deleted
	SELECT @id_sale = id FROM deleted
	SELECT @new_date = sale_date FROM inserted

	SET @operation_type_msg = N'В записи о продаже с id ' + CONVERT(varchar, @id_sale) + 
			N' была изменена дата продажи. Старое значение: ' + CONVERT(varchar, @old_date) +
			N' Новое значение: ' + CONVERT(varchar, @new_date);

	INSERT INTO edit_log VALUES (CURRENT_USER, @operation_type_msg, CONVERT(DATE, GETDATE()))
GO

EXEC edit_date_order 44, '2021-05-27'