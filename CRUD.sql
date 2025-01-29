USE SoftUni

--Task 2
SELECT * FROM [Departments]

--Task 3
SELECT [Name]
  FROM [Departments]

--Task 4
SELECT [FirstName], 
       [LastName],
	   [Salary]
  FROM [Employees]

--Task 5
SELECT [FirstName],
       [MiddleName],
	   [LastName]
  FROM [Employees]

--Task 6
SELECT CONCAT([FirstName],'.', [LastName], '@softuni.bg')
	AS [Full Email Address]
  FROM [Employees]

--Task 7
SELECT DISTINCT [Salary]
		     AS [Salary]
           FROM [Employees]

--Task 8
SELECT *
  FROM [Employees]
 WHERE [JobTitle] = 'Sales Representative'

--Task 9
SELECT [FirstName],
       [LastName],
       [JobTitle]
  FROM [Employees]
 WHERE [Salary] BETWEEN 20000 AND 30000

--Task 10
SELECT CONCAT_WS(' ', [FirstName], [MiddleName], [LastName])
	AS [Full Name]
  FROM [Employees]
 WHERE [Salary] IN (25000, 14000, 12500, 23600)

--Task 11
SELECT [FirstName],
	   [LastName]
  FROM [Employees]
 WHERE [ManagerID] IS NULL

--Task 12
SELECT [FirstName],
       [LastName],
       [Salary]
  FROM [Employees]
 WHERE [Salary] > 50000
 ORDER BY [Salary] DESC

--Task 13
SELECT TOP(5) [FirstName],
              [LastName]
         FROM [Employees]
     ORDER BY [Salary] DESC

--Task 14
SELECT [FirstName],
       [LastName]
  FROM [Employees]
 WHERE [DepartmentID] != 4