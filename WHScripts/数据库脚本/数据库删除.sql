
USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'WHGameUserDB')
DROP DATABASE [WHGameUserDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'WHTreasureDB')
DROP DATABASE [WHTreasureDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'WHServerInfoDB')
DROP DATABASE [WHServerInfoDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'WHGameScoreDB')
DROP DATABASE [WHGameScoreDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'WHEducateDB')
DROP DATABASE [WHEducateDB]

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'WHGameMatchDB')
DROP DATABASE [WHGameMatchDB]

GO
