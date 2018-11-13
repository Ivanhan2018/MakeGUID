use QPTreasureDB;
ALTER TABLE [dbo].GameScoreInfo ADD Experience [int] NOT NULL DEFAULT 0
ALTER TABLE [dbo].GameScoreInfo ADD Gems [int] NOT NULL DEFAULT 0
ALTER TABLE [dbo].GameScoreInfo ADD Grade [int] NOT NULL DEFAULT 0