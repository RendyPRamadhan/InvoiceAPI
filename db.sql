USE [master]
GO
/****** Object:  Database [DB_KALBE]    Script Date: 07/08/2021 15:33:23 ******/
CREATE DATABASE [DB_KALBE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_KALBE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_KALBE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_KALBE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_KALBE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DB_KALBE] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_KALBE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_KALBE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_KALBE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_KALBE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_KALBE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_KALBE] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_KALBE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_KALBE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_KALBE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_KALBE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_KALBE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_KALBE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_KALBE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_KALBE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_KALBE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_KALBE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_KALBE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_KALBE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_KALBE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_KALBE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_KALBE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_KALBE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_KALBE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_KALBE] SET RECOVERY FULL 
GO
ALTER DATABASE [DB_KALBE] SET  MULTI_USER 
GO
ALTER DATABASE [DB_KALBE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_KALBE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_KALBE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_KALBE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_KALBE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DB_KALBE] SET QUERY_STORE = OFF
GO
USE [DB_KALBE]
GO
/****** Object:  Table [dbo].[tbl_Company]    Script Date: 07/08/2021 15:33:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Company](
	[company_id] [int] IDENTITY(1,1) NOT NULL,
	[company_name] [varchar](50) NULL,
	[address] [varchar](50) NULL,
	[subdistrict] [varchar](50) NULL,
	[city] [varchar](30) NULL,
	[country] [varchar](30) NULL,
	[logo] [varchar](200) NULL,
 CONSTRAINT [PK_tbl_Company] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Invoice_Head]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Invoice_Head](
	[invoice_no] [varchar](7) NOT NULL,
	[language] [varchar](20) NULL,
	[from] [varchar](200) NULL,
	[to] [int] NULL,
	[invoice_date] [datetime] NULL,
	[invoice_due] [datetime] NULL,
	[po_number] [varchar](6) NULL,
	[subtotal] [decimal](18, 2) NULL,
	[discount_desc] [varchar](50) NULL,
	[discount] [decimal](2, 0) NULL,
	[total] [decimal](18, 2) NULL,
	[currency] [varchar](5) NULL,
 CONSTRAINT [PK_tbl_Invoice_Head] PRIMARY KEY CLUSTERED 
(
	[invoice_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_HOME_INVOICE]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_HOME_INVOICE]
AS
SELECT        H.invoice_no, H.language, H.[from], H.[to], H.invoice_date, H.invoice_due, H.po_number, H.subtotal, H.discount_desc, H.discount, H.total, H.currency, C.company_id, C.company_name, C.address, C.subdistrict, C.city, C.country, 
                         C.logo
FROM            dbo.tbl_Invoice_Head AS H INNER JOIN
                         dbo.tbl_Company AS C ON C.company_id = H.[to]
GO
/****** Object:  Table [dbo].[tbl_Invoice_Detail]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Invoice_Detail](
	[invoice_no] [varchar](7) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[quantity] [int] NULL,
	[rate] [decimal](18, 2) NULL,
	[amount] [decimal](18, 2) NULL,
	[unit_of_measurement] [varchar](2) NULL,
	[seq] [int] NULL,
 CONSTRAINT [PK_tbl_Invoice_Detail] PRIMARY KEY CLUSTERED 
(
	[invoice_no] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_INVOICE_DETAIL]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_INVOICE_DETAIL]
AS
SELECT        TOP (100) PERCENT D.invoice_no, D.name, D.quantity, D.rate, D.amount, D.unit_of_measurement, D.seq, H.currency
FROM            dbo.tbl_Invoice_Detail AS D INNER JOIN
                         dbo.tbl_Invoice_Head AS H ON H.invoice_no = D.invoice_no
ORDER BY D.seq DESC
GO
/****** Object:  Table [dbo].[tbl_Currency]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Currency](
	[currency_id] [int] IDENTITY(1,1) NOT NULL,
	[currency] [varchar](20) NULL,
	[curr_desc] [varchar](50) NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[currency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Language]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Language](
	[language_id] [int] IDENTITY(1,1) NOT NULL,
	[language] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_Language] PRIMARY KEY CLUSTERED 
(
	[language_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Purchase_Order]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Purchase_Order](
	[po_number] [varchar](6) NOT NULL,
	[amount] [decimal](18, 2) NULL,
	[pic] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_Purchase_Order] PRIMARY KEY CLUSTERED 
(
	[po_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_unit_of_measurement]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_unit_of_measurement](
	[uom_code] [varchar](2) NOT NULL,
	[unit_of_measurement] [varchar](20) NULL,
 CONSTRAINT [PK_tbl_unit_of_measurement] PRIMARY KEY CLUSTERED 
(
	[uom_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMD_INVOICE_DETAIL]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*
EXEC [SP_CMD_INVOICE_DETAIL] 'INSERT', 'INV-001','SmartPhone',2,1200,2400,'g',3
*/
CREATE PROCEDURE [dbo].[SP_CMD_INVOICE_DETAIL] @Query VARCHAR(20),
										@Invoice_no varchar(7) ,
										@Name varchar(100) ,
										@Quantity int,
										@Rate decimal(18, 2),
										@Amount decimal(18, 2),
										@Unit_of_measurement varchar(2),
										@seq int
