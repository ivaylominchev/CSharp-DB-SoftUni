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

