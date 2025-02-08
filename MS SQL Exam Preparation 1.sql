CREATE DATABASE [LibraryDb]

GO

USE [LibraryDb]

GO
--Problem 01
CREATE TABLE [Genres](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE [Contacts](
	[Id] INT PRIMARY KEY IDENTITY,
	[Email] NVARCHAR(100),
	[PhoneNumber] NVARCHAR(20),
	[PostAddress] NVARCHAR(200),
	[Website] NVARCHAR(50)
)

CREATE TABLE [Libraries](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	[ContactId] INT FOREIGN KEY REFERENCES [Contacts]([Id]) NOT NULL
)

CREATE TABLE [Authors](
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	[ContactId] INT FOREIGN KEY REFERENCES [Contacts]([Id]) NOT NULL
)


CREATE TABLE [Books](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Title] NVARCHAR(100) NOT NULL,
	[YearPublished] INT NOT NULL,
	[ISBN] NVARCHAR(13) UNIQUE NOT NULL,
	[AuthorId] INT FOREIGN KEY REFERENCES [Authors]([Id]) NOT NULL,
	[GenreId] INT FOREIGN KEY REFERENCES [Genres]([Id]) NOT NULL
)

CREATE TABLE [LibrariesBooks](
	[LibraryId] INT FOREIGN KEY REFERENCES [Libraries]([Id]) NOT NULL,
	[BookId] INT FOREIGN KEY REFERENCES [Books]([Id]) NOT NULL,
	PRIMARY KEY ([LibraryId], [BookId])
)

--Problem 02
INSERT INTO [Contacts]([Email], [PhoneNumber], [PostAddress], [Website])
     VALUES (NULL, NULL, NULL, NULL),
            (NULL, NULL, NULL, NULL),
            ('stephen.king@example.com', '+4445556666', '15 Fiction Ave, Bangor, ME', 'www.stephenking.com'),
			('suzanne.collins@example.com', '+7778889999', '10 Mockingbird Ln, NY, NY', 'www.suzannecollins.com')


INSERT INTO [Authors]([Name], [ContactId])
     VALUES ('George Orwell', 21),
            ('Aldous Huxley', 22),
            ('Stephen King', 23),
            ('Suzanne Collins', 24)

INSERT INTO [Books]([Title], [YearPublished], [ISBN], [AuthorId], [GenreId])
     VALUES ('1984', 1949, '9780451524935', 16, 2),
            ('Animal Farm', 1945, '9780451526342', 16, 2),
            ('Brave New World', 1932, '9780060850524', 17, 2),
            ('The Doors of Perception', 1954, '9780060850531', 17, 2),
            ('The Shining', 1977, '9780307743657', 18, 9),
            ('It', 1986, '9781501142970', 18, 9),
            ('The Hunger Games', 2008, '9780439023481', 19, 7),
            ('Catching Fire', 2009, '9780439023498', 19, 7),
            ('Mockingjay', 2010, '9780439023511', 19, 7)

INSERT INTO [LibrariesBooks]([LibraryId], [BookId])
     VALUES (1, 36),
            (1, 37),
            (2, 38),
            (2, 39),
            (3, 40),
            (3, 41),
            (4, 42),
			(4, 43),
            (5, 44)

--Problem 03
    UPDATE [c]
       SET [c].[Website] = CONCAT('www.', REPLACE(LOWER([a].[Name]), ' ', ''), '.com')
      FROM [Contacts] AS [c]
INNER JOIN [Authors] AS [a]
        ON [a].[ContactId] = [c].[Id]
     WHERE [c].[Website] IS NULL


--Problem 04
DELETE
  FROM [LibrariesBooks]
 WHERE [BookId] IN (
                    SELECT [Id]
                      FROM [Books]
                     WHERE [AuthorId] IN (
                                         SELECT [Id]
                                           FROM [Authors]
                                          WHERE [Name] = 'Alex Michaelides'
                                         )
                  )

DELETE
  FROM [Books]
 WHERE [AuthorId] IN (
                      SELECT [Id]
                        FROM [Authors]
                       WHERE [Name] = 'Alex Michaelides'
					  )

DELETE
  FROM [Authors]
 WHERE [Name] = 'Alex Michaelides'

--    SELECT [b].[Id]
--      FROM [Books] AS [b]
--INNER JOIN [Authors] AS [a]
--        ON [b].[AuthorId] = [a].[Id]
--     WHERE [a].[Name] = 'Alex Michaelides'

 --Problem 05
  SELECT [Title]
      AS [Book Title],
         [ISBN],
         [YearPublished]
      AS [YearReleased]
    FROM [Books]
ORDER BY [YearPublished] DESC,
         [Title] ASC

--Problem 06
    SELECT [b].[Id],
           [b].[Title],
           [b].[ISBN],
           [g].[Name]
        AS [Genre]
      FROM [Books]
        AS [b]
INNER JOIN [Genres]
        AS [g]
        ON [b].[GenreId] = [g].[Id]
     WHERE [g].[Name] IN ('Biography', 'Historical Fiction')
  ORDER BY [g].[Name] ASC,
           [b].[Title] ASC

--Problem 07
   SELECT [L].[Name]
       AS [Library],
          [c].[Email]
     FROM [Libraries]
       AS [L]
LEFT JOIN [Contacts]
       AS [c]
       ON [L].[ContactId] = [c].[Id] 
    WHERE [L].[Id] NOT IN (
                            SELECT [LB].[LibraryId]
                              FROM [LibrariesBooks]
                                AS [LB]
                         LEFT JOIN [Books]
                                AS [b]
                                ON [LB].[BookId] = [b].[Id]
                             WHERE [b].[GenreId] IN (
                                                     SELECT [Id]
                                                       FROM [Genres]
                                                      WHERE [Name] = 'Mystery'
                                                    )
                          )
 GROUP BY [L].[Name],
          [c].[Email]
 ORDER BY [L].[Name] ASC

--Problem 08
    SELECT 
       TOP (3)
           [b].[Title],
           [b].[YearPublished]
        AS [Year],
           [g].[Name]
        AS [Genre]
      FROM [Books]
        AS [b]
INNER JOIN [Genres]
        AS [g]
        ON [b].[GenreId] = [g].[Id]
     WHERE ([b].[YearPublished] > 2000 AND [b].[Title] LIKE '%a%')
           OR
           ([b].[YearPublished] < 1950 AND [g].[Name] LIKE '%Fantasy%')
  ORDER BY [b].[Title] ASC,
           [YearPublished] DESC

--Problem 09
    SELECT [a].[Name]
        AS [Author],
           [c].[Email],
           [c].[PostAddress]
        AS [Address]
      FROM [Authors]
        AS [a]
INNER JOIN [Contacts]
        AS [c]
        ON [a].[ContactId] = [c].[Id]
     WHERE [c].[PostAddress] LIKE '%UK%'
  ORDER BY [a].[Name] ASC

