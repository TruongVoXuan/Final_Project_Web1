USE dbWheyShop
GO

/****** Object:  Table [dbo].[Roles] ******/
CREATE TABLE [dbo].[Roles] (
    [RoleID] [int] IDENTITY(1,1) NOT NULL,
    [RoleName] nvarchar(50) NULL,
    [Description] nvarchar(50) NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleID] ASC)
) ON [PRIMARY];
GO

/****** Object:  Table [dbo].[Orders] ******/
CREATE TABLE [dbo].[Orders] (
    [OrderID] [int] IDENTITY(1,1) NOT NULL,
    [CustomerID] [int] NULL,
    [OrderDate] [datetime] NULL,
    [ShipDate] [datetime] NULL,
    [TransactStatusID] [int] NULL,
    [Deleted] [bit] NULL,
    [Paid] [bit] NULL,
    [PaymentDate] [datetime] NULL,
    [PaymentID] [int] NULL,
    [Note] nvarchar NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC)
) ON [PRIMARY];
GO

/****** Object:  Table [dbo].[Account] ******/
CREATE TABLE [dbo].[Account] (
    [AccountID] [int] IDENTITY(1,1) NOT NULL,
    [Phone] varchar(12) NULL,
    [Email] nvarchar(50) NULL,
    [Password] nvarchar(50) NULL,
    [UpSecurity] nchar(10) NULL,
    [Active] [bit] NOT NULL,
    [FullName] nvarchar(150) NULL,
    [RoleID] [int] NULL,
    [LastLogin] [datetime] NULL,
    [CreateDate] [datetime] NULL,
    CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED ([AccountID] ASC)
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Account] ADD CONSTRAINT [FK_Account_Roles]
FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID]);
GO

/****** Object:  Table [dbo].[OrderDetails] ******/
CREATE TABLE [dbo].[OrderDetails] (
    [OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
    [OrderID] [int] NULL,
    [ProductID] [int] NULL,
    [OrderNumber] [int] NULL,
    [Quantity] [int] NULL,
    [Discount] [int] NULL,
    [Total] [int] NULL,
    [ShipDate] [datetime] NULL,
    CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED ([OrderDetailID] ASC)
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Orders]
FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]);
GO

/****** Object:  Table [dbo].[Categories] ******/
CREATE TABLE [dbo].[Categories] (
    [CatID] [int] IDENTITY(1,1) NOT NULL,
    [CatName] nvarchar(250) NULL,
    [Description] nvarchar(MAX) NULL,
    [ParentID] [int] NULL,
    [Levels] [int] NULL,
    [Ordering] [int] NULL,
    [Published] [bit] NOT NULL,
    [Thumb] nvarchar(250) NULL,
    [Title] nvarchar(250) NULL,
    [Alias] nvarchar(250) NULL,
    [MetaDesc] nvarchar(250) NULL,
    [MetaKey] nvarchar(250) NULL,
    [Cover] nvarchar(250) NULL,
    [SchemaMarkup] nvarchar(MAX) NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CatID] ASC)
) ON [PRIMARY];
GO

/****** Object:  Table [dbo].[Customers] ******/
CREATE TABLE [dbo].[Customers] (
    [CustomerID] [int] IDENTITY(1,1) NOT NULL,
    [FullName] nvarchar(255) NULL,
    [BirthDay] [datetime] NULL,
    [Avatar] nvarchar(255) NULL,
    [Address] nvarchar(255) NULL,
    [Email] nchar(150) NULL,
    [Phone] varchar(12) NULL,
    [LocationID] [int] NULL,
    [District] [int] NULL,
    [Ward] [int] NULL,
    [CreateDate] [datetime] NULL,
    [Password] nvarchar(50) NULL,
    [UpSecurity] nchar(10) NULL,
    [LastLogin] [datetime] NULL,
    [Active] [bit] NOT NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Customers]
FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]);
GO

/****** Object:  Table [dbo].[Locations] ******/
CREATE TABLE [dbo].[Locations] (
    [LocationID] [int] IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(100) NULL,
    [Type] nvarchar(20) NULL,
    [Slug] nvarchar(100) NULL,
    [NameWithType] nvarchar(255) NULL,
    [PathWithType] nvarchar(255) NULL,
    [ParentCode] [int] NULL,
    [Levels] [int] NULL,
    CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED ([LocationID] ASC)
) ON [PRIMARY];
GO

