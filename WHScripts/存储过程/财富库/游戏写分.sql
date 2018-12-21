
----------------------------------------------------------------------------------------------------

USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameScore]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 游戏写分(未使用，实际使用的是GSP_GR_LeaveGameServer)
CREATE PROC GSP_GR_WriteGameScore
	@dwUserID INT,								-- 用户 I D
	@lScore BIGINT,								-- 用户分数
	@lRevenue BIGINT,							-- 游戏税收
	@lWinCount INT,								-- 胜利盘数
	@lLostCount INT,							-- 失败盘数
	@lDrawCount INT,							-- 和局盘数
	@lFleeCount INT,							-- 断线数目
	@lExperience INT,							-- 用户经验
	@dwPlayTimeCount INT,						-- 游戏时间
	@dwOnLineTimeCount INT,						-- 在线时间
	@wKindID INT,							-- 游戏 I D
	@wServerID INT,						-- 房间 I D
	@strClientIP NVARCHAR(15)					-- 连接地址
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @UserID INT

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		RETURN 1
	END

	-- 用户积分
	UPDATE GameScoreInfo SET Score=Score+@lScore, Revenue=Revenue+@lRevenue, WinCount=WinCount+@lWinCount, LostCount=LostCount+@lLostCount,
		DrawCount=DrawCount+@lDrawCount, FleeCount=FleeCount+@lFleeCount, PlayTimeCount=PlayTimeCount+@dwPlayTimeCount, 
		OnLineTimeCount=OnLineTimeCount+@dwOnLineTimeCount
	WHERE UserID=@dwUserID

	-- 用户经验
	UPDATE WHGameUserDB.dbo.AccountsInfo SET Experience=Experience+@lExperience WHERE UserID=@dwUserID

	-- 统计玩家今天输赢盘数
	-- 是否有记录
	DECLARE @TheDate NVARCHAR(31)
	SELECT @TheDate=Convert(varchar(10),[CollectDate],120)
	FROM GameToday(NOLOCK) 
	WHERE UserID=@dwUserID and KindID=@wKindID

	--今天没有记录
	IF @TheDate IS NULL
	BEGIN
		--插入一条默认记录
		INSERT INTO GameToday(UserID, KindID, Win, Lost, Flee, WinTotal, LostTotal, FleeTotal, Win4Activity, Lost4Activity, Flee4Activity) VALUES(@dwUserID,@wKindID,0,0,0,0,0,0,0,0,0)
	END

	--是否需要更新日期
	IF @TheDate <> Convert(varchar(10),getDate(),120)
	BEGIN
		UPDATE  GameToday SET CollectDate=getDate(), Win=0,Lost=0,Flee=0 WHERE UserID=@dwUserID and KindID=@wKindID
	END

	--根据输赢结果来更新计数器
	UPDATE  GameToday SET Win = Win + @lWinCount,WinTotal = WinTotal + @lWinCount,Win4Activity = Win4Activity + @lWinCount,
			      Lost = Lost + @lLostCount,LostTotal = LostTotal + @lLostCount,Lost4Activity = Lost4Activity + @lLostCount,
			      Flee = Flee + @lFleeCount,FleeTotal = FleeTotal + @lFleeCount,Flee4Activity = Flee4Activity + @lFleeCount
	WHERE UserID=@dwUserID and KindID=@wKindID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameRecord]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameRecord]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 游戏写分
