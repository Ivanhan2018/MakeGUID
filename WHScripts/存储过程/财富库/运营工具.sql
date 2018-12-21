----------------------------------------------------------------------------------------------------

USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteStatistics]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteStatistics]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 生成统计数据
CREATE PROC GSP_GR_WriteStatistics
	@dwType INT,
	@dwDay INT,
	@dwHour INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @ID INT
DECLARE @Score BIGINT
DECLARE @BankScore BIGINT

DECLARE @RechargeAdd BIGINT
DECLARE @GmAdd BIGINT
DECLARE @ExchangeAdd BIGINT
DECLARE @SigninAdd BIGINT
DECLARE @AwardAdd BIGINT
DECLARE @NewerAdd BIGINT
DECLARE @WelfareAdd BIGINT
DECLARE @RevenueDel BIGINT
DECLARE @GmDel BIGINT

DECLARE @TotalAdd BIGINT
DECLARE @TotalDel BIGINT

-- 执行逻辑
BEGIN
	--统计今天金豆总剩余
	DECLARE @TheID INT
	SELECT @TheID=ID FROM GameDayStatistics(NOLOCK) WHERE Type=1 AND DATEDIFF(day,CollectDate,GETDATE())=0 
	IF @TheID IS NULL
	BEGIN
		DECLARE @TheTotalGold INT
		SELECT @TheTotalGold=SUM(Gold) FROM WHGameUserDB.dbo.UserExchangeInfo
		INSERT INTO GameDayStatistics(Type, Value) VALUES(1, @TheTotalGold)
	END

	-- 检查今天的数据
	SELECT @ID=ID FROM GameScoreStatistics WHERE DateDiff(dd, CollectDate, GetDate()) = 0
	-- 结果判断
	IF @ID IS NOT NULL
	BEGIN
		--今天有数据
		RETURN 1
	END

	--生成今天的数据
	--总财富
	SELECT @Score=sum(Score),@BankScore=sum(BankScore) FROM GameScoreInfo

	--充值
	IF @dwType = 1
	BEGIN
		SELECT @RechargeAdd=SUM(TotalScore) FROM WHGameUserDB.dbo.UserRechargeOrder WHERE States=1 AND RechargeDate > convert(varchar(10),getdate() - @dwDay,120) AND RechargeDate <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @RechargeAdd=SUM(TotalScore) FROM WHGameUserDB.dbo.UserRechargeOrder WHERE States=1 AND datediff(hour,RechargeDate,getdate()) <= @dwHour
	END
	IF @RechargeAdd IS NULL
	BEGIN
		SET @RechargeAdd = 0
	END
	
	--GM奖励
	IF @dwType = 1
	BEGIN
		SELECT @GmAdd=SUM(CAST(Params as int)) FROM WHGameUserDB.dbo.GMTaskLog WHERE TaskID=1 and status='成功' AND FinishDate > convert(varchar(10),getdate() - @dwDay,120) AND FinishDate <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @GmAdd=SUM(CAST(Params as int)) FROM WHGameUserDB.dbo.GMTaskLog WHERE TaskID=1 and status='成功'  AND datediff(hour,FinishDate,getdate()) <= @dwHour
	END
	IF @GmAdd IS NULL
	BEGIN
		SET @GmAdd = 0
	END

	--兑换
	IF @dwType = 1
	BEGIN
		SELECT @ExchangeAdd=SUM(TotalScore) FROM WHGameUserDB.dbo.UserExchgR WHERE Status='已发放' AND ExchangeDate > convert(varchar(10),getdate() - @dwDay,120) AND ExchangeDate <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @ExchangeAdd=SUM(TotalScore) FROM WHGameUserDB.dbo.UserExchgR WHERE Status='已发放'  AND datediff(hour,ExchangeDate,getdate()) <= @dwHour
	END
	IF @ExchangeAdd IS NULL
	BEGIN
		SET @ExchangeAdd = 0
	END

	--签到
	IF @dwType = 1
	BEGIN
		SELECT @SigninAdd=SUM(Score) FROM WHGameUserDB.dbo.UserScoreLog WHERE Type=1 and CollectDate > convert(varchar(10),getdate() - @dwDay,120) AND CollectDate <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @SigninAdd=SUM(Score) FROM WHGameUserDB.dbo.UserScoreLog WHERE Type=1 and datediff(hour,CollectDate,getdate()) <= @dwHour
	END
	IF @SigninAdd IS NULL
	BEGIN
		SET @SigninAdd = 0
	END


	--奖励任务
	IF @dwType = 1
	BEGIN
		SELECT @AwardAdd=SUM(Score) FROM WHGameUserDB.dbo.UserGetAward WHERE LatestDate > convert(varchar(10),getdate() - @dwDay,120) AND LatestDate <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @AwardAdd=SUM(Score) FROM WHGameUserDB.dbo.UserGetAward WHERE datediff(hour,LatestDate,getdate()) <= @dwHour
	END
	IF @AwardAdd IS NULL
	BEGIN
		SET @AwardAdd = 0
	END

	--新人
	IF @dwType = 1
	BEGIN
		SELECT @NewerAdd=count(*)*10000 FROM WHGameUserDB.dbo.AccountsInfo WHERE RegisterDate > convert(varchar(10),getdate() - @dwDay,120) AND RegisterDate <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @NewerAdd=count(*)*10000 FROM WHGameUserDB.dbo.AccountsInfo WHERE datediff(hour,RegisterDate,getdate()) <= @dwHour
	END
	IF @NewerAdd IS NULL
	BEGIN
		SET @NewerAdd = 0
	END

	--低保
	IF @dwType = 1
	BEGIN
		SELECT @WelfareAdd=SUM(Score) FROM WHGameUserDB.dbo.UserScoreLog WHERE Type=2 and CollectDate > convert(varchar(10),getdate() - @dwDay,120) AND CollectDate <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @WelfareAdd=SUM(Score) FROM WHGameUserDB.dbo.UserScoreLog WHERE Type=2 and datediff(hour,CollectDate,getdate()) <= @dwHour
	END
	IF @WelfareAdd IS NULL
	BEGIN
		SET @WelfareAdd = 0
	END

	--GM罚分
	IF @dwType = 1
	BEGIN
		SELECT @GmDel=SUM(CAST(Params as int)) FROM WHGameUserDB.dbo.GMTaskLog WHERE TaskID=6 and status='成功' AND FinishDate > convert(varchar(10),getdate() - @dwDay,120) AND FinishDate <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @GmDel=SUM(CAST(Params as int)) FROM WHGameUserDB.dbo.GMTaskLog WHERE TaskID=6 and status='成功'  AND datediff(hour,FinishDate,getdate()) <= @dwHour
	END
	IF @GmDel IS NULL
	BEGIN
		SET @GmDel = 0
	END

	--茶水
	IF @dwType = 1
	BEGIN
		SELECT @RevenueDel=SUM(Revenue) FROM WHTreasureDB.dbo.RecordUserLeave WHERE LeaveTime > convert(varchar(10),getdate() - @dwDay,120) and LeaveTime <convert(varchar(10),getdate(),120)
	END
	ELSE
	BEGIN
		SELECT @RevenueDel=SUM(Revenue) FROM WHTreasureDB.dbo.RecordUserLeave WHERE datediff(hour,LeaveTime,getdate()) <= @dwHour
	END
	IF @RevenueDel IS NULL
	BEGIN
		SET @RevenueDel = 0
	END

	--插入今天的数据
	SET @TotalAdd = @RechargeAdd + @GmAdd + @ExchangeAdd + @SigninAdd + @AwardAdd + @NewerAdd + @WelfareAdd
	SET @TotalDel = @RevenueDel + @GmDel
	INSERT INTO GameScoreStatistics(Total, TotalAdd, TotalDel, Score, BankScore, RechargeAdd, GmAdd, ExchangeAdd, SigninAdd, AwardAdd, NewerAdd, WelfareAdd, RevenueDel, GmDel) VALUES(@Score+@BankScore, @TotalAdd, @TotalDel, @Score, @BankScore, @RechargeAdd, @GmAdd, @ExchangeAdd, @SigninAdd, @AwardAdd, @NewerAdd, @WelfareAdd, @RevenueDel, @GmDel)
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

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
----------------------------------------------------------------------------------------------------

USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetRanking_V2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetRanking_V2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 读取排行榜
CREATE PROC GSP_GR_GetRanking_V2
	@dwUserID INT,								-- 用户 I D
	@nPage INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @MyRank INT
DECLARE @TheFirst INT
DECLARE @TheSQL	NVARCHAR(256)

-- 执行逻辑
BEGIN
	--SELECT @szDescribe=DescribeInfo FROM AccountsInfo WHERE UserID=@dwUserID AND RankingStatus=1
	SELECT @MyRank=ID FROM GameScoreRanking WHERE UserID=@dwUserID AND RankingStatus=1
	-- 结果判断
	IF @MyRank IS NULL
	BEGIN
		SET @MyRank = 0
	END
	
	-- 每页条
	set @TheFirst = 6*@nPage
	set @TheSQL=N'SELECT TOP 6 *,Convert(varchar(16),[CreateDate],120) AS D,'
				+convert(varchar(10),@MyRank)
				+N'AS Mine,(select count(*) from GameScoreRanking WHERE RankingStatus=1)AS T FROM GameScoreRanking WHERE(ID NOT IN(SELECT TOP '
				+convert(varchar(10),@theFirst)
				+N' ID FROM GameScoreRanking ORDER BY ID)) AND RankingStatus=1'

	exec sp_executesql @TheSQL; 
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetRanking]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetRanking]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 读取排行榜
CREATE PROC GSP_GR_GetRanking
	@dwUserID INT,								-- 用户 I D
	@nPage INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @MyRank INT
