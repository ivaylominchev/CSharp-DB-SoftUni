CREATE DATABASE [EuroLeagues]

GO

USE [EuroLeagues]

GO

--Problem 01
CREATE TABLE [Leagues](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Teams](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) UNIQUE NOT NULL,
	[City] NVARCHAR(50) NOT NULL,
	[LeagueId] INT FOREIGN KEY REFERENCES [Leagues]([Id]) NOT NULL
)

CREATE TABLE [Players](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	[Position] NVARCHAR(20) NOT NULL
)

CREATE TABLE [Matches](
	[Id] INT PRIMARY KEY IDENTITY,
	[HomeTeamId] INT FOREIGN KEY REFERENCES [Teams]([Id]) NOT NULL,
	[AwayTeamId] INT FOREIGN KEY REFERENCES [Teams]([Id]) NOT NULL,
	[MatchDate] DATETIME2 NOT NULL,
	[HomeTeamGoals] INT DEFAULT 0 NOT NULL,
	[AwayTeamGoals] INT DEFAULT 0 NOT NULL,
	[LeagueId] INT FOREIGN KEY REFERENCES [Leagues]([Id]) NOT NULL
)

CREATE TABLE [PlayersTeams](
	[PlayerId] INT FOREIGN KEY REFERENCES [Players]([Id]) NOT NULL,
	[TeamId] INT FOREIGN KEY REFERENCES [Teams]([Id]) NOT NULL,
	PRIMARY KEY ([PlayerId], [TeamId])
)

CREATE TABLE [PlayerStats](
	[PlayerId] INT FOREIGN KEY REFERENCES [Players]([Id]) NOT NULL,
	[Goals] INT DEFAULT 0 NOT NULL,
	[Assists] INT DEFAULT 0 NOT NULL,
	PRIMARY KEY ([PlayerId])

)

CREATE TABLE [TeamStats](
	[TeamId] INT FOREIGN KEY REFERENCES [Teams]([Id]) NOT NULL,
	[Wins] INT DEFAULT 0 NOT NULL,
	[Draws] INT DEFAULT 0 NOT NULL,
	[Losses] INT DEFAULT 0 NOT NULL,
	PRIMARY KEY ([TeamId])
)

--Problem 02
INSERT INTO [Leagues]([Name])
     VALUES ('Eredivisie')

INSERT INTO [Teams]([Name], [City], [LeagueId])
     VALUES ('PSV', 'Eindhoven', 6),
            ('Ajax', 'Amsterdam', 6)

INSERT INTO [Players]([Name], [Position])
     VALUES ('Luuk de Jong', 'Forward'),
            ('Josip Sutalo', 'Defender')

INSERT INTO [Matches]([HomeTeamId], [AwayTeamId], [MatchDate], [HomeTeamGoals], [AwayTeamGoals], [LeagueId])
     VALUES (98, 97, '2024-11-02 20:45:00', 3, 2, 6)

INSERT INTO [PlayersTeams]([PlayerId], [TeamId])
     VALUES (2305, 97),
            (2306, 98)

INSERT INTO [PlayerStats]([PlayerId], [Goals], [Assists])
     VALUES (2305, 2, 0),
            (2306, 2, 0)

INSERT INTO [TeamStats]([TeamId], [Wins], [Draws], [Losses])
     VALUES (97, 15, 1, 3),
            (98, 14, 3, 2)

--Problem 03
    UPDATE [ps]
       SET [ps].[Goals] += 1
      FROM [PlayerStats] AS [ps]
INNER JOIN [Players] AS [p]
        ON [ps].[PlayerId] = [p].[Id]
INNER JOIN [PlayersTeams] AS [pt]
        ON [p].[Id] = [pt].[PlayerId]
INNER JOIN [Teams] AS [t]
        ON [t].[Id] = [pt].[TeamId]
INNER JOIN [Leagues] AS [L]
        ON [t].[LeagueId] = [L].[Id]
     WHERE [p].[Position] = 'Forward' AND [L].[Name] = 'La Liga'

--Problem 04
DELETE
  FROM [PlayerStats]
 WHERE [PlayerId] IN (
                      SELECT [p].[Id]
                        FROM [Players] 
                          AS [p]
                  INNER JOIN [PlayersTeams] 
                          AS [pt] 
                          ON [pt].[PlayerId] = [p].[Id]
                  INNER JOIN [Teams] 
                          AS [t]
                          ON [pt].[TeamId] = [t].[Id]
                  INNER JOIN [Leagues] 
                          AS [L]
                          ON [t].[LeagueId] = [L].[Id]
                       WHERE [L].[Name] = 'Eredivisie' AND [p].[Name] IN ('Luuk de Jong', 'Josip Sutalo')
);

DELETE 
  FROM [PlayersTeams]
 WHERE [PlayerId] IN (
                      SELECT P.[Id]
                        FROM [Players] 
                          AS [p]
                  INNER JOIN [PlayersTeams] 
                          AS [pt]
                          ON [pt].[PlayerId] = [p].[Id]
                  INNER JOIN [Teams]
                          AS [t]
                          ON [pt].[TeamId] = [t].[Id]
                  INNER JOIN [Leagues]
                          AS [L]
                          ON [t].[LeagueId] = [L].[Id]
                       WHERE [L].[Name] = 'Eredivisie' AND [p].[Name] IN ('Luuk de Jong', 'Josip Sutalo')
);

    DELETE [p]
      FROM [Players] 
        AS [p]
