CREATE DATABASE QuanLyQuanCafe
GO

USE QuanLyQuanCafe
GO

--Food
--Table
--FoodCategory
--Account
--Bill
--BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống' -- Trong || Co nguoi

)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'KD_er',
	Password NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0 --1: admin; 0: staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0

	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	dateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	dateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 --1: da thanh toan ; 0: chua thanh toan

	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id),
)
GO

INSERT INTO dbo.Account
		(
			UserName,
			DisplayName,
			Password,
			Type
		)
VALUES (
			N'admin',
			N'Big Boss',
			N'1',
			1
		)

INSERT INTO dbo.Account
		(
			UserName,
			DisplayName,
			Password,
			Type
		)
VALUES (
			N'staff',
			N'normal staff',
			N'1',
			0
		)

SELECT * FROM dbo.Account
GO

CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @username = N'admin'

SELECT * FROM DBO.Account WHERE UserName = N'admin' AND Password = N'1'
GO


CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND Password = @passWord
END
GO

-- Them ban
DECLARE @i INT = 0

WHILE @i <= 20
BEGIN
	INSERT dbo.TableFood ( name ) VALUES ( N'Bàn ' + CAST(@i as varchar(100)))
	SET @i = @i + 1
END
GO

SELECT * FROM dbo.TableFood
GO


CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO

EXEC dbo.USP_GetTableList




-- Them category
INSERT dbo.FoodCategory ( name ) 
VALUES ( N'Hải sản')

INSERT dbo.FoodCategory ( name ) 
VALUES ( N'Nông sản')

INSERT dbo.FoodCategory ( name ) 
VALUES ( N'Lâm sản')

INSERT dbo.FoodCategory ( name ) 
VALUES ( N'Nước')

-- Mon an
INSERT dbo.Food( name, idCategory, price ) 
VALUES ( N'Mực một nắng ước sa tế', 1, 120000)

INSERT dbo.Food( name, idCategory, price ) 
VALUES ( N'Nghêu hấp sả', 1, 50000)

INSERT dbo.Food( name, idCategory, price ) 
VALUES ( N'Dú dê nướng sữa', 2, 120000)

INSERT dbo.Food( name, idCategory, price ) 
VALUES ( N'Heo rừng nướng muối ớt',3, 68000)

INSERT dbo.Food( name, idCategory, price ) 
VALUES ( N'Cơm chiên mushi', 3, 95000)

INSERT dbo.Food( name, idCategory, price ) 
VALUES ( N'7UP', 4, 20000)

INSERT dbo.Food( name, idCategory, price ) 
VALUES ( N'Cafe', 4, 15000)

-- Them bill
INSERT INTO Bill (dateCheckIn, dateCheckOut, idTable, status) VALUES ( GETDATE(), NULL, 1, 0)
INSERT INTO Bill (dateCheckIn, dateCheckOut, idTable, status) VALUES ( GETDATE(), NULL, 2, 0)
INSERT INTO Bill (dateCheckIn, dateCheckOut, idTable, status) VALUES ( GETDATE(), GETDATE(), 2, 1)
INSERT INTO Bill (dateCheckIn, dateCheckOut, idTable, status) VALUES ( GETDATE(), NULL, 3, 0)

-- them billinfo
INSERT INTO BillInfo (idBill, idFood, count) VALUES (1,1,2)
INSERT INTO BillInfo (idBill, idFood, count) VALUES (1,3,4)
INSERT INTO BillInfo (idBill, idFood, count) VALUES (1,5,1)
INSERT INTO BillInfo (idBill, idFood, count) VALUES (2,6,2)
INSERT INTO BillInfo (idBill, idFood, count) VALUES (3,5,2)
INSERT INTO BillInfo (idBill, idFood, count) VALUES (4,5,2)

SELECT * FROM Bill
SELECT * FROM BillInfo
SELECT * FROM Food
SELECT * FROM FoodCategory

SELECT id FROM Bill WHERE idTable = 3 AND status = 0
SELECT * FROM Bill WHERE idTable = 1 AND status = 0

SELECT f.name, bi.count, f.price, f.price*bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f
WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.idTable = 3