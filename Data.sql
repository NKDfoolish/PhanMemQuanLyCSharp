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

SELECT * FROM TableFood

SELECT id FROM Bill WHERE idTable = 3 AND status = 0
SELECT * FROM Bill WHERE idTable = 1 AND status = 0

SELECT f.name, bi.count, f.price, f.price*bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f
WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.idTable = 3

SELECT f.name, bi.count, f.price, f.price*bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.status = 0 AND b.idTable = 4

SELECT * FROM Food

go


alter proc USP_InsertBill
@idTable int
as
begin
	insert into dbo.Bill (dateCheckIn, dateCheckOut, idTable, status, discount) values (GETDATE(), null, @idTable, 0, 0)
end
go


create proc USP_InsertBillInfo
@idBill int, @idFood int, @count int
as
begin
	insert into dbo.BillInfo(idBill, idFood, count) values (@idBill, @idFood, @count)
end
go


select MAX(id) from Bill
go

alter proc USP_InsertBillInfo
@idBill int, @idFood int, @count int
as
begin
	declare @isExistBillInfo int
	declare @foodCount int = 1

	select @isExistBillInfo = id, @foodCount = b.count from dbo.BillInfo as b where idBill = @idBill and idFood = @idFood

	if (@isExistBillInfo > 0)
	begin
		declare @newCount int = @foodCount + @count
		if (@newCount > 0)
			update dbo.BillInfo set count = @foodCount + @count where idFood = @idFood
		else
			delete dbo.BillInfo where idBill = @idBill and idFood = @idFood
	end
	else
	begin
		insert into dbo.BillInfo (idBill, idFood, count) values (@idBill, @idFood, @count)
	end

	
end
go

-- trigger
alter trigger UTG_UpdateBillInfo
on dbo.BillInfo for insert, update
as
begin 
	declare @idBill int
	select @idBill = idBill from inserted
	declare @idTable int
	select @idTable = idTable from dbo.Bill where id = @idBill and status = 0

	declare @count int
	select @count = COUNT(*) from BillInfo where idBill = @idBill

	if (@count > 0)
	begin
		update dbo.TableFood set status = N'Có người' where id = @idTable
	end
	else
		update dbo.TableFood set status = N'Trống' where id = @idTable
end
go

create trigger UTG_UpdateBill
on dbo.Bill for update
as
begin 
	declare @idBill int
	select @idBill = id from inserted
	declare @idTable int
	select @idTable = idTable from dbo.Bill where id = @idBill
	declare @count int = 0
	select @count = COUNT(*) from dbo.Bill where idTable = @idTable and status = 0

	if (@count = 0)
		update dbo.TableFood set status = N'Trống' where id = @idTable
end
go

delete BillInfo
delete Bill
go

alter table dbo.bill 
add discount int

update dbo.Bill set discount = 0

select * from Bill
--

go

alter proc USP_SwitchTable
@idTable1 int , @idTable2 int
as
begin
	declare @idFirstBill int
	declare @idSecondBill int

	declare @isFirstTableEmpty int = 1
	declare @isSecondTableEmpty int = 1

	SELECT @idFirstBill = id FROM Bill WHERE idTable = @idTable1 AND status = 0
	SELECT @idSecondBill = id FROM Bill WHERE idTable = @idTable2 AND status = 0

	if (@idFirstBill is null)
	begin
		insert Bill (dateCheckIn, dateCheckOut, idTable, status) values (GETDATE(), null, @idTable1, 0)
		select @idFirstBill = max(id) from Bill where idTable = @idTable1 and status = 0
	end
	select @isFirstTableEmpty = COUNT(*) from BillInfo where idBill = @idFirstBill

	if (@idSecondBill is null)
	begin
		insert Bill (dateCheckIn, dateCheckOut, idTable, status) values (GETDATE(), null, @idTable2, 0)
		select @idSecondBill = max(id) from Bill where idTable = @idTable2 and status = 0
	end
	select @isSecondTableEmpty = COUNT(*) from BillInfo where idBill = @idSecondBill


	select id into IDBillInfoTable from BillInfo where idBill = @idSecondBill

	update BillInfo set idBill = @idSecondBill where idBill = @idFirstBill

	update BillInfo set idBill = @idFirstBill where id in (select * from IDBillInfoTable)

	drop table IDBillInfoTable

	if (@isFirstTableEmpty = 0)
		update TableFood set status = N'Trống' where id = @idTable2
	if (@isSecondTableEmpty = 0)
		update TableFood set status = N'Trống' where id = @idTable1
end
go


select * from Bill
go

delete BillInfo
delete Bill

alter table bill add totalPrice float

alter proc USP_GetListBillByDate
@checkIn date, @checkOut date
as
begin
	select t.name as [Tên bàn], b.totalPrice as [Tổng tiền], dateCheckIn as [Ngày vào], dateCheckOut as [Ngày ra], discount as [Giảm giá]
	from dbo.Bill as b, TableFood as t
	where dateCheckIn >= @checkIn and dateCheckOut <= @checkOut and b.status = 1 and t.id = b.idTable
end
go


select * from Account
go

alter proc USP_UpdateAccount
@userName nvarchar(100), @displayName nvarchar(100), @password nvarchar(100), @newPassword nvarchar(100)
as
begin
	declare @isRightPass int

	select @isRightPass = COUNT(*) from Account where UserName = @userName and Account.Password = @password

	if (@isRightPass = 1)
	begin
		if(@newPassword = null or @newPassword = '')
			update Account set DisplayName = @displayName where UserName = @userName
		else
			update Account set DisplayName = @displayName, Account.Password = @password where UserName = @userName
	end
end
go

create trigger UTG_DeleteBillInfo
on dbo.BillInfo for Delete
as
begin
	declare @idBillInfo int
	declare @idBill int

	select @idBillInfo = id, @idBill = deleted.idBill from deleted

	declare @idTable int
	select @idTable = idTable from Bill where id = @idBill

	declare @count int = 0
	select @count = count(*) from BillInfo as bi, Bill as b where b.id = bi.idBill and b.id = @idBill and b.status = 0

	if (@count = 0)
		update dbo.TableFood set status = N'Trống' where id = @idTable

end
go