USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe]    Script Date: 11/6/2023 3:33:25 PM ******/
CREATE DATABASE [QuanLyQuanCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QuanLyQuanCafe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QuanLyQuanCafe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QuanLyQuanCafe] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyQuanCafe', N'ON'
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUERY_STORE = ON
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dateCheckIn] [date] NOT NULL,
	[dateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'admin', N'CEO', N'1962026656160185351301320480154111117132155', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [Password], [Type]) VALUES (N'staff', N'Culi', N'1962026656160185351301320480154111117132155', 0)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (40, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 8, 1, 30, 252000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (41, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 4, 1, 0, 170000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (42, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 6, 1, 50, 420000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (43, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 2, 1, 0, 88000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (44, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 7, 1, 50, 75000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (45, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 5, 1, 50, 22500)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (46, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-05' AS Date), 8, 1, 0, 840000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (47, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-05' AS Date), 6, 1, 0, 65000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (48, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-06' AS Date), 7, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (49, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-05' AS Date), 1, 1, 0, 15000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (50, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 12, 1, 50, 17500)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (51, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 21, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (52, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 15, 1, 10, 108000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (53, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-06' AS Date), 16, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (54, CAST(N'2023-11-03' AS Date), CAST(N'2023-11-03' AS Date), 4, 1, 0, 215000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (55, CAST(N'2023-11-05' AS Date), CAST(N'2023-11-05' AS Date), 4, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (56, CAST(N'2023-11-05' AS Date), CAST(N'2023-11-05' AS Date), 4, 1, 0, 198000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (57, CAST(N'2023-11-05' AS Date), CAST(N'2023-11-05' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (58, CAST(N'2023-11-05' AS Date), CAST(N'2023-11-06' AS Date), 6, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (59, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 2, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (60, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 2, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (61, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 3, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (62, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 8, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (63, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 11, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (64, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 10, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (65, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 6, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (66, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 4, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (67, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 12, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (68, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 9, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (69, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 5, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (70, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 1, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (71, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 13, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (72, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 14, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (73, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 15, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (74, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 17, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (75, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 18, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (76, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 19, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (77, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 20, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (78, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 21, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (79, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 2, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (80, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 3, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (81, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 4, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (82, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 8, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (83, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 12, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (84, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 11, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (85, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 7, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (86, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 3, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (87, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 16, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (88, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 11, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (89, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 6, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [dateCheckIn], [dateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (90, CAST(N'2023-11-06' AS Date), CAST(N'2023-11-06' AS Date), 5, 1, 0, 120000)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (58, 40, 1, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (59, 41, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (60, 41, 1, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (61, 42, 3, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (62, 43, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (63, 43, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (64, 44, 3, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (65, 44, 7, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (66, 45, 7, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (70, 47, 7, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (71, 49, 7, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (72, 50, 7, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (73, 50, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (74, 47, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (75, 51, 1, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (76, 52, 3, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (77, 54, 1, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (78, 54, 5, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (79, 55, 1, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (80, 46, 1, 7)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (81, 56, 5, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (82, 56, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (83, 56, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (84, 56, 7, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (85, 57, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (87, 59, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (88, 58, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (89, 60, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (90, 61, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (91, 62, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (92, 63, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (93, 64, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (94, 65, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (95, 48, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (96, 66, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (97, 67, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (98, 68, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (99, 69, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (100, 70, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (101, 71, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (102, 72, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (103, 73, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (104, 53, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (105, 74, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (106, 75, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (107, 76, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (108, 77, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (109, 78, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (110, 79, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (111, 80, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (112, 81, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (113, 82, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (114, 83, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (115, 84, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (116, 85, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (117, 86, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (118, 87, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (119, 88, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (120, 89, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (121, 90, 1, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Mực một nắng ước sa tế', 1, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Nghêu hấp sả', 1, 50000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Dú dê nướng sữa', 2, 120000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Heo rừng nướng muối ớt', 3, 68000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Cơm chiên mushi', 3, 95000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'7up', 4, 14000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Cafe', 4, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (11, N'wine', 4, 100000)
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Hải sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Nông sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Lâm sản')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Nước')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 0', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 11', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn 12', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 13', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Bàn 14', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (16, N'Bàn 15', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (17, N'Bàn 16', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (18, N'Bàn 17', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (19, N'Bàn 18', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (20, N'Bàn 19', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (21, N'Bàn 20', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'KD_er') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Password]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [dateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
as
begin
	select t.name as [Tên bàn], b.totalPrice as [Tổng tiền], dateCheckIn as [Ngày vào], dateCheckOut as [Ngày ra], discount as [Giảm giá]
	from dbo.Bill as b, TableFood as t
	where dateCheckIn >= @checkIn and dateCheckOut <= @checkOut and b.status = 1 and t.id = b.idTable
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDateAndPage]
@checkIn date, @checkOut date, @page int
AS 
BEGIN
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows
	DECLARE @exceptRows INT = (@page - 1) * @pageRows
	
	;WITH BillShow AS( SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBill]
@idTable int
as
begin
	insert into dbo.Bill (dateCheckIn, dateCheckOut, idTable, status, discount) values (GETDATE(), null, @idTable, 0, 0)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBillInfo]
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
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND Password = @passWord
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_SwitchTable]
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
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 11/6/2023 3:33:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateAccount]
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
GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE 
GO
