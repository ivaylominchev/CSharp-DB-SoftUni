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

--Problem 08
    SELECT [ep].[EmployeeID],
           [e].[FirstName],
           CASE
                WHEN DATEPART(YEAR, [p].[StartDate]) >= 2005 THEN NULL
                ELSE [p].[Name]
           END
        AS [ProjectName]
      FROM [EmployeesProjects]
        AS [ep]
INNER JOIN [Employees]
        AS [e]
        ON [ep].[EmployeeID] = [e].[EmployeeID]
INNER JOIN [Projects]
        AS [p]
        ON [ep].[ProjectID] = [p].[ProjectID]
     WHERE [ep].[EmployeeID] = 24

--Problem 09
   SELECT [e1].[EmployeeID],
          [e1].[FirstName],
          [e1].[ManagerID],
          [e2].[FirstName]
     FROM [Employees]
       AS [e1]
LEFT JOIN [Employees]
       AS [e2]
       ON [e1].[ManagerID] = [e2].[EmployeeID]
    WHERE [e1].[ManagerID] IN (3, 7)
 ORDER BY [e1].[EmployeeID] ASC

 --Problem 10
   SELECT
      TOP (50)
          [e1].[EmployeeID],
          CONCAT_WS (' ', [e1].[FirstName], [e1].[LastName])
	   AS [EmployeeName],
          CONCAT_WS (' ', [e2].[FirstName], [e2].[LastName])
       AS [ManagerName],
          [d].[Name]
       AS [DepartmentName]
     FROM [Employees]
       AS [e1]
LEFT JOIN [Employees]
       AS [e2]
       ON [e1].[ManagerID] = [e2].[EmployeeID]
LEFT JOIN [Departments]
       AS [d]
       ON [e1].[DepartmentID] = [d].[DepartmentID]
 ORDER BY [e1].[EmployeeID] ASC

--Problem 11
SELECT MIN([a].[AverageSalary])
    AS [MinAverageSalary]
  FROM (
          SELECT [e].[DepartmentID],
                 AVG([e].[Salary])
              AS [AverageSalary]
            FROM [Employees]
              AS [e]
        GROUP BY [e].[DepartmentID]
       )
    AS [a]

USE [Geography]
--Problem 12
   SELECT [mc].[CountryCode],
          [m].[MountainRange],
          [p].[PeakName],
          [p].[Elevation]
     FROM [MountainsCountries]
       AS [mc]
LEFT JOIN [Mountains]
       AS [m]
       ON [mc].[MountainId] = [m].[Id]
LEFT JOIN [Peaks]
       AS [p]
       ON [m].[Id] = [p].[MountainId]
    WHERE [mc].[CountryCode] = 'BG' AND [p].[Elevation] > 2835
 ORDER BY [p].[Elevation] DESC

 --Problem 13
   SELECT [c].[CountryCode],
          COUNT([mc].[MountainId])
       AS [MountainRanges]
     FROM [Countries]
       AS [c]
LEFT JOIN [MountainsCountries]
       AS [mc]
       ON [mc].[CountryCode] = [c].[CountryCode]
    WHERE [c].[CountryCode] IN ('US', 'RU', 'BG')
 GROUP BY [c].[CountryCode]

 --Problem 14
   SELECT 
      TOP (5)
          [c].[CountryName],
          [r].[RiverName]
     FROM [Countries]
       AS [c]
LEFT JOIN [CountriesRivers]
       AS [cr]
       ON [c].[CountryCode] = [cr].[CountryCode]
LEFT JOIN [Rivers]
       AS [r]
       ON [cr].[RiverId] = [r].[Id]
    WHERE [c].[ContinentCode] = 'AF'
 ORDER BY [c].[CountryName] ASC

 --Problem 15
  SELECT [ContinentCode],
         [CurrencyCode],
         [CurrencyUsage]
    FROM (
           SELECT *,
                  DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC)
               AS [Rank]
             FROM (
                    SELECT [cn].[ContinentCode],
                           [c].[CurrencyCode],
                           COUNT([c].[CurrencyCode])
                        AS [CurrencyUsage]
                      FROM [Continents] 
                        AS [cn]
                 LEFT JOIN [Countries] 
                        AS [c]
                        ON [cn].[ContinentCode] = [c].[ContinentCode]
                  GROUP BY [cn].[ContinentCode], 
                           [c].[CurrencyCode]
                    HAVING COUNT([c].[CurrencyCode]) > 1
                  )
               AS [CurrencyUsageTempTable]
         )
      AS [CurrencyRankingTempTable]
   WHERE [Rank] = 1
ORDER BY [ContinentCode] ASC

