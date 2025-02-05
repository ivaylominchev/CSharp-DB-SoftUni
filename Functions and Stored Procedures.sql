USE [SoftUni]

GO

--Problem 01
CREATE OR ALTER PROCEDURE [dbo].[usp_GetEmployeesSalaryAbove35000]
AS (
     SELECT [FirstName]
         AS [First Name],
            [LastName]
         AS [Last Name]
       FROM [Employees]
      WHERE [Salary] > 35000
   )

GO

--Problem 02
CREATE OR ALTER PROCEDURE [dbo].[usp_GetEmployeesSalaryAboveNumber] @salary DECIMAL(18,4)
AS (
    SELECT [FirstName]
        AS [First Name],
           [LastName]
        AS [Last Name]
      FROM [Employees]
     WHERE [Salary] >= @salary
   )

GO

--Problem 03
   CREATE
       OR
    ALTER
PROCEDURE [dbo].[usp_GetTownsStartingWith] @string VARCHAR(50)
       AS (
           SELECT [Name]
               AS [Town]
             FROM [Towns]
            WHERE SUBSTRING([Name], 1 , LEN(@string)) = @string
          )

GO

EXEC [dbo].[usp_GetTownsStartingWith] 'nev'