DECLARE @TheFirst INT
DECLARE @TheSQL	NVARCHAR(256)

-- 执行逻辑
BEGIN

	SELECT @MyRank=ID FROM GameScoreRanking WHERE UserID=@dwUserID AND RankingStatus=1
	-- 结果判断
	IF @MyRank IS NULL
	BEGIN
		SET @MyRank = 0
	END
	
	-- 每页条
	set @TheFirst = 6*@nPage
	set @TheSQL=N'SELECT TOP 6 *,Convert(varchar(16),[CreateDate],120) AS D,'
				+convert(varchar(10),@MyRank)
				+N'AS Mine,(select count(*) from GameScoreRanking WHERE RankingStatus=1)AS T FROM GameScoreRanking WHERE(ID NOT IN(SELECT TOP '
				+convert(varchar(10),@theFirst)
				+N' ID FROM GameScoreRanking ORDER BY ID)) AND RankingStatus=1'

	exec sp_executesql @TheSQL; 
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetUserRankingStatus]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetUserRankingStatus]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 读取玩家排行榜状态
CREATE PROC GSP_GR_GetUserRankingStatus
	@dwUserID INT								-- 用户 I D
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @TheRankingStatus INT

-- 执行逻辑
BEGIN
	SELECT @TheRankingStatus=RankingStatus FROM GameScoreInfo WHERE UserID=@dwUserID
	-- 结果判断
	IF @TheRankingStatus IS NULL
	BEGIN
		SET @TheRankingStatus = 1
	END

	SELECT @TheRankingStatus AS RS
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_ModifyRankingStatus]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_ModifyRankingStatus]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 设置是否入排行榜
CREATE PROC GSP_GR_ModifyRankingStatus
	@dwUserID INT,								-- 用户 I D
	@nRankingStatus INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	update GameScoreInfo set RankingStatus=@nRankingStatus
	where UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetTaskStat]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetTaskStat]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取玩家的任务统计数据
