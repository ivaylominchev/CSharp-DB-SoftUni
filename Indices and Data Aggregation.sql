GO

USE [Gringotts]

GO

--Problem 01
SELECT Count(*)
    AS [Count]
  FROM [WizzardDeposits]

--Problem 02
SELECT MAX([MagicWandSize])
    AS [LongestMagicWand]
  FROM [WizzardDeposits]

--Problem 03
  SELECT [DepositGroup],
         MAX([MagicWandSize])
      AS [LongestMagicWand]
    FROM [WizzardDeposits]
GROUP BY [DepositGroup]