AS
BEGIN TRAN

IF(@Query = 'INSERT')
	BEGIN

		INSERT INTO tbl_Invoice_Detail(invoice_no, [name], quantity, rate, amount, Unit_of_measurement, seq)
		SELECT @Invoice_no, @Name, @Quantity, @Rate, @Amount, @Unit_of_measurement, (SELECT ISNULL(max(seq),0) + 1 from tbl_Invoice_Detail)
	END
ELSE IF(@Query = 'UPDATE')
	BEGIN
		UPDATE tbl_Invoice_Detail
		SET [name] = @Name,
			quantity = @Quantity,
			rate = @Rate,
			amount = @Amount,
			Unit_of_measurement = @Unit_of_measurement
		WHERE invoice_no = @Invoice_no
			AND seq = @seq
	END
ELSE IF(@Query = 'DELETE')
	BEGIN
		DELETE tbl_Invoice_Detail
		WHERE invoice_no = @Invoice_no
			AND seq = @seq
	END

IF (@@error > 0)
	BEGIN
		ROLLBACK TRAN
	END
ELSE
	BEGIN
		COMMIT TRAN
	END
	
GO
/****** Object:  StoredProcedure [dbo].[SP_CMD_INVOICE_HEAD]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*
EXEC [SP_CMD_INVOICE_HEAD] 'INSERT', 'INV-003', 'PT INDOCYBER 2', 1,NULL, NULL,'PO-002',100000,'diskon test',20,90000,'USD'
EXEC [SP_CMD_INVOICE_HEAD] 'GENERATE', 'INV-001', 'PT INDOCYBER', 1,NULL, NULL,'PO-001',100000,'diskon test',10,90000,'USD'
EXEC [SP_CMD_INVOICE_HEAD] 'CANCEL', 'INV-005', 'PT INDOCYBER', 1,NULL, NULL,'PO-001',100000,'diskon test',10,90000,'USD'
*/
CREATE PROCEDURE [dbo].[SP_CMD_INVOICE_HEAD] @Query VARCHAR(20),
								@InvoiceNo varchar(200),
								@From varchar(200) ,
								@To int ,
								--@Invoice_date datetime ,
								--@Invoice_due datetime ,
								@Invoice_date varchar(50) ,
								@Invoice_due varchar(50) ,
								@PO_number varchar(6) ,
								@Subtotal decimal(18, 2) ,
								@Discount_desc varchar(50) ,
								@Discount decimal(2, 0) ,
								@Total decimal(18, 2) ,
								@Currency varchar(5) 
AS
BEGIN TRAN

declare @last_InvoiceNo int,
		@new_InvoiceNo char(7)

	IF(@Query = 'GENERATE')
	BEGIN
		--get last invoiceno
			SELECT @last_InvoiceNo = CONVERT(INT, isnull(max(right(invoice_no,3)),0)) 
			FROM tbl_Invoice_Head 

			--new invoiceno
			SET @new_InvoiceNo = 'INV-'+right('00'+CAST( @last_InvoiceNo+1 as VARCHAR(3)), 3)

			INSERT INTO tbl_Invoice_Head(invoice_no, language)
			SELECT @new_InvoiceNo, 1
	END
ELSE IF(@Query = 'UPDATE' OR @Query = 'INSERT')
	BEGIN
		UPDATE tbl_Invoice_Head
		SET currency = @Currency,
			[from] = @From, 
			[to] = @To, 
			invoice_date = @Invoice_date,
			invoice_due = @Invoice_due,
			po_number = @PO_number, 
			subtotal = @Subtotal, 
			discount_desc = @Discount_desc, 
			discount = @Discount, 
			total = @Total
		WHERE invoice_no = @InvoiceNo
	END
