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

