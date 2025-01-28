--Exercise 01
CREATE DATABASE [Minions]

--Exercise 02
USE Minions
CREATE TABLE [Minions](	
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Age] INT
)

CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(85) NOT NULL
)

--Exercise 03
ALTER TABLE [Minions]
ADD [TownId] INT 

ALTER TABLE [Minions]
ADD CONSTRAINT [FK_Minions_Towns_Id]
FOREIGN KEY ([TownId]) REFERENCES [Towns]([Id])


--Exercise 04
INSERT INTO [Towns]([Id],[Name])
	 VALUES (1, 'Sofia'),
			(2, 'Plovdiv'),
			(3, 'Varna')

INSERT INTO [Minions]([Id], [Name], [Age], [TownId])
	 VALUES (1, 'Kevin', 22, 1),
			(2, 'Bob', 15, 3),
			(3, 'Steward', NULL, 2)


--Exercise 05
TRUNCATE TABLE [Minions]


--Exercise 06
DROP TABLE [Minions]
DROP TABLE [Towns]


--Exercise 07
CREATE TABLE [People](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY(MAX),
	[Height] DECIMAL(18,2),
	[Weight] DECIMAL(18,2),
	[Gender] NCHAR(1) NOT NULL,
	[Birthdate] DATETIME2 NOT NULL,
	[Biography] NVARCHAR(MAX)
)

INSERT INTO [People]([Name], [Picture], [Height], [Weight], [Gender], [Birthdate], [Biography])
VALUES ('Ivan', NULL, 1.86, 77, 'm', '12/10/2003', 'description'),
	   ('Gosho', NULL, 1.76, 65, 'm', '1/6/2002', 'description'),
	   ('Geri', NULL, 1.66, 55, 'f', '6/4/2003', 'description'),
	   ('Ivo', NULL, 1.76, 69, 'm', '1/6/2003', 'description'),
	   ('Niki', NULL, 1.68, 50, 'm', '1/7/2001', 'description')