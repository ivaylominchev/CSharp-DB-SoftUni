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


--Exercise 08
CREATE TABLE [Users](
	[Id] BIGINT PRIMARY KEY IDENTITY NOT NULL,
	[Username] VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY(MAX),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT
)

INSERT INTO [Users]([Username], [Password], [ProfilePicture], [LastLoginTime], [IsDeleted])
	 VALUES ('Ivo', '123456', NULL, GETDATE(), NULL),
	        ('Gosho', '12345', NULL, GETDATE(), NULL),
			('Geri', '1234', NULL, GETDATE(), NULL),
			('Niki', '123', NULL, GETDATE(), NULL),
			('Vlado', '12', NULL, GETDATE(), NULL)


--Exercise 09
ALTER TABLE [Users]
DROP CONSTRAINT [PK__Users__3214EC07AF944265]

ALTER TABLE [Users]
ADD CONSTRAINT [PK_Id_Username]
PRIMARY KEY ([Id],[Username])


--Exercise 10
ALTER TABLE [Users]
ADD CONSTRAINT [CK_Password_Min_Length_5]
CHECK(LEN([Password]) >= 5)


--Exercise 11
ALTER TABLE [Users]
ADD CONSTRAINT [DF_LastLoginTime_Current_time]
DEFAULT GETDATE() FOR [LastLoginTime]


--Exercise 12
ALTER TABLE [Users]
DROP CONSTRAINT [PK_Id_Username]

ALTER TABLE [Users]
ADD CONSTRAINT [PK_Id]
PRIMARY KEY ([Id])

ALTER TABLE [Users]
ADD UNIQUE ([Id])

--Exercise 13
CREATE DATABASE [Movies]

USE Movies

CREATE TABLE [Directors](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[DirectorName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(200)
)

CREATE TABLE [Genres](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[GenreName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(200)
)

CREATE TABLE [Categories](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[CategoryName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(200)
)

CREATE TABLE [Movies](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Title] NVARCHAR(50) NOT NULL,
	[DirectorId] INT FOREIGN KEY REFERENCES [Directors]([Id]),
	[CopyrightYear] CHAR(4) NOT NULL,
	[Length] NVARCHAR(20) NOT NULL,
	[GenreId] INT FOREIGN KEY REFERENCES [Genres]([Id]),
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),
	[Rating] NVARCHAR(20),
	[Notes] NVARCHAR(200)
)


INSERT INTO [Directors]([DirectorName], [Notes])
     VALUES ('David Fincher', 'Paul Thomas Anderson'),
			('John Ford', 'American film director and producer'),
			('Paul Thomas Anderson', 'American filmmaker'),
			('Ridley Scott', 'English film director and producer'),
			('Steven Spielberg', 'A major figure of the New Hollywood era')


INSERT INTO [Genres]([GenreName], [Notes])
	 VALUES ('Drama', NULL),
			('Comedy', NULL),
			('Fantasy', NULL),
			('Horror', NULL),
			('Action', NULL)


INSERT INTO [Categories]([CategoryName], [Notes])
	 VALUES ('Drama', NULL),
            ('Comedy', NULL),
			('Fantasy', NULL),
			('Horror', NULL),
			('Action', NULL)

INSERT INTO [Movies]([Title], [DirectorId], [CopyrightYear], [Length], [GenreId], [CategoryId], [Rating], [Notes])
	 VALUES ('The Godfather', 1 , '1972', '2 h 55 min', 1, 1, NULL, NULL),
			('The Lord of the Rings: The Fellowship of the Ring', 2 , '2001', ' 2 h 58 min', 2, 2, NULL, NULL),
			('12 Angry Men', 3 , '1957', '1 h 36 min', 3, 3, NULL, NULL),
			('Avatar', 4 , '2009', '2 h 42 min', 4, 4, NULL, NULL),
			('The Matrix', 5 , '1999', '2 h 16 min', 5, 5, NULL, NULL)


--Exercise 14

CREATE DATABASE [CarRental]

USE CarRental