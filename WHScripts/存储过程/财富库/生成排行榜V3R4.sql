
USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteRanking]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteRanking]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 生成排行榜
CREATE PROC GSP_GR_WriteRanking
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 清除旧数据
	TRUNCATE TABLE GameScoreRanking
	
	--RankingStatus为1时是参加排行
	INSERT INTO GameScoreRanking(UserID, Score, RankingStatus) SELECT TOP 50 UserID, Score, RankingStatus FROM GameScoreInfo where RankingStatus=1 ORDER BY Score DESC
	
	--实际的排行没有实质上的用处
	--INSERT INTO GameScoreRanking(UserID, Score) SELECT TOP 50 UserID, Score FROM GameScoreInfo ORDER BY Score DESC

	-- 更新昵称，性别
	UPDATE t SET t.NickName=u.RegAccounts,t.Gender=u.Gender, t.DescribeInfo=u.UnderWrite FROM GameScoreRanking as t,WHGameUserDB.dbo.AccountsInfo AS u WHERE  t.UserID=u.UserID

	--统计:1/2表示按自然天/最近的小时，1天，24小时
	EXEC dbo.GSP_GR_WriteStatistics 1,1,24
END

RETURN 0

GO