CREATE PROC GSP_GR_WriteGameRecord
	@dwUserID INT,								-- 用户 I D
	@lScore BIGINT,								-- 用户本局分数
	@lTotalScore BIGINT,								-- 用户当前总分数
	@lRevenue BIGINT,							-- 游戏税收
	@lResult INT,								-- 胜负
	@lAward INT,								-- 奖励
	@lTime BIGINT,								-- 时间戳
	@wKindID INT,							-- 游戏 I D
	@wServerID INT,						-- 房间 I D
	@strClientIP NVARCHAR(15)					-- 连接地址
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @UserID INT

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		RETURN 1
	END

	DECLARE @adate datetime
	SET @adate = DATEADD (ss ,@lTime % 60 ,DATEADD(mi,@lTime / 60, '1970-01-01 08:00:00'));  --时区

	IF @lAward > 0
	BEGIN
		-- 奖励发放 TODO:应该放到单独的存储过程中
		-- 是否有兑换信息
		DECLARE @TheGold INT
		SELECT @TheGold=Gold
		FROM WHGameUserDB.dbo.UserExchangeInfo(NOLOCK) WHERE UserID=@dwUserID 

		IF @TheGold IS NULL
		BEGIN
			INSERT INTO WHGameUserDB.dbo.UserExchangeInfo(UserID, Gold, Phone) VALUES(@dwUserID, @lAward, N'')
		END
		ELSE
		BEGIN
			IF @lAward > 0
			BEGIN
				UPDATE WHGameUserDB.dbo.UserExchangeInfo SET Gold = Gold + @lAward WHERE UserID=@dwUserID 
			END
		END

		--统计今天金豆新增
		DECLARE @TheID INT
		SELECT @TheID=ID FROM GameDayStatistics(NOLOCK) WHERE Type=1 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheID IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(1, @lAward)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheID
		END
	END

	-- 用户记录
	INSERT GameResultDetails(UserID,TotalScore,Score,Revenue,Result,Award,KindID,ServerID,CollectDate,ClientIP)
	VALUES(@dwUserID,@lTotalScore,@lScore,@lRevenue,@lResult,@lAward,@wKindID,@wServerID,@adate,@strClientIP);

	UPDATE GameScoreInfo SET Score=Score+@lScore, Revenue=Revenue+@lRevenue
	WHERE UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameRecord_V2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameRecord_V2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 游戏写分