CREATE PROC GSP_GR_GetTaskStat
	@dwUserID INT								-- 用户 I D
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @WinToday3 INT
DECLARE @LostToday3 INT
DECLARE @WinTotal3 INT
DECLARE @LostTotal3 INT
DECLARE @WinToday4 INT
DECLARE @LostToday4 INT
DECLARE @WinTotal4 INT
DECLARE @LostTotal4 INT
DECLARE @AwardToday3 INT
DECLARE @AwardToday4 INT
DECLARE @AwardAll3 INT
DECLARE @AwardAll4 INT
DECLARE @TheDate NVARCHAR(31)

-- 执行逻辑
BEGIN
	--三人拱的盘数
	SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
	FROM GameToday WHERE UserID=@dwUserID and KindID=998
	-- 结果判断
	IF @WinToday3 IS NULL
	BEGIN
		SET @WinToday3 = 0
		SET @LostToday3 = 0
		SET @WinTotal3 = 0
		SET @LostTotal3 = 0
	END
	ELSE
	BEGIN
		IF @TheDate <> Convert(varchar(10),getDate(),120)
		BEGIN
			--不是今天
			SET @WinToday3 = 0
			SET @LostToday3 = 0
		END
	END

	--四人拱的盘数
	SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
	FROM GameToday WHERE UserID=@dwUserID and KindID=997
	-- 结果判断
	IF @WinToday4 IS NULL
	BEGIN
		SET @WinToday4 = 0
		SET @LostToday4 = 0
		SET @WinTotal4 = 0
		SET @LostTotal4 = 0
	END
	ELSE
	BEGIN
		IF @TheDate <> Convert(varchar(10),getDate(),120)
		BEGIN
			--不是今天
			SET @WinToday4 = 0
			SET @LostToday4 = 0
		END
	END

	--三人拱每日任务已领奖阶段
	SELECT @AwardToday3=count(*)
	FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
	WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

	--四人拱每日任务已领奖阶段
	SELECT @AwardToday4=count(*)
	FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
	WHERE UserID=@dwUserID and TaskID in (6,7,8) and datediff(day,[LatestDate],getdate())=0

	--三人拱系统任务已领奖阶段
	SELECT @AwardAll3=count(*)
	FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
	WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

	--四人拱系统任务已领奖阶段
	SELECT @AwardAll4=count(*)
	FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
	WHERE UserID=@dwUserID and TaskID >=30 and TaskID <=42 

	-- 输出变量
	SELECT @WinToday3 AS wtoday3, @LostToday3 AS ltoday3, @WinTotal3 AS wtotal3, @LostTotal3 AS ltotal3,
	@WinToday4 AS wtoday4, @LostToday4 AS ltoday4, @WinTotal4 AS wtotal4, @LostTotal4 AS ltotal4,
	@AwardToday3 AS atoday3, @AwardToday4 AS atoday4, @AwardAll3 AS atotal3, @AwardAll4 AS atotal4
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetTaskStat_v2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetTaskStat_v2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取玩家的任务统计数据
CREATE PROC GSP_GR_GetTaskStat_v2
	@dwUserID INT,				-- 用户 I D
	@strLoginServer NVARCHAR(15)		-- 登录服务器名称，用来区分不同的客户端，以返回不同的数据
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @WinToday3 INT
DECLARE @LostToday3 INT
DECLARE @WinTotal3 INT
DECLARE @LostTotal3 INT
DECLARE @WinToday4 INT
DECLARE @LostToday4 INT
DECLARE @WinTotal4 INT
DECLARE @LostTotal4 INT
DECLARE @AwardToday3 INT
DECLARE @AwardToday4 INT
DECLARE @AwardAll3 INT
DECLARE @AwardAll4 INT
DECLARE @TheDate NVARCHAR(31)

