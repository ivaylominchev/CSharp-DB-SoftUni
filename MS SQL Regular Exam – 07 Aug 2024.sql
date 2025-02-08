CREATE DATABASE [ShoesApplicationDatabase]

GO

USE [ShoesApplicationDatabase]

GO

--Problem 01
CREATE TABLE [Users](
	[Id] INT PRIMARY KEY IDENTITY,
	[Username] NVARCHAR(50) UNIQUE NOT NULL,
	[FullName] NVARCHAR(100) NOT NULL,
	[PhoneNumber] NVARCHAR(15),
	[Email] NVARCHAR(100) UNIQUE NOT NULL
)

CREATE TABLE [Brands](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE [Sizes](
	[Id] INT PRIMARY KEY IDENTITY,
	[EU] DECIMAL(5,2) NOT NULL,
	[US] DECIMAL(5,2) NOT NULL,
	[UK] DECIMAL(5,2) NOT NULL,
	[CM] DECIMAL(5,2) NOT NULL,
	[IN] DECIMAL(5,2) NOT NULL
)

CREATE TABLE [Shoes](
	[Id] INT PRIMARY KEY IDENTITY,
	[Model] NVARCHAR(30) NOT NULL,
	[Price] DECIMAL(10, 2) NOT NULL,
	[BrandId] INT FOREIGN KEY REFERENCES [Brands]([Id]) NOT NULL
)

CREATE TABLE [Orders](
	[Id] INT PRIMARY KEY IDENTITY,
	[ShoeId] INT FOREIGN KEY REFERENCES [Shoes]([Id]) NOT NULL,
	[SizeId] INT FOREIGN KEY REFERENCES [Sizes]([Id]) NOT NULL,
	[UserId] INT FOREIGN KEY REFERENCES [Users]([Id]) NOT NULL
)

CREATE TABLE [ShoesSizes](
	[ShoeId] INT FOREIGN KEY REFERENCES [Shoes]([Id]) NOT NULL,
	[SizeId] INT FOREIGN KEY REFERENCES [Sizes]([Id]) NOT NULL,
	PRIMARY KEY ([ShoeId], [SizeId])
)

--Problem 02
INSERT INTO [Brands]([Name])
     VALUES ('Timberland'),
            ('Birkenstock')

INSERT INTO [Shoes]([Model], [Price], [BrandId])
     VALUES ('Reaxion Pro', 150.00, 12),
            ('Laurel Cort Lace-Up', 160.00, 12),
            ('Perkins Row Sandal', 170.00, 12),
            ('Arizona', 80.00, 13),
            ('Ben Mid Dip', 85.00, 13),
            ('Gizeh', 90.00, 13)

INSERT INTO [ShoesSizes]([ShoeId], [SizeId])
     VALUES (70, 1),
            (70, 2),
            (70, 3),
            (71, 2),
            (71, 3),
            (71, 4),
            (72, 4),
            (72, 5),
            (72, 6),
			(73, 1),
            (73, 3),
            (73, 5),
            (74, 2),
            (74, 4),
            (74, 6),
            (75, 1),
            (75, 2),
            (75, 3)

INSERT INTO [Orders]([ShoeId], [SizeId], [UserId])
     VALUES (70, 2, 15),
            (71, 3, 17),
            (72, 6, 18),
            (73, 5, 4),
            (74, 4, 7),
            (75, 1, 11)

--Problem 03
UPDATE [Shoes]
   SET [Price] *= 1.15
 WHERE [BrandId] IN (
                       SELECT [Id]
                         FROM [Brands]
                        WHERE [Name] = 'Nike'
                    )

--Problem 04
DELETE
  FROM [Orders]
 WHERE [ShoeId] IN (
                     SELECT [Id]
                       FROM [Shoes]
                      WHERE [Model] = 'Joyride Run Flyknit'
				   )

DELETE
  FROM [ShoesSizes]
 WHERE [ShoeId] IN (
                     SELECT [Id]
                       FROM [Shoes]
                      WHERE [Model] = 'Joyride Run Flyknit'
                   )

DELETE
  FROM [Shoes]
 WHERE [Model] = 'Joyride Run Flyknit'

--Problem 05
    SELECT [s].[Model]
        AS [ShoeModel],
           [s].[Price]
      FROM [Orders]
        AS [o]
INNER JOIN [Shoes]
        AS [s]
        ON [o].[ShoeId] = [s].[Id]
  ORDER BY [s].[Price] DESC,
           [s].[Model] ASC

--Problem 06
    SELECT [b].[Name]
        AS [BrandName],
           [s].[Model]
        AS [ShoeModel]
      FROM [Shoes]
        AS [s]
INNER JOIN [Brands]
        AS [b]
        ON [s].[BrandId] = [b].[Id]
  ORDER BY [b].[Name] ASC,
           [s].[Model] ASC

--Problem 07
    SELECT 
       TOP (10)
           [u].[Id]
        AS [UserId],
           [u].[FullName],
           SUM([s].[Price])
        AS [TotalSpent]
      FROM [Orders]
        AS [o]
INNER JOIN [Users]
        AS [u]
        ON [o].[UserId] = [u].[Id]
INNER JOIN [Shoes]
        AS [s]
        ON [o].[ShoeId] = [s].[Id]
  GROUP BY [u].[Id],
           [u].[FullName]
  ORDER BY [TotalSpent] DESC,
           [u].[FullName] ASC

--Problem 08
    SELECT [u].[Username],
           [u].[Email],
           CONVERT(DECIMAL(10, 2), AVG([s].[Price]))
        AS [AvgPrice]
      FROM [Orders]
        AS [o]
INNER JOIN [Users]
        AS [u]
        ON [o].[UserId] = [u].[Id]
INNER JOIN [Shoes]
        AS [s]
        ON [o].[ShoeId] = [s].[Id]
  GROUP BY [u].[Username],
           [u].[Email]
    HAVING COUNT(*) > 2
  ORDER BY [AvgPrice] DESC

