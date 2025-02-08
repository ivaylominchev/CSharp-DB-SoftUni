USE [SoftUni]

--Task 1
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [FirstName] LIKE 'Sa%'

 --Task 2
 SELECT [FirstName],
        [LastName]
   FROM [Employees]
  WHERE [LastName] LIKE '%ei%'

--Task 3
SELECT [FirstName]
  FROM [Employees]
 WHERE [DepartmentID] IN(3, 10) AND 
       DATEPART(YEAR, [HireDate]) BETWEEN 1995 AND 2005

--Task 4
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE CHARINDEX('engineer', [JobTitle]) = 0

--Task 5
  SELECT [Name]
    FROM [Towns]
   WHERE LEN([Name]) IN(5, 6)
ORDER BY [Name] ASC

--Task 6
  SELECT *
    FROM [Towns]
   WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name] ASC

--Task 7
  SELECT *
    FROM [Towns]
   WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name] ASC

--Task8
CREATE VIEW [V_EmployeesHiredAfter2000]
	     AS (
			  SELECT [FirstName],
                     [LastName]
                FROM [Employees]
               WHERE DATEPART(YEAR, [HireDate]) > 2000
		    )

--Task 9
SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE LEN([LastName]) = 5

--Task 10
  SELECT [EmployeeID],
         [FirstName],
         [Lastname],
	     [Salary],
	     DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
	  AS [Rank]
    FROM [Employees]
   WHERE [Salary] BETWEEN 10000 AND 50000
ORDER BY [Salary] DESC

--Task 11
  SELECT *
    FROM (	
	      SELECT [EmployeeID],
	             [FirstName],
                 [Lastname],
                 [Salary],
                 DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID])
              AS [Rank]
            FROM [Employees]
	     )
      AS [e]
   WHERE [Salary] BETWEEN 10000 AND 50000 AND [e].[Rank] = 2
ORDER BY [Salary] DESC

--Task 12
USE [Geography]

  SELECT [CountryName] AS [Country Name],
         [IsoCode] AS [ISO Code]
    FROM [Countries]
   WHERE [CountryName] LIKE '%a%a%a%'
ORDER BY [IsoCode]

--Task 13 I
  SELECT [p].[PeakName],
         [r].[RiverName],
	     LOWER(CONCAT(SUBSTRING([p].[PeakName], 1, LEN([p].[PeakName]) - 1), [r].[RiverName]))
	  AS [Mix]
    FROM [Peaks]
      AS [p]
    JOIN [Rivers]
      AS [r] 
	  ON RIGHT([p].[PeakName], 1) = LEFT([r].[RiverName], 1)
ORDER BY [Mix]

--Task 13 II
  SELECT [p].[PeakName],
         [r].[RiverName],
		 LOWER(CONCAT(SUBSTRING([p].[PeakName], 1, LEN([p].[PeakName]) - 1), [r].[RiverName]))
	  AS [Mix]
    FROM [Peaks]
      AS [p],
	     [Rivers]
	  AS [r]
   WHERE RIGHT([p].[PeakName], 1) = LEFT([r].[RiverName], 1)
ORDER BY [Mix] ASC

USE [Diablo]
--Task 14
SELECT TOP(50) [Name],
               FORMAT([Start],'yyyy-MM-dd')
			AS [Start]
          FROM [Games]
		 WHERE DATEPART(YEAR, [Start]) IN(2011, 2012)
	  ORDER BY [Start] ASC,
	           [Name] ASC

--Task 15
  SELECT [Username],
         SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email])-LEN(CHARINDEX('@', [Email])))
      AS [Email Provider]
    FROM [Users]
ORDER BY [Email Provider] ASC,
         [Username] ASC

--Task 16
  SELECT [Username],
         [IpAddress]
      AS [IP Address]
    FROM [Users]
   WHERE PATINDEX('___.1%.%.___', [IpAddress]) = 1
ORDER BY [Username] ASC

--Task 17
  SELECT [g].[Name]
      AS [Game],
	     CASE
              WHEN DATEPART(HOUR, [g].[Start]) BETWEEN 0 AND 11 THEN 'Morning'
              WHEN DATEPART(HOUR, [g].[Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
              ELSE 'Evening'
          END
      AS [Part of the Day],
         CASE
              WHEN [g].[Duration] <= 3 THEN 'Extra Short'
              WHEN [g].[Duration] BETWEEN 4 AND 6 THEN 'Short'
              WHEN [g].[Duration] > 6 THEN 'Long'
              ELSE 'Extra Long'
          END
      AS [Duration]
    FROM [Games]
      AS [g]
ORDER BY [Game] ASC,
         [Duration] ASC,
         [Part of the Day] ASC

--Task 18
USE [Orders]

SELECT [ProductName],
       [OrderDate],
	   DATEADD(DAY, 3, [OrderDate])
    AS [Pay Due],
       DATEADD(MONTH, 1, [OrderDate])
    AS [Deliver Due]
  FROM [Orders]

--Task 19

CREATE TABLE [People](
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(60),
    [Birthdate] DATETIME2
)

INSERT INTO [People]([Name], [Birthdate])
     VALUES ('Victor', '2000-12-07 00:00:00.000'),
            ('Steven', '1992-09-10 00:00:00.000'),
            ('Stephen', '1910-09-19 00:00:00.000'),
            ('John', '2010-01-06 00:00:00.000')

SELECT [Name],
       DATEDIFF(YEAR, [Birthdate], GETDATE())
    AS [Age in Years],
       DATEDIFF(MONTH, [Birthdate], GETDATE())
    AS [Age in Months],
       DATEDIFF(DAY, [Birthdate], GETDATE())
    AS [Age in Days],
       DATEDIFF(MINUTE, [Birthdate], GETDATE())
    AS [Age in Minutes]
  FROM [People]