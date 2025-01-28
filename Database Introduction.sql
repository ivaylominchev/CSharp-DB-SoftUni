--Exercise 01
CREATE DATABASE [Minions]

--Exercise 02
USE Minions
CREATE TABLE [Minions]
(	
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[Age] INT
)

CREATE TABLE [Towns]
(
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

