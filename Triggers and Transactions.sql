USE [Bank]

--Problem 01
CREATE TABLE [Logs](
	[LogId] INT PRIMARY KEY IDENTITY,
	[AccountId] INT NOT NULL,
	[OldSum] MONEY NOT NULL,
	[NewSum] MONEY NOT NULL
)

GO

 CREATE
     OR
  ALTER
TRIGGER [tr_AddToLogsOnAccountUpdate]
     ON [Accounts]
    FOR UPDATE
     AS 
        INSERT INTO [Logs]([AccountId], [OldSum], [NewSum])
		     SELECT [i].[AccountHolderId],
                    [d].[Balance],
                    [i].[Balance]
               FROM [inserted]
                 AS [i]
               JOIN [deleted]
                 AS [d]
                 ON [i].[Id] = [d].[Id]
              WHERE [i].[Balance] != [d].[Balance]

GO

--Problem 02
CREATE TABLE [NotificationEmails](
	[Id] INT PRIMARY KEY IDENTITY NOT NULL,
	[Recipient] VARCHAR(60) NOT NULL,
	[Subject] NVARCHAR(100) NOT NULL,
	[Body] NVARCHAR(200) NOT NULL
)

GO

 CREATE
     OR
  ALTER
TRIGGER [tr_AddToNotificationEmailsOnLogsInsert]
     ON [Logs] 
    FOR INSERT
     AS 
        INSERT INTO [NotificationEmails]([Recipient], [Subject], [Body])
        SELECT [i].[AccountId],
               'Balance change for account: ' + CONVERT(NVARCHAR,[i].[AccountId]),
			   'On ' + CONVERT(NVARCHAR,GETDATE()) + ' your balance was changed from ' + CONVERT(NVARCHAR,[i].[OldSum]) +  ' to ' + CONVERT(NVARCHAR,[i].[NewSum]) + '.'
          FROM [inserted] 
            AS [i]
GO

UPDATE [Accounts]
SET [Balance] = 123.12
WHERE [Id] = 1