-- 执行逻辑
BEGIN
	IF (@strLoginServer = 'daye') or (@strLoginServer = 'yangxin') or (@strLoginServer = 'dagong') or (@strLoginServer = N'')
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END

		--四人拱的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=997
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--四人拱每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (6,7,8) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--四人拱系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=30 and TaskID <=42 
	END
	ELSE IF @strLoginServer = 'huangshi'
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END
		
		--黄石五十K的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=996
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--黄石五十K每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (10001,10002,10003) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--黄石五十K系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=50 and TaskID <=62 
	END
	ELSE IF @strLoginServer = 'ezhou'
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END
		
		--鄂州五十K的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=995
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--黄石五十K每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (10001,10002,10003) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--黄石五十K系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=50 and TaskID <=62 
	END
	ELSE IF @strLoginServer = 'qianjiang'
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END
		
		--潜江千分的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=990
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--潜江千分每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (10001,10002,10003) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--潜江千分系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=50 and TaskID <=62 
	END
	ELSE IF @strLoginServer = 'chibi'
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END
		
		--赤壁打滚的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=999
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--赤壁打滚每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (10001,10002,10003) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--赤壁打滚系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=50 and TaskID <=62 
	END
	ELSE IF @strLoginServer = 'jianli'
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END
		
		--监利开机的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=988
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--监利开机每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (10001,10002,10003) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--监利开机系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=50 and TaskID <=62 
	END
	ELSE IF @strLoginServer = 'chongyang'
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END
		
		--崇阳的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=987
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--崇阳每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (10001,10002,10003) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--崇阳系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=50 and TaskID <=62 
	END
	ELSE IF @strLoginServer = 'tongshan'
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END
		
		--通山的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=986
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--通山每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (10001,10002,10003) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--通山系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=50 and TaskID <=62 
	END
	ELSE IF @strLoginServer = 'xiantao'
	BEGIN
		--三人拱的盘数
		SELECT @WinToday3=Win,@LostToday3=Lost,@WinTotal3=WinTotal,@LostTotal3=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=998
		-- 结果判断
		IF @WinToday3 IS NULL
		BEGIN
			SET @WinToday3 = 0
			SET @LostToday3 = 0
			SET @WinTotal3 = 0
			SET @LostTotal3 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday3 = 0
				SET @LostToday3 = 0
			END
		END
		
		--仙桃的盘数
		SELECT @WinToday4=Win,@LostToday4=Lost,@WinTotal4=WinTotal,@LostTotal4=LostTotal, @TheDate=Convert(varchar(10),[CollectDate],120)
		FROM GameToday WHERE UserID=@dwUserID and KindID=989
		-- 结果判断
		IF @WinToday4 IS NULL
		BEGIN
			SET @WinToday4 = 0
			SET @LostToday4 = 0
			SET @WinTotal4 = 0
			SET @LostTotal4 = 0
		END
		ELSE
		BEGIN
			IF @TheDate <> Convert(varchar(10),getDate(),120)
			BEGIN
				--不是今天
				SET @WinToday4 = 0
				SET @LostToday4 = 0
			END
		END

		--三人拱每日任务已领奖阶段
		SELECT @AwardToday3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (3,4,5) and datediff(day,[LatestDate],getdate())=0

		--通山每日任务已领奖阶段
		SELECT @AwardToday4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID in (10001,10002,10003) and datediff(day,[LatestDate],getdate())=0

		--三人拱系统任务已领奖阶段
		SELECT @AwardAll3=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=10 and TaskID <=22 

		--通山系统任务已领奖阶段
		SELECT @AwardAll4=count(*)
		FROM [WHGameUserDB].[dbo].[UserGetAward](NOLOCK)
		WHERE UserID=@dwUserID and TaskID >=50 and TaskID <=62 
	END

	-- 输出变量
	SELECT @WinToday3 AS wtoday3, @LostToday3 AS ltoday3, @WinTotal3 AS wtotal3, @LostTotal3 AS ltotal3,
	@WinToday4 AS wtoday4, @LostToday4 AS ltoday4, @WinTotal4 AS wtotal4, @LostTotal4 AS ltotal4,
	@AwardToday3 AS atoday3, @AwardToday4 AS atoday4, @AwardAll3 AS atotal3, @AwardAll4 AS atotal4
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------
