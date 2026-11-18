USE [de273101]
GO

--------------------------------------------------------------------------------
-- СОЗДАНИЕ ТАБЛИЦ (ЕСЛИ ОНИ ЕЩЕ НЕ СУЩЕСТВУЮТ)
--------------------------------------------------------------------------------

-- 1. Table [Category]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Category](
        [Name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
    (
        [Name] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

-- 2. Table [Sizes]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sizes]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Sizes](
        [Size] [varchar](5) NOT NULL,
    CONSTRAINT [PK_Sizes_import] PRIMARY KEY CLUSTERED 
    (
        [Size] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

-- 3. Table [Roles]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Roles](
        [RoleId] [int] IDENTITY(1,1) NOT NULL,
        [Name] [nvarchar](50) NOT NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
    (
        [RoleId] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

-- 4. Table [Roles2]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles2]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Roles2](
        [RoleId] [int] IDENTITY(1,1) NOT NULL,
        [Name] [nvarchar](50) NULL,
    CONSTRAINT [PK_Roles2] PRIMARY KEY CLUSTERED 
    (
        [RoleId] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

-- 5. Table [Users]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Users](
        [UserId] [int] IDENTITY(1,1) NOT NULL,
        [Surname] [nvarchar](50) NOT NULL,
        [Name] [nvarchar](50) NOT NULL,
        [Patronymic] [nvarchar](50) NOT NULL,
        [Login] [nvarchar](50) NOT NULL,
        [RoleId] [int] NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
    (
        [UserId] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

-- 6. Table [Products]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Products](
        [ProductId] [int] IDENTITY(1,1) NOT NULL,
        [Category] [nvarchar](50) NOT NULL,
        [Subcategory] [nvarchar](50) NOT NULL,
        [Image] [nvarchar](150) NOT NULL,
        [Name] [nvarchar](100) NOT NULL,
        [Manufacturer] [nvarchar](50) NOT NULL,
        [Description] [nvarchar](200) NOT NULL,
        [Materials] [nvarchar](200) NOT NULL,
        [Price] [smallint] NOT NULL,
    CONSTRAINT [PK_Products_import] PRIMARY KEY CLUSTERED 
    (
        [ProductId] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

-- 7. Table [Orders]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Orders](
        [OrderId] [tinyint] NOT NULL,
        [OrderDate] [date] NOT NULL,
        [UserId] [int] NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
    (
        [OrderId] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

-- 8. Table [Orders2]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders2]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Orders2](
        [Номер_заказа] [tinyint] NOT NULL,
        [Дата_заказа] [date] NOT NULL,
        [ФИО] [nvarchar](50) NOT NULL,
        [UserId] [int] NOT NULL
    ) ON [PRIMARY];
END
GO

-- 9. Table [OrderItems]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderItems]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[OrderItems](
        [OrderId] [tinyint] NOT NULL,
        [ProductId] [int] NOT NULL,
        [Size] [varchar](5) NOT NULL,
        [Amount] [tinyint] NOT NULL,
    CONSTRAINT [PK_OrderItems] PRIMARY KEY CLUSTERED 
    (
        [OrderId] ASC,
        [ProductId] ASC,
        [Size] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

-- 10. Table [StockItems]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StockItems]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[StockItems](
        [ProductId] [int] NOT NULL,
        [Size] [varchar](5) NOT NULL,
        [AvailableAmount] [tinyint] NOT NULL,
    CONSTRAINT [PK_StockItems] PRIMARY KEY CLUSTERED 
    (
        [ProductId] ASC,
        [Size] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY];
END
GO

--------------------------------------------------------------------------------
-- СОЗДАНИЕ ИНДЕКСОВ (ЕСЛИ ОНИ ЕЩЕ НЕ СУЩЕСТВУЮТ)
--------------------------------------------------------------------------------

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'UQ_Products_Title' AND object_id = OBJECT_ID(N'[dbo].[Products]'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [UQ_Products_Title] ON [dbo].[Products]([Name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY];
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'UQ_Roles_Name' AND object_id = OBJECT_ID(N'[dbo].[Roles]'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [UQ_Roles_Name] ON [dbo].[Roles]([Name] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY];
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'UQ_Users_Login' AND object_id = OBJECT_ID(N'[dbo].[Users]'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [UQ_Users_Login] ON [dbo].[Users]([Login] ASC)
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY];
END
GO

--------------------------------------------------------------------------------
-- СОЗДАНИЕ ВНЕШНИХ КЛЮЧЕЙ (FOREIGN KEYS) (ЕСЛИ ОНИ ЕЩЕ НЕ СУЩЕСТВУЮТ)
--------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = N'FK_OrderItems_Orders')
BEGIN
    ALTER TABLE [dbo].[OrderItems] WITH CHECK ADD CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([OrderId])
    REFERENCES [dbo].[Orders] ([OrderId]);
    ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders];
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = N'FK_OrderItems_Products')
BEGIN
    ALTER TABLE [dbo].[OrderItems] WITH CHECK ADD CONSTRAINT [FK_OrderItems_Products] FOREIGN KEY([ProductId])
    REFERENCES [dbo].[Products] ([ProductId]);
    ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Products];
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = N'FK_OrderItems_Sizes')
BEGIN
    ALTER TABLE [dbo].[OrderItems] WITH CHECK ADD CONSTRAINT [FK_OrderItems_Sizes] FOREIGN KEY([Size])
    REFERENCES [dbo].[Sizes] ([Size]);
    ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Sizes];
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = N'FK_Orders_Users')
BEGIN
    ALTER TABLE [dbo].[Orders] WITH CHECK ADD CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserId])
    REFERENCES [dbo].[Users] ([UserId]);
    ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users];
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = N'FK_Products_Category')
BEGIN
    ALTER TABLE [dbo].[Products] WITH CHECK ADD CONSTRAINT [FK_Products_Category] FOREIGN KEY([Category])
    REFERENCES [dbo].[Category] ([Name]);
    ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category];
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = N'FK_StockItems_Products')
BEGIN
    ALTER TABLE [dbo].[StockItems] WITH CHECK ADD CONSTRAINT [FK_StockItems_Products] FOREIGN KEY([ProductId])
    REFERENCES [dbo].[Products] ([ProductId]);
    ALTER TABLE [dbo].[StockItems] CHECK CONSTRAINT [FK_StockItems_Products];
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = N'FK_StockItems_Sizes')
BEGIN
    ALTER TABLE [dbo].[StockItems] WITH CHECK ADD CONSTRAINT [FK_StockItems_Sizes] FOREIGN KEY([Size])
    REFERENCES [dbo].[Sizes] ([Size]);
    ALTER TABLE [dbo].[StockItems] CHECK CONSTRAINT [FK_StockItems_Sizes];
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = N'FK_Users_Roles')
BEGIN
    ALTER TABLE [dbo].[Users] WITH CHECK ADD CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
    REFERENCES [dbo].[Roles] ([RoleId]);
    ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles];
END
GO

USE [master]
GO
ALTER DATABASE [de273101] SET READ_WRITE 
GO