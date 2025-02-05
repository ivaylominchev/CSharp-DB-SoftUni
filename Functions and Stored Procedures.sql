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
            WHERE [Name] LIKE @string + '%'
          --WHERE SUBSTRING([Name], 1 , LEN(@string)) = @string
          )

GO

EXEC [dbo].[usp_GetTownsStartingWith] 'b'

GO

--Problem 04
   CREATE
       OR
    ALTER 
PROCEDURE [dbo].[usp_GetEmployeesFromTown] @townName VARCHAR(50)
       AS (
               SELECT [e].[FirstName]
                   AS [First Name],
                      [LastName]
                   AS [Last Name]
                 FROM [Employees]
                   AS [e]
            LEFT JOIN [Addresses]
                   AS [a]
                   ON [e].[AddressID] = [a].[AddressID]
            LEFT JOIN [Towns]
                   AS [t]
                   ON [t].[TownID] = [a].[TownID]
                WHERE [t].[Name] = @townName
          )

GO

EXEC [dbo].[usp_GetEmployeesFromTown] 'Sofia'

GO

--Problem 05
  CREATE
      OR
   ALTER
FUNCTION [dbo].[ufn_GetSalaryLevel](@Salary DECIMAL(18,4))
 RETURNS VARCHAR(10)
      AS
   BEGIN
         DECLARE @salaryLevel VARCHAR(10);
         IF(@Salary < 30000)
           SET @salaryLevel = 'Low'
         ELSE IF(@Salary <= 50000)
           SET @salaryLevel = 'Average'
         ELSE 
           SET @salaryLevel = 'High'

        RETURN @salaryLevel
     END;
GO

SELECT [FirstName],
       [Salary],
       [dbo].[ufn_GetSalaryLevel]([Salary])
    AS [Salary Level]
  FROM [Employees]

GO
 --Problem 06
   CREATE
       OR
    ALTER
PROCEDURE [dbo].[usp_EmployeesBySalaryLevel] @LevelOfSalary VARCHAR(10)
       AS (
             SELECT [FirstName],
                    [LastName]
               FROM [Employees]
              WHERE [dbo].[ufn_GetSalaryLevel]([Salary]) = @LevelOfSalary
          )

GO

EXEC [dbo].[usp_EmployeesBySalaryLevel] 'High'

GO
