--1
CREATE FUNCTION GetClientStatus(@client_id int)
	RETURNS varchar(20)
AS
BEGIN
	DECLARE @status varchar(20),
			@count_sales int

	SELECT @count_sales = COUNT(*) FROM sales WHERE id_client = @client_id

	IF @count_sales > 3
		BEGIN
			SET @status = 'VIP'
		END
	IF @count_sales BETWEEN 2 and 3
		BEGIN
			SET @status = N'постоянный'
		END
	IF @count_sales = 1
		BEGIN
			SET @status = N'лояльный'
		END
	RETURN @status;
END	

SELECT [dbo].GetClientStatus(1)

--2
CREATE FUNCTION GetSalesByDate(@sale_date date)
	RETURNS table
AS
	RETURN(
	SELECT clients.client_name, 
		cars.car_name, 
		cars.car_price, 
		shops.shop_name, 
		shops.shop_address, 
		sales.sale_date
	FROM sales
		JOIN cars ON sales.id_car = cars.id
		JOIN shops ON sales.id_shop = shops.id
		JOIN clients ON sales.id_client = clients.id
		WHERE sales.sale_date <= @sale_date)

SELECT * FROM GetSalesByDate('2018-02-01')

--3
CREATE LOGIN motorcars
WITH PASSWORD = '123',
DEFAULT_DATABASE = motocars,
CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF

CREATE USER motorcars FOR LOGIN motorcars

GRANT EXECUTE ON GetClientStatus TO motorcars
GRANT SELECT ON GetSalesByDate TO motorcars