/****** Object:  Table [dbo].[Products] ******/
CREATE TABLE [dbo].[Products] (
    [ProductID] [int] IDENTITY(1,1) NOT NULL,
    [ProductName] nvarchar(255) NOT NULL,
    [ShortDesc] nvarchar(255) NULL,
    [Description] nvarchar(MAX) NULL,
    [CatID] [int] NULL,
    [Price] [int] NULL,
    [Discount] [int] NULL,
    [Thumb] nvarchar(255) NULL,
    [Video] nvarchar(255) NULL,
    [DateCreated] [datetime] NULL,
    [DateModified] [datetime] NULL,
    [BestSellers] [bit] NOT NULL,
    [HomeFlag] [bit] NOT NULL,
    [Active] [bit] NOT NULL,
    [Tags] nvarchar(MAX) NULL,
    [Title] nvarchar(255) NULL,
    [Alias] nvarchar(255) NULL,
    [MetaDesc] nvarchar(255) NULL,
    [MetaKey] nvarchar(255) NULL,
    [UnitsInStock] [int] NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID] ASC)
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_Products_Categories]
FOREIGN KEY ([CatID]) REFERENCES [dbo].[Categories] ([CatID]);
GO

/****** Object:  Table [dbo].[TransactStatus] ******/
CREATE TABLE [dbo].[TransactStatus] (
    [TransactStatusID] [int] IDENTITY(1,1) NOT NULL,
    [Status] nvarchar(50) NULL,
    [Description] nvarchar(MAX) NULL,
    CONSTRAINT [PK_TransactStatus] PRIMARY KEY CLUSTERED ([TransactStatusID] ASC)
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_TransactStatus]
FOREIGN KEY ([TransactStatusID]) REFERENCES [dbo].[TransactStatus] ([TransactStatusID]);
GO

/****** Object:  Table [dbo].[tblTinTucs] ******/
CREATE TABLE [dbo].[tblTinTucs] (
    [PostID] [int] IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(255) NULL,
    [SContents] nvarchar(255) NULL,
    [Contents] nvarchar(MAX) NULL,
    [Thumb] nvarchar(255) NULL,
    [Published] [bit] NOT NULL,
    [Alias] nvarchar(255) NULL,
    [CreateDate] [datetime] NULL,
    [Author] nvarchar(255) NULL,
    [AccountID] [int] NULL,
    [Tags] nvarchar(MAX) NULL,
    [CatID] [int] NULL,
    [isHot] [bit] NULL,
    [isNewfeed] [bit] NULL,
    [MetaKey] nvarchar(255) NULL,
    [MetaDesc] nvarchar(255) NULL,
    [Views] [int] NULL,
    CONSTRAINT [PK_tblTinTucs] PRIMARY KEY CLUSTERED ([PostID] ASC)
) ON [PRIMARY];
GO

ALTER TABLE [dbo].[tblTinTucs] ADD CONSTRAINT [FK_tblTinTucs_Categories]
FOREIGN KEY ([CatID]) REFERENCES [dbo].[Categories] ([CatID]);
GO

/****** Object:  Table [dbo].[Pages] ******/
CREATE TABLE [dbo].[Pages] (
    [PageID] [int] IDENTITY(1,1) NOT NULL,
    [PageName] nvarchar(250) NULL,
    [Contents] nvarchar(MAX) NULL,
    [Thumb] nvarchar(250) NULL,
    [Published] [bit] NOT NULL,
    [Title] nvarchar(250) NULL,
    [MetaDesc] nvarchar(250) NULL,
    [MetaKey] nvarchar(250) NULL,
    [Alias] nvarchar(250) NULL,
    [CreatedDate] [datetime] NULL,
	 [Ordering] [int] NULL,
    CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED ([PageID] ASC)
) ON [PRIMARY];
GO

/****** Object:  Table [dbo].[Shippers] ******/
CREATE TABLE [dbo].[Shippers] (
    [ShipperID] [int] IDENTITY(1,1) NOT NULL,
    [ShipperName] nvarchar(150) NULL,
    [Phone] nchar(10) NULL,
    [Company] nvarchar(150) NULL,
    [ShipDate] [datetime] NULL,
    CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ([ShipperID] ASC)
) ON [PRIMARY];
GO