ELSE IF(@Query = 'DELETE')
	BEGIN
		DELETE tbl_Invoice_Detail
		WHERE invoice_no = @InvoiceNo

		DELETE tbl_Invoice_Head 
		WHERE invoice_no = @InvoiceNo
	END
ELSE IF(@Query = 'CANCEL')
	BEGIN
		IF(SELECT invoice_date FROM tbl_Invoice_Head WHERE invoice_no = @InvoiceNo) IS NULL
			BEGIN
				--'NULL BISA HAPUS'
				DELETE tbl_Invoice_Detail
				WHERE invoice_no = @InvoiceNo

				DELETE tbl_Invoice_Head
				WHERE invoice_no = @InvoiceNo
			END
		--ELSE 
			--BEGIN
				-- 'TIDAK HAPUS DATA. HANYA RESET FORM'
			--END
	END
SELECT invoice_no FROM tbl_Invoice_Head


IF (@@error > 0)
	BEGIN
		ROLLBACK TRAN
	END
ELSE
	BEGIN
		COMMIT TRAN
	END
	
GO
/****** Object:  StoredProcedure [dbo].[SP_GANERATE_NEW_INVOICE]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*
EXEC SP_GANERATE_NEW_INVOICE 'INSERT', ''
EXEC SP_GANERATE_NEW_INVOICE 'CANCEL', 'INV-001'
*/
CREATE PROCEDURE [dbo].[SP_GANERATE_NEW_INVOICE] @Query VARCHAR(20),
										 @InvoiceNo VARCHAR(7)
AS
BEGIN TRAN
	declare @last_InvoiceNo int,
			@new_InvoiceNo char(7)

	IF(@Query = 'INSERT')
		BEGIN
			--get last invoiceno
			SELECT @last_InvoiceNo = CONVERT(INT, isnull(max(right(invoice_no,3)),0)) 
			FROM tbl_Invoice_Head 

			--new invoiceno
			SET @new_InvoiceNo = 'INV-'+right('00'+CAST( @last_InvoiceNo+1 as VARCHAR(3)), 3)

			INSERT INTO tbl_Invoice_Head(invoice_no, language)
			SELECT @new_InvoiceNo, 1
		END
	ELSE IF(@Query = 'CANCEL')
		BEGIN
			DELETE tbl_Invoice_Detail
			WHERE invoice_no = @InvoiceNo

			DELETE tbl_Invoice_Head
			WHERE invoice_no = @InvoiceNo
		END
	
IF (@@error > 0)
	BEGIN
		ROLLBACK TRAN
	END
ELSE
	BEGIN
		COMMIT TRAN
	END
	
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_INVOICE]    Script Date: 07/08/2021 15:33:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*
EXEC [SP_SELECT_INVOICE] 'INV-001'
*/
CREATE PROCEDURE [dbo].[SP_SELECT_INVOICE] @Invoice_no varchar(7)
AS
BEGIN TRAN
	SELECT H.invoice_no, 
		H.[from], 
		H.[to], 
		C.company_name, C.[address], C.subdistrict, C.city, C.country, C.logo,
		CUR.currency, CUR.curr_desc, currency_id, 
		L.[language], L.language_id,
		H.invoice_date, 
		H.invoice_due, 
		H.po_number,
		H.subtotal,
		H.discount_desc,
		H.discount,
		H.total
	FROM  tbl_Invoice_Head H
	INNER JOIN tbl_Company C ON C.company_id = H.[to]
	INNER JOIN tbl_Currency CUR ON CUR.currency = H.currency
	INNER JOIN tbl_Language L ON L.language_id = H.[language]
	WHERE invoice_no = @Invoice_no
	/*
	SELECT invoice_no,
		seq,
		name,
		quantity,
		rate,
		amount,
		Unit_of_measurement
	FROM tbl_Invoice_Detail
	WHERE invoice_no = @Invoice_no
	ORDER BY seq DESC
	*/

IF (@@error > 0)
	BEGIN
		ROLLBACK TRAN
	END
ELSE
	BEGIN
		COMMIT TRAN
	END
	
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "H"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_HOME_INVOICE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_HOME_INVOICE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "H"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 136
               Right = 450
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_INVOICE_DETAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_INVOICE_DETAIL'
GO
USE [master]
GO
ALTER DATABASE [DB_KALBE] SET  READ_WRITE 
GO
