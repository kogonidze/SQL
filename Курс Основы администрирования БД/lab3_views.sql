--1
CREATE VIEW PurchaseLogs
AS
SELECT shop_name, 
		shop_address, 
		client_name, 
		car_name, 
		car_price, 
		sale_date
	FROM sales
	LEFT JOIN shops ON sales.id_shop = shops.id
	LEFT JOIN cars ON sales.id_car = cars.id
	LEFT JOIN clients ON sales.id_client = clients.id
GO

SELECT * FROM PurchaseLogs

--2
CREATE VIEW StatisticsOfSalesByMalls
AS
SELECT
	shop_name,
	SUM(car_price) as sum_price,
	COUNT(sales.id) as checks_count, 
	COUNT(DISTINCT client_name) as clients_count
FROM sales
	JOIN shops ON sales.id_shop = shops.id
	JOIN cars ON sales.id_car = cars.id
	JOIN clients ON sales.id_client = clients.id
GROUP BY shop_name
GO

SELECT * FROM StatisticsOfSalesByMalls

--3
CREATE VIEW StatisticsOfSalesInFebruary
AS
SELECT
	shop_name,
	SUM(car_price) as sum_price
FROM sales
	JOIN shops ON sales.id_shop = shops.id and MONTH(sales.sale_date) = 02
	JOIN cars ON sales.id_car = cars.id
GROUP BY shop_name
GO

SELECT * FROM StatisticsOfSalesInFebruary

--4
CREATE VIEW GetTopCountSalesMall
AS
SELECT TOP(1)
	shop_name,
	COUNT(sales.id) as sales_count
FROM sales
	JOIN shops ON sales.id_shop = shops.id
GROUP BY shop_name
ORDER BY sales_count DESC
GO

SELECT * FROM GetTopCountSalesMall

--5
CREATE VIEW GetTopSumSalesMall
AS
SELECT TOP(1)
	shop_name,
	SUM(car_price) as sales_sum
FROM sales
	JOIN shops ON sales.id_shop = shops.id
	JOIN cars ON sales.id_car = cars.id
GROUP BY shop_name
ORDER BY sales_sum DESC
GO

SELECT * FROM GetTopSumSalesMall

--6
CREATE VIEW GetTopSalesCarInInomarkaMall
AS
SELECT TOP(1)
	shop_name,
	car_name,
	COUNT(sales.id) as sales_count
FROM sales
	JOIN shops ON sales.id_shop = shops.id AND shops.shop_name=N'Иномарка'
	JOIN cars ON sales.id_car = cars.id
GROUP BY shop_name, car_name
ORDER BY sales_count DESC
GO

SELECT * FROM GetTopSalesCarInInomarkaMall

--7
CREATE VIEW GetUniqueClientsInAutomall
AS
SELECT
	shop_name,
	client_name
FROM sales
	JOIN shops ON sales.id_shop = shops.id AND shops.shop_name=N'Automall'
	JOIN clients ON sales.id_client = clients.id
GROUP BY shop_name, client_name
GO

SELECT * FROM GetUniqueClientsInAutomall