INNER JOIN [PlayersTeams] 
        AS [pt] 
        ON [pt].[PlayerId] = [p].[Id]
INNER JOIN [Teams] 
        AS [t] 
        ON [pt].[TeamId] = [t].[Id]
INNER JOIN [Leagues] 
        AS [L] 
        ON [t].[LeagueId] = [L].[Id]
 LEFT JOIN [PlayerStats] 
        AS [ps] 
        ON [ps].[PlayerId] = [p].[Id]
     WHERE [L].[Name] = 'Eredivisie'
       AND [p].[Name] IN ('Luuk de Jong', 'Josip Sutalo');

--Problem 05
  SELECT FORMAT([MatchDate], 'yyyy-MM-dd')
      AS [MatchDate],
         [HomeTeamGoals],
         [AwayTeamGoals],
         [HomeTeamGoals] + [AwayTeamGoals]
      AS [TotalGoals]
    FROM [Matches]
   WHERE ([HomeTeamGoals] + [AwayTeamGoals]) >= 5
ORDER BY [TotalGoals] DESC,
         [MatchDate] ASC

--Problem 06
    SELECT [p].[Name],
           [t].[City]
      FROM [Players] 
        AS [p]
INNER JOIN [PlayersTeams] 
        AS [pt]
        ON [p].[Id] = [pt].[PlayerId]
INNER JOIN [Teams] 
        AS [t]
        ON [pt].[TeamId] = [t].[Id]
     WHERE [p].[Name] LIKE '%Aaron%'
  ORDER BY [p].[Name] ASC

--Problem 07
    SELECT [p].[Id],
           [p].[Name],
           [p].[Position]
      FROM [Players] 
        AS [p]
INNER JOIN [PlayersTeams] 
        AS [pt]
        ON [p].[Id] = [pt].[PlayerId]
INNER JOIN [Teams] 
        AS [t]
        ON [pt].[TeamId] = [t].[Id]
     WHERE [t].[City] = 'London'
  ORDER BY [p].[Name] ASC

--Problem 08
    SELECT
       TOP (10)
           [t].[Name]
        AS [HomeTeamName],
           [t2].[Name]
        AS [AwayTeamName],
           [L].[Name]
        AS [LeagueName],
           FORMAT([m].[MatchDate], 'yyyy-MM-dd')
        AS [MatchDate]
      FROM [Matches]
        AS [m]
INNER JOIN [Teams]
        AS [t]
        ON [m].[HomeTeamId] = [t].[Id]
INNER JOIN [Teams]
        AS [t2]
        ON [t2].[Id] = [m].[AwayTeamId]
INNER JOIN [Leagues]
        AS [L]
        ON [L].[Id] = [t].[LeagueId]
     WHERE [m].[MatchDate] BETWEEN '2024-09-01' AND '2024-09-15' AND [L].[Id] % 2 = 0
  ORDER BY [m].[MatchDate] ASC,
           [HomeTeamName] ASC

--Problem 09
    SELECT [m].[AwayTeamId]
        AS [Id],
           [t].[Name],
           SUM([m].[AwayTeamGoals])
        AS [TotalAwayGoals]
      FROM [Matches]
        AS [m]
INNER JOIN [Leagues]
        AS [L]
        ON [m].[LeagueId] = [L].[Id]
INNER JOIN [Teams]
        AS [t]
        ON [m].[AwayTeamId] = [t].[Id]
  GROUP BY [m].[AwayTeamId],
           [t].[Name]
    HAVING SUM([m].[AwayTeamGoals]) >= 6
  ORDER BY [TotalAwayGoals] DESC,
           [t].[Name] ASC

--Problem 10
    SELECT [L].[Name]
        AS [LeagueName],
           ROUND(AVG(CAST(([m].[HomeTeamGoals] + [m].[AwayTeamGoals]) AS FLOAT)), 2)
        AS [AvgScoringRate]
      FROM [Matches]
        AS [m]
INNER JOIN [Leagues]
        AS [L]
        ON [m].[LeagueId] = [L].[Id]
  GROUP BY [L].[Name]
  ORDER BY [AvgScoringRate] DESC

GO

--Problem 11
CREATE FUNCTION [dbo].[udf_LeagueTopScorer](@nameLeague NVARCHAR(50))
RETURNS TABLE AS
 RETURN (
         SELECT [PlayerName],
                [TotalGoals]
           FROM (
                  SELECT [p].[Name] 
                      AS [PlayerName],
                         [ps].[Goals] 
                      AS [TotalGoals],
                         DENSE_RANK() OVER(PARTITION BY [L].[Id] ORDER BY [ps].[Goals] DESC)
                      AS [RANKS]
                    FROM [Players] 
                      AS [p]
              INNER JOIN [PlayerStats] 
                      AS [ps]
                      ON [p].[Id] = [ps].[PlayerId]
              INNER JOIN [PlayersTeams] 
                      AS [pt]
                      ON [p].[Id] = [pt].[PlayerId]
              INNER JOIN [Teams] 
                      AS [t]
                      ON [pt].[TeamId] = [t].[Id]
              INNER JOIN [Leagues] 
                      AS [L]
                      ON [L].[Id] = [t].[LeagueId]
                   WHERE [L].[Name] = @nameLeague
                )
             AS [RankingTempTable]
          WHERE [RANKS] = '1'
       )

GO

