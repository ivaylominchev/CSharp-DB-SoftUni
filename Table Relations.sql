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

   ALTER TABLE [Persons]
ADD CONSTRAINT [UQ_Person_PassportID] UNIQUE([PassportID])
--Task 2

CREATE TABLE [Manufacturers](
	[ManufacturerID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	[EstablishedOn] DATETIME2
)

CREATE TABLE [Models](
	[ModelID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	[ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers]([ManufacturerID])
)

INSERT INTO [Manufacturers]([ManufacturerID], [Name], [EstablishedOn])
	 VALUES (1, 'BMW', '07/03/1916'),
	        (2, 'Tesla', '01/01/2003'),
	        (3, 'Lada', '01/05/1966')

INSERT INTO [Models]([ModelID], [Name], [ManufacturerID])
     VALUES (101, 'X1', 1),
			(102, 'i6', 1),
			(103, 'Model S', 2),
			(104, 'Model X', 2),
			(105, 'Model 3', 2),
			(106, 'Nova', 3)

--Task 3
CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(64)
)

CREATE TABLE [Exams](
	[ExamID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(64)
)

CREATE TABLE [StudentsExams](
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[ExamID] INT FOREIGN KEY REFERENCES [Exams]([ExamID]),
	CONSTRAINT [PK_StudentsExams] PRIMARY KEY ([StudentID], [ExamID])
)

INSERT INTO [Students]([StudentID], [Name])
     VALUES (1, 'Mila'),
	        (2, 'Toni'),
	        (3, 'Ron')

INSERT INTO [Exams]([ExamID], [Name])
     VALUES (101, 'SpringMVC'),
	        (102, 'Neo4j'),
	        (103, 'Oracle 11g')

INSERT INTO [StudentsExams]([StudentID], [ExamID])
     VALUES (1, 101),
			(1, 102),
			(2, 101),
			(3, 103),
			(2, 102),
			(2, 103)

--Task 4
CREATE TABLE [Teachers](
	[TeacherID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(64) NOT NULL,
	[ManagerID] INT FOREIGN KEY REFERENCES [Teachers]([TeacherID])
)

INSERT INTO [Teachers]([TeacherID], [Name], [ManagerID])
     VALUES (101, 'John', NULL),
	        (102, 'Maya', 106),
			(103, 'Silvia', 106),
			(104, 'Ted', 105),
			(105, 'Mark', 101),
			(106, 'Greta', 101)

--Task 5
CREATE TABLE [Cities](
	[CityID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(100) NOT NULL
)

CREATE TABLE [Customers](
	[CustomerID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(100) NOT NULL,
	[Birthday] DATETIME2,
	[CityID] INT FOREIGN KEY REFERENCES [Cities]([CityID])
)

CREATE TABLE [Orders](
	[OrderID] INT PRIMARY KEY NOT NULL,
	[CustomerID] INT FOREIGN KEY REFERENCES [Customers]([CustomerID])
)

CREATE TABLE [ItemTypes](
	[ItemTypeID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(100) NOT NULL
)

CREATE TABLE [Items](
	[ItemID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(100) NOT NULL,
	[ItemTypeID] INT FOREIGN KEY REFERENCES [ItemTypes]([ItemTypeID])
)

CREATE TABLE [OrderItems](
	[OrderID] INT FOREIGN KEY REFERENCES [Orders]([OrderID]),
	[ItemID] INT FOREIGN KEY REFERENCES [Items]([ItemID]),
	CONSTRAINT [PK_OrderItems] PRIMARY KEY([OrderID], [ItemID])
)


--Task 6
CREATE DATABASE [University]
USE [University]

CREATE TABLE [Majors](
	[MajorID] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(64) NOT NULL
)

CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY NOT NULL,
	[StudentNumber] INT NOT NULL,
	[StudentName] VARCHAR(64) NOT NULL,
	[MajorID] INT FOREIGN KEY REFERENCES [Majors]([MajorID])
)

CREATE TABLE [Payments](
	[PaymentID] INT PRIMARY KEY NOT NULL,
	[PaymentDate] DATETIME2,
	[PaymentAmount] DECIMAL(18,2),
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID])
)

CREATE TABLE [Subjects](
	[SubjectID] INT PRIMARY KEY NOT NULL,
	[SubjectName] VARCHAR(64) NOT NULL
)

CREATE TABLE [Agenda](
	[StudentID] INT FOREIGN KEY REFERENCES [Students]([StudentID]),
	[SubjectID] INT FOREIGN KEY REFERENCES [Subjects]([SubjectID]),
	CONSTRAINT [PK_Agenda] PRIMARY KEY ([StudentID], [SubjectID])
)


--Task 9
USE [Geography]

  SELECT M.[MountainRange], P.[PeakName], P.[Elevation]
    FROM [Mountains] AS M JOIN [Peaks] AS P
	  ON P.MountainId = M.Id
   WHERE M.[MountainRange] = 'Rila'
ORDER BY P.[Elevation] DESC