USE [master]
GO
/****** Object:  Database [MaxiDB]    Script Date: 8/6/2024 12:01:22 PM ******/
CREATE DATABASE [MaxiDB]
GO
ALTER DATABASE [MaxiDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MaxiDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MaxiDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MaxiDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MaxiDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MaxiDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MaxiDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MaxiDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MaxiDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MaxiDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MaxiDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MaxiDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MaxiDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MaxiDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MaxiDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MaxiDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MaxiDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MaxiDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MaxiDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MaxiDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MaxiDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MaxiDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MaxiDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MaxiDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MaxiDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MaxiDB] SET  MULTI_USER 
GO
ALTER DATABASE [MaxiDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MaxiDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MaxiDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MaxiDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MaxiDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MaxiDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MaxiDB', N'ON'
GO
ALTER DATABASE [MaxiDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [MaxiDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MaxiDB]
GO
/****** Object:  Table [dbo].[Beneficiary]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beneficiary](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FirstLastName] [nvarchar](50) NOT NULL,
	[SecondLastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Curp] [nvarchar](18) NOT NULL,
	[Ssn] [nvarchar](10) NOT NULL,
	[Phone] [numeric](10, 0) NOT NULL,
	[Nationality] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Beneficiary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FirstLastName] [nvarchar](50) NOT NULL,
	[SecondLastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Curp] [nvarchar](18) NOT NULL,
	[Ssn] [nvarchar](10) NOT NULL,
	[Phone] [numeric](18, 0) NOT NULL,
	[Nationality] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeBeneficiary]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeBeneficiary](
	[EmployeeId] [int] NOT NULL,
	[BeneficiaryId] [int] NOT NULL,
	[Percentage] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeBeneficiary] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC,
	[BeneficiaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmployeeBeneficiary] ADD  CONSTRAINT [DF_EmployeeBeneficiary_Percentage]  DEFAULT ((0)) FOR [Percentage]
GO
/****** Object:  StoredProcedure [dbo].[AddBeneficiary]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	AddBeneficiary
-- =============================================
CREATE PROCEDURE [dbo].[AddBeneficiary] (
	@Name nvarchar(50),
	@FirstLastName [nvarchar](50),
	@SecondLastName [nvarchar](50),
	@DateOfBirth [date],
	@Curp [nvarchar](18),
	@Ssn [nvarchar](10),
	@Phone [numeric](18, 0),
	@Nationality [nvarchar](50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Beneficiary] ([Name], FirstLastName, SecondLastName, DateOfBirth, Curp, Ssn, Phone, Nationality) VALUES
		(@Name,
		@FirstLastName,
		@SecondLastName,
		@DateOfBirth,
		@Curp,
		@Ssn,
		@Phone,
		@Nationality)
	
	DECLARE @Id INT
	SET @Id = SCOPE_IDENTITY();

	EXEC [dbo].[GetBeneficiary] @Id = @Id

	
END
GO
/****** Object:  StoredProcedure [dbo].[AddEmployee]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	AddEmployee
-- =============================================
CREATE PROCEDURE [dbo].[AddEmployee] (
	@Name nvarchar(50),
	@FirstLastName [nvarchar](50),
	@SecondLastName [nvarchar](50),
	@DateOfBirth [date],
	@Curp [nvarchar](18),
	@Ssn [nvarchar](10),
	@Phone [numeric](18, 0),
	@Nationality [nvarchar](50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Employee] ([Name], FirstLastName, SecondLastName, DateOfBirth, Curp, Ssn, Phone, Nationality) VALUES
		(@Name,
		@FirstLastName,
		@SecondLastName,
		@DateOfBirth,
		@Curp,
		@Ssn,
		@Phone,
		@Nationality)
	
	DECLARE @Id INT
	SET @Id = SCOPE_IDENTITY();

	EXEC [dbo].[GetEmployee] @Id = @Id

	
END
GO
/****** Object:  StoredProcedure [dbo].[AttachBeneficiaryToEmployee]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	AttachBeneficiaryToEmployee
-- =============================================
CREATE PROCEDURE [dbo].[AttachBeneficiaryToEmployee] (
	@EmployeeId int,
	@BeneficiaryId int,
	@Percentage int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[EmployeeBeneficiary] (EmployeeId, BeneficiaryId, [Percentage]) VALUES
		(@EmployeeId, @BeneficiaryId, @Percentage)

	
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteBeneficiary]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	DeleteBeneficiary
-- =============================================
CREATE PROCEDURE [dbo].[DeleteBeneficiary] (
	@Id INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM [dbo].[EmployeeBeneficiary]
	WHERE
		BeneficiaryId = @Id

    -- Insert statements for procedure here
	DELETE FROM [dbo].[Beneficiary]
	WHERE
		Id = @Id

	
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	DeleteEmployee
-- =============================================
CREATE PROCEDURE [dbo].[DeleteEmployee] (
	@Id INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[EmployeeBeneficiary]	
	WHERE
		EmployeeId = @Id

	DELETE FROM [dbo].[Employee]	
	WHERE
		Id = @Id

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetBeneficiaries]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	GetBeneficiaries
-- =============================================
CREATE PROCEDURE [dbo].[GetBeneficiaries] 	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		Id,
		[Name],
		FirstLastName,
		SecondLastName,
		DateOfBirth,
		Curp,
		Ssn,
		Phone,
		Nationality
	FROM [dbo].[Beneficiary]

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetBeneficiariesByEmployee]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	GetBeneficiariesByEmployee
-- =============================================
CREATE PROCEDURE [dbo].[GetBeneficiariesByEmployee] (
	@EmployeeId INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		b.Id,
		b.[Name],
		b.FirstLastName,
		b.SecondLastName,
		b.DateOfBirth,
		b.Curp,
		b.Ssn,
		b.Phone,
		b.Nationality,
		eb.[Percentage]
	FROM [dbo].[Beneficiary] b
	JOIN [dbo].[EmployeeBeneficiary] eb
	ON
		b.Id = eb.BeneficiaryId
	WHERE
		eb.EmployeeId = @EmployeeId

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetBeneficiary]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	GetBeneficiary
-- =============================================
CREATE PROCEDURE [dbo].[GetBeneficiary] (
	@Id INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		Id,
		[Name],
		FirstLastName,
		SecondLastName,
		DateOfBirth,
		Curp,
		Ssn,
		Phone,
		Nationality
	FROM [dbo].[Beneficiary]
	WHERE
		Id = @Id

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetEmployee]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	GetEmployee
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployee] (
	@Id INT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		Id,
		[Name],
		FirstLastName,
		SecondLastName,
		DateOfBirth,
		Curp,
		Ssn,
		Phone,
		Nationality
	FROM [dbo].[Employee]
	WHERE
		Id = @Id

	
END
GO
/****** Object:  StoredProcedure [dbo].[GetEmployees]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	GetEmployees
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployees] 	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		Id,
		[Name],
		FirstLastName,
		SecondLastName,
		DateOfBirth,
		Curp,
		Ssn,
		Phone,
		Nationality
	FROM [dbo].[Employee]

	
END
GO
/****** Object:  StoredProcedure [dbo].[RemoveAllBeneficiariesByEmployee]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	RemoveAllBeneficiariesByEmployee
-- =============================================
CREATE PROCEDURE [dbo].[RemoveAllBeneficiariesByEmployee] (
	@EmployeeId int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[EmployeeBeneficiary] 
	WHERE 
		EmployeeId= @EmployeeId
		

	
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateBeneficiary]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	UpateBeneficiary
-- =============================================
CREATE PROCEDURE [dbo].[UpdateBeneficiary] (
	@Id int,
	@Name nvarchar(50),
	@FirstLastName [nvarchar](50),
	@SecondLastName [nvarchar](50),
	@DateOfBirth [date],
	@Curp [nvarchar](18),
	@Ssn [nvarchar](10),
	@Phone [numeric](18, 0),
	@Nationality [nvarchar](50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Beneficiary] SET
		[Name] = @Name,
		FirstLastName = @FirstLastName,
		SecondLastName = @SecondLastName,
		DateOfBirth = @DateOfBirth,
		Curp = @Curp,
		Ssn = @Ssn,
		Phone = @Phone, 
		Nationality = @Nationality
	WHERE
		Id = @Id
	
	EXEC [dbo].[GetBeneficiary] @Id = @Id

	
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 8/6/2024 12:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Fabricio Ruiz
-- Create date: 05/08/24
-- Description:	UpdateEmployee
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEmployee] (
	@Id int,
	@Name nvarchar(50),
	@FirstLastName [nvarchar](50),
	@SecondLastName [nvarchar](50),
	@DateOfBirth [date],
	@Curp [nvarchar](18),
	@Ssn [nvarchar](10),
	@Phone [numeric](18, 0),
	@Nationality [nvarchar](50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Employee] SET
		[Name] = @Name,
		FirstLastName = @FirstLastName,
		SecondLastName = @SecondLastName,
		DateOfBirth = @DateOfBirth,
		Curp = @Curp,
		Ssn = @Ssn,
		Phone = @Phone, 
		Nationality = @Nationality
	WHERE
		Id = @Id
	
	EXEC [dbo].[GetEmployee] @Id = @Id

	
END
GO
USE [master]
GO
ALTER DATABASE [MaxiDB] SET  READ_WRITE 
GO