CREATE PROC GSP_GR_WriteGameRecord_V2
	@dwUserID INT,								-- 用户 I D
	@lScore BIGINT,								-- 用户本局分数
	@lTotalScore BIGINT,								-- 用户当前总分数
	@lRevenue BIGINT,							-- 游戏税收
	@lResult INT,								-- 胜负
	@lAward INT,								-- 奖励
	@lTime BIGINT,								-- 时间戳
	@wKindID INT,							-- 游戏 I D
	@wServerID INT,						-- 房间 I D
	@wTableID INT,						-- 桌子 I D
	@strClientIP NVARCHAR(15)					-- 连接地址
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @UserID INT

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		RETURN 1
	END

	DECLARE @adate datetime
	SET @adate = DATEADD (ss ,@lTime % 60 ,DATEADD(mi,@lTime / 60, '1970-01-01 08:00:00'));  --时区

	IF @lAward > 0
	BEGIN
		-- 奖励发放 TODO:应该放到单独的存储过程中
		-- 是否有兑换信息
		DECLARE @TheGold INT
		SELECT @TheGold=Gold
		FROM WHGameUserDB.dbo.UserExchangeInfo(NOLOCK) WHERE UserID=@dwUserID 

		IF @TheGold IS NULL
		BEGIN
			INSERT INTO WHGameUserDB.dbo.UserExchangeInfo(UserID, Gold, Phone) VALUES(@dwUserID, @lAward, N'')
		END
		ELSE
		BEGIN
			IF @lAward > 0
			BEGIN
				UPDATE WHGameUserDB.dbo.UserExchangeInfo SET Gold = Gold + @lAward WHERE UserID=@dwUserID 
			END
		END

		--统计今天奖励任务金豆新增
		DECLARE @TheID INT
		SELECT @TheID=ID FROM GameDayStatistics(NOLOCK) WHERE Type=2 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheID IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(2, @lAward)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheID
		END

		--统计今天三人拱奖励任务金豆新增
		IF @wKindID = 998
		BEGIN
			DECLARE @TheIDSan INT
			SELECT @TheIDSan=ID FROM GameDayStatistics(NOLOCK) WHERE Type=6 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDSan IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(6, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDSan
			END
		END
		ELSE IF @wKindID = 997
		BEGIN
			--统计今天四人拱奖励任务金豆新增
			DECLARE @TheIDSi INT
			SELECT @TheIDSi=ID FROM GameDayStatistics(NOLOCK) WHERE Type=7 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDSi IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(7, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDSi
			END
		END
		ELSE IF @wKindID = 995
		BEGIN
			--统计今天鄂州五十K奖励任务金豆新增
			DECLARE @TheIDEr INT
			SELECT @TheIDEr=ID FROM GameDayStatistics(NOLOCK) WHERE Type=20 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDEr IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(20, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDEr
			END
		END
		ELSE IF @wKindID = 996
		BEGIN
			--统计今天黄石五十K奖励任务金豆新增
			DECLARE @TheIDHuang INT
			SELECT @TheIDHuang=ID FROM GameDayStatistics(NOLOCK) WHERE Type=23 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDHuang IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(23, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDHuang
			END
		END
		ELSE IF @wKindID = 990
		BEGIN
			--统计今天潜江千分奖励任务金豆新增
			DECLARE @TheIDQian INT
			SELECT @TheIDQian=ID FROM GameDayStatistics(NOLOCK) WHERE Type=26 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDQian IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(26, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDQian
			END
		END
		ELSE IF @wKindID = 999
		BEGIN
			--统计今天赤壁打滚奖励任务金豆新增
			DECLARE @TheIDChi INT
			SELECT @TheIDChi=ID FROM GameDayStatistics(NOLOCK) WHERE Type=29 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDChi IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(29, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDChi
			END
		END
		ELSE IF @wKindID = 988
		BEGIN
			--统计今天监利开机奖励任务金豆新增
			DECLARE @TheIDJian INT
			SELECT @TheIDJian=ID FROM GameDayStatistics(NOLOCK) WHERE Type=32 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDJian IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(32, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDJian
			END
		END
		ELSE IF @wKindID = 987
		BEGIN
			--统计今天崇阳奖励任务金豆新增
			DECLARE @TheIDChong INT
			SELECT @TheIDChong=ID FROM GameDayStatistics(NOLOCK) WHERE Type=35 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDChong IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(35, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDChong
			END
		END
		ELSE IF @wKindID = 986
		BEGIN
			--统计今天通山奖励任务金豆新增
			DECLARE @TheIDTong INT
			SELECT @TheIDTong=ID FROM GameDayStatistics(NOLOCK) WHERE Type=38 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDTong IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(38, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDTong
			END
		END
		ELSE IF @wKindID = 989
		BEGIN
			--统计今天仙桃奖励任务金豆新增
			DECLARE @TheIDXianTao INT
			SELECT @TheIDXianTao=ID FROM GameDayStatistics(NOLOCK) WHERE Type=41 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDXianTao IS NULL
			BEGIN
				INSERT INTO GameDayStatistics(Type, Value) VALUES(41, @lAward)
			END
			ELSE
			BEGIN
				UPDATE GameDayStatistics SET Value = Value + @lAward WHERE ID=@TheIDXianTao
			END
		END
	END


	-- 用户记录
	INSERT GameResultDetails(UserID,TotalScore,Score,Revenue,Result,Award,KindID,ServerID,TableID,CollectDate,ClientIP)
	VALUES(@dwUserID,@lTotalScore,@lScore,@lRevenue,@lResult,@lAward,@wKindID,@wServerID,@wTableID,@adate,@strClientIP);

	UPDATE GameScoreInfo SET Score=Score+@lScore, Revenue=Revenue+@lRevenue WHERE UserID=@dwUserID
	UPDATE GameScoreInfo SET Score=0 WHERE UserID=@dwUserID And Score<0

END

RETURN 0

GO

