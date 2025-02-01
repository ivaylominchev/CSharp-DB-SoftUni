GO

USE [SoftUni]

GO

--Problem 01
    SELECT
       TOP (5)
           [e].[EmployeeID],
           [e].[JobTitle],
           [e].[AddressID],
           [a].[AddressText]
      FROM [Employees]
        AS [e]
INNER JOIN [Addresses]
        AS [a] 
        ON [e].[AddressID] = [a].[AddressID]
  ORDER BY [e].[AddressID] ASC

--Problem 02
    SELECT 
       TOP (50)
           [e].[FirstName],
           [e].[LastName],
           [t].[Name]
        AS [Town],
           [a].[AddressText]
      FROM [Employees]
        AS [e]
INNER JOIN [Addresses]
        AS [a] 
        ON [e].[AddressID] = [a].[AddressID]
INNER JOIN [Towns]
        AS [t]
        ON [a].[TownID] = [t].[TownID]
  ORDER BY [e].[FirstName] ASC,
           [e].[LastName] ASC

--Problem 03
    SELECT [e].[EmployeeID],
           [e].[FirstName],
           [e].[LastName],
           [d].[Name]
        AS [DepartmentName]
      FROM [Employees]
        AS [e]
INNER JOIN [Departments]
        AS [d]
        ON [e].[DepartmentID] = [d].[DepartmentID]
     WHERE [d].[Name] = 'Sales'
  ORDER BY [e].[EmployeeID] ASC

--Problem 04
    SELECT
       TOP (5)
           [e].[EmployeeID],
           [e].[FirstName],
           [e].[Salary],
           [d].[Name]
        AS [DepartmentName]
      FROM [Employees]
        AS [e]
INNER JOIN [Departments]
        AS [d]
        ON [e].[DepartmentID] = [d].[DepartmentID]
     WHERE [e].[Salary] > 15000
  ORDER BY [e].[DepartmentID] ASC

--Problem 05
   SELECT 
      TOP (3)
          [e].[EmployeeID],
          [e].[FirstName]
     FROM [Employees]
       AS [e]
LEFT JOIN [EmployeesProjects]
       AS [ep]
       ON [ep].[EmployeeID] = [e].[EmployeeID]
    WHERE [ep].[ProjectID] IS NULL
 ORDER BY [e].[EmployeeID] ASC

--Problem 06
    SELECT [e].[FirstName],
           [e].[LastName],
           [e].[HireDate],
           [d].[Name]
        AS [DeptName]
      FROM [Employees]
        AS [e]
INNER JOIN [Departments]
        AS [d]
        ON [e].[DepartmentID] = [d].[DepartmentID]
     WHERE [e].[HireDate] > '1999-01-01' AND [d].[Name] IN ('Sales', 'Finance')
  ORDER BY [e].[HireDate] ASC

--Problem 07
    SELECT
       TOP (5)
           [ep].[EmployeeID],
           [e].[FirstName],
           [p].[Name]
        AS [ProjectName]
      FROM [EmployeesProjects]
        AS [ep]
INNER JOIN [Employees]
        AS [e]
        ON [ep].[EmployeeID] = [e].[EmployeeID]
INNER JOIN [Projects]
        AS [p]
        ON [ep].[ProjectID] = [p].[ProjectID]
     WHERE [p].[StartDate] > '08/13/2002'
       AND [p].[EndDate] IS NULL
  ORDER BY [ep].[EmployeeID] ASC

