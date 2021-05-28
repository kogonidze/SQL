--1
CREATE PROCEDURE sale_info
AS
	IF (exists(SELECT COUNT(*) FROM shops) AND exists(SELECT COUNT(*) FROM sales))
		BEGIN
			SELECT shop_name, COUNT(sales.id) as checks_count
			FROM sales
			JOIN shops ON sales.id_shop = shops.id
			GROUP BY shop_name
		END
	ELSE
		BEGIN
			PRINT('Входные данные некорректны')
		END
GO

EXEC sale_info

--2
CREATE PROCEDURE all_info
AS
DECLARE @count_shops int = 0,
		@count_cars int = 0,
		@count_sales int = 0,
		@count_clients int = 0
	SELECT @count_shops = COUNT(*) FROM shops
	SELECT @count_cars = COUNT(*) FROM cars
	SELECT @count_sales = COUNT(*) FROM sales
	SELECT @count_clients = COUNT(*) FROM clients

	PRINT N'В базе ' + CONVERT(varchar(5), @count_shops) + N' салонов'
	PRINT N'В базе ' + CONVERT(varchar(5), @count_cars) + N' автомобилей'
	PRINT N'В базе ' + CONVERT(varchar(5), @count_sales) + N' продаж'
	PRINT N'В базе ' + CONVERT(varchar(5), @count_clients) + N' клиентов'
GO

EXEC all_info

--3
CREATE PROCEDURE add_sale2 @nm_shop nvarchar(20), @nm_car nvarchar(20), @nm_client nvarchar(20)
AS
DECLARE @id_shop int = 0,
		@id_car int = 0,
		@id_client int = 0,
		@sale_date datetime = GETDATE()
	IF(exists(SELECT * FROM shops WHERE shop_name=@nm_shop) AND exists(SELECT * FROM cars WHERE car_name = @nm_car))
		BEGIN
			IF(SELECT COUNT(*) FROM clients WHERE client_name = @nm_client) = 0
				BEGIN
					INSERT INTO clients(client_name) VALUES (@nm_client)
				END

			SELECT @id_shop = id FROM shops WHERE shop_name=@nm_shop
			SELECT @id_car = id FROM cars WHERE car_name=@nm_car
			SELECT @id_client = id FROM clients WHERE client_name=@nm_client

			INSERT INTO sales(id_car, id_client, id_shop, sale_date) VALUES (@id_car, @id_client, @id_shop, @sale_date)
		END
	ELSE
		BEGIN
			PRINT(N'Входные данные некорректны')
		END
GO

EXEC add_sale2 'Automall', 'Audi A5', N'Коток'

--4
CREATE PROCEDURE edit_date_order @id_shop int, @new_date datetime
AS
	IF(exists(SELECT id FROM sales WHERE id = @id_shop))
		BEGIN
			UPDATE sales SET sale_date = @new_date WHERE id = @id_shop
		END
	ELSE
		BEGIN
			PRINT(N'Продажа с таким id не найдена!')
		END
GO

EXEC edit_date_order 66, '1989-12-23'