CREATE DATABASE [Table Relations]
USE [Table Relations]

--Task 1
CREATE TABLE [Persons](
	[PersonID] INT NOT NULL,
	[FirstName] VARCHAR(50) NOT NULL,
	[Salary] DECIMAL(18,2),
	[PassportID] INT
)

CREATE TABLE [Passports](
	[PassportID] INT NOT NULL,
	[PassportNumber] VARCHAR(50) UNIQUE
)

INSERT INTO [Persons]([PersonID], [FirstName], [Salary], [PassportID])
     VALUES (1, 'Roberto', 43300, 102),
			(2, 'Tom', 56100, 103),
			(3, 'Yana', 60200, 101)

INSERT INTO [Passports]([PassportID],[PassportNumber])
     VALUES (101, 'N34FG21B'),
	        (102, 'K65LO4R7'),
	        (103, 'ZE657QP2')


   ALTER TABLE [Persons]
ADD CONSTRAINT [PK_Persons_PersonID]
   PRIMARY KEY ([PersonID])

   ALTER TABLE [Passports]
ADD CONSTRAINT [PK_Passports_PassportID]
   PRIMARY KEY ([PassportID])

   ALTER TABLE [Persons]
ADD CONSTRAINT [FK_Persons_Passports_PassportID]
   FOREIGN KEY ([PassportID]) 
    REFERENCES [Passports]([PassportID])