
USE master
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ZQGameUserDB')
DROP DATABASE [ZQGameUserDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ZQTreasureDB')
DROP DATABASE [ZQTreasureDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ZQServerInfoDB')
DROP DATABASE [ZQServerInfoDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ZQGameScoreDB')
DROP DATABASE [ZQGameScoreDB]
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ZQEducateDB')
DROP DATABASE [ZQEducateDB]

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ZQGameMatchDB')
DROP DATABASE [ZQGameMatchDB]

GO
