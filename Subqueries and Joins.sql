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

