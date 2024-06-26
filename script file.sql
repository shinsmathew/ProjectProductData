USE [master]
GO
/****** Object:  Database [ProjectProductData]    Script Date: 20-May-24 10:32:45 PM ******/
CREATE DATABASE [ProjectProductData]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProjectProductData', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ProjectProductData.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProjectProductData_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ProjectProductData_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ProjectProductData] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProjectProductData].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProjectProductData] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProjectProductData] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProjectProductData] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProjectProductData] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProjectProductData] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProjectProductData] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProjectProductData] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProjectProductData] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProjectProductData] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProjectProductData] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProjectProductData] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProjectProductData] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProjectProductData] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProjectProductData] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProjectProductData] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProjectProductData] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProjectProductData] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProjectProductData] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProjectProductData] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProjectProductData] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProjectProductData] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProjectProductData] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProjectProductData] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProjectProductData] SET  MULTI_USER 
GO
ALTER DATABASE [ProjectProductData] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProjectProductData] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProjectProductData] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProjectProductData] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProjectProductData] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProjectProductData] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ProjectProductData] SET QUERY_STORE = ON
GO
ALTER DATABASE [ProjectProductData] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ProjectProductData]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 20-May-24 10:32:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productlists]    Script Date: 20-May-24 10:32:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productlists](
	[ProductID] [nvarchar](450) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[ProductSize] [decimal](18, 2) NOT NULL,
	[ProductPrize] [decimal](18, 2) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_productlists] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[productlists] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [CreatedDate]
GO
/****** Object:  StoredProcedure [dbo].[GetProductID]    Script Date: 20-May-24 10:32:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Shins>
-- Create date: <17-may 2024>
-- Description:	<GetID>
-- GetProductID
-- =============================================
CREATE PROCEDURE [dbo].[GetProductID] 
	
AS
BEGIN
	Declare @Count int
	Declare @PID VARCHAR(100)
	DECLARE @nonNumericPart NVARCHAR(MAX)
	 DECLARE @numericPart NVARCHAR(MAX)

	select @Count=count(ProductID) from productlists
	 
	 IF(@Count!=0)
	 BEGIN
	 SET @PID= (SELECT TOP 1 ProductID FROM [dbo].[productlists] ORDER BY CreatedDate DESC)


       SET @nonNumericPart  = LEFT(@PID, PATINDEX('%[0-9]%', @PID) - 1)


         SET  @numericPart  = RIGHT(@PID, LEN(@PID) - LEN(@nonNumericPart))
		 SET  @numericPart= @numericPart+1

          SELECT '00'+@numericPart As ProductID


	 END
	 ELSE
	 BEGIN
	

	   SET @numericPart='001'
	   SELECT @numericPart As ProductID

	 END




--SELECT @nonNumericPart AS NonNumericPart, @numericPart AS NumericPart;

END
GO
USE [master]
GO
ALTER DATABASE [ProjectProductData] SET  READ_WRITE 
GO
