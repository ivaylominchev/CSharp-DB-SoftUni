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

