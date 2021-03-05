-------------------------Task 1--------------------------
CREATE VIEW GetCarDealershipWherePetrovBought AS
SELECT shop_name
FROM shops
	JOIN sales ON shops.id = sales.id_shop 
		AND sales.date_sale = '20180105'
	JOIN clients ON sales.id_client = clients.id 
		AND clients.client_name LIKE N'Петров'
GO

SELECT *
FROM GetCarDealershipWherePetrovBought
GO

-------------------------Task 2--------------------------
CREATE VIEW GetLebedevAndEgorovPurchases AS
SELECT 
	cars.car_name,
	sales.date_sale,
	shops.shop_name,
	clients.client_name
FROM clients
	JOIN sales ON clients.id = sales.id_client 
		AND (client_name LIKE N'Лебедев' OR client_name LIKE N'Егоров')
	JOIN shops ON sales.id_shop = shops.id
	JOIN cars ON sales.id_car = cars.id
ORDER BY clients.client_name
OFFSET 0 ROWS
GO

SELECT *
FROM GetLebedevAndEgorovPurchases
GO

-------------------------Task 3--------------------------
CREATE VIEW GetSalesAmountsFromAllDealershipsInFebruary AS
SELECT
	SUM(price) AS [sum sales]
FROM shops
	JOIN sales ON shops.id = sales.id_shop
		AND MONTH(date_sale) = 02
	JOIN cars ON sales.id_car = cars.id
GO

SELECT *
FROM GetSalesAmountsFromAllDealershipsInFebruary
GO

-------------------------Task 4--------------------------
CREATE VIEW GetMostSellingDealership AS
SELECT TOP 1 WITH TIES
	shops.shop_name,
	COUNT(sales.id) AS [count sales]
FROM shops
	JOIN sales ON shops.id = sales.id_shop 
GROUP BY shops.shop_name
ORDER BY [count sales] DESC
GO

SELECT *
FROM GetMostSellingDealership
GO

-------------------------Task 5--------------------------
CREATE VIEW GetMostSellingAutoInInomarkaDealership AS
SELECT TOP 1 WITH TIES
	cars.car_name,
	COUNT(sales.id) AS [count sales]
FROM shops
	JOIN sales ON shops.id = sales.id_shop
		AND shops.shop_name LIKE N'Иномарка '
	JOIN cars ON sales.id_car = cars.id
GROUP BY cars.car_name
ORDER BY [count sales] DESC
GO

SELECT *
FROM GetMostSellingAutoInInomarkaDealership
GO

-------------------------Task 6--------------------------
CREATE VIEW GetCountUniqueClientsOfAutomallDealership AS
SELECT 
	COUNT(distinct clients.client_name) as [count clients]
FROM shops
	JOIN sales ON shops.id = sales.id_shop
		AND shops.shop_name LIKE 'Automall'
	JOIN clients ON sales.id_client = clients.id
GO

SELECT *
FROM GetCountUniqueClientsOfAutomallDealership
GO

------------------------Task 7----------------------------
CREATE VIEW GetSalesCountIn4WheelInMarch AS
SELECT
	COUNT(sales.id) as [count sales]
FROM shops
	JOIN sales ON shops.id = sales.id_shop 
		AND shop_name LIKE N'4 колеса' 
		AND MONTH(sales.date_sale) = 03
GO

SELECT *
FROM GetSalesCountIn4WheelInMarch

GO