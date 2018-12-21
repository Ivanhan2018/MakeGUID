
----------------------------------------------------------------------------------------------------
-- 增加用户魅力(修改后的)，保留金币,@lScore(改变值)
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------

USE WHTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_LeaveGameServer]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_LeaveGameServer]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 离开房间
CREATE PROC GSP_GR_LeaveGameServer
	@dwUserID INT,								-- 用户 I D
	@lScore BIGINT,								-- 用户分数
	@lGameGold BIGINT,							-- 游戏金币
	@lInsureScore BIGINT,						-- 银行金币
	@lLoveliness BIGINT,						-- 玩家魅力
	@lRevenue BIGINT,							-- 游戏税收
	@lWinCount INT,								-- 胜利盘数
	@lLostCount INT,							-- 失败盘数
	@lDrawCount INT,							-- 和局盘数
	@lFleeCount INT,							-- 断线数目
	@lExperience INT,							-- 用户经验
	@dwPlayTimeCount INT,						-- 游戏时间
	@dwOnLineTimeCount INT,						-- 在线时间
	@wKindID INT,								-- 游戏 I D
	@wServerID INT,								-- 房间 I D
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
--	UPDATE GameScoreInfo SET Score=Score+@lScore, InsureScore=InsureScore+@lInsureScore, Revenue=Revenue+@lRevenue, WinCount=WinCount+@lWinCount, LostCount=LostCount+@lLostCount, 
--		DrawCount=DrawCount+@lDrawCount, FleeCount=FleeCount+@lFleeCount, PlayTimeCount=PlayTimeCount+@dwPlayTimeCount,
--		OnLineTimeCount=OnLineTimeCount+@dwOnLineTimeCount
--	WHERE UserID=@dwUserID
	UPDATE GameScoreInfo SET WinCount=WinCount+@lWinCount, LostCount=LostCount+@lLostCount, 
		DrawCount=DrawCount+@lDrawCount, FleeCount=FleeCount+@lFleeCount, PlayTimeCount=PlayTimeCount+@dwPlayTimeCount,
		OnLineTimeCount=OnLineTimeCount+@dwOnLineTimeCount
	WHERE UserID=@dwUserID

	-- 锁定解除
	DELETE GameScoreLocker WHERE UserID=@dwUserID

	-- 离开房间
	INSERT RecordUserLeave (UserID, Score, Revenue, KindID, ServerID, PlayTimeCount, OnLineTimeCount) 
	VALUES (@dwUserID, @lScore, @lRevenue, @wKindID, @wServerID, @dwPlayTimeCount, @dwOnLineTimeCount)

	-- 检验时间统计临时表
	IF @dwPlayTimeCount > 0
	BEGIN
		DECLARE @TheTmpUserID INT
		SELECT @TheTmpUserID=UserID FROM GameTimeStatistics(NOLOCK) WHERE UserID=@dwUserID AND KindID=@wKindID
		IF @TheTmpUserID IS NULL
		BEGIN
			--新增
			INSERT GameTimeStatistics (UserID, KindID, PlayTime) VALUES(@dwUserID, @wKindID, @dwPlayTimeCount)
		END
		ELSE
		BEGIN
			--更新
			UPDATE GameTimeStatistics SET PlayTime=PlayTime+@dwPlayTimeCount WHERE UserID=@dwUserID AND KindID=@wKindID
		END
	END

	--统计茶水费
	DECLARE @TheTypeValue INT
	IF @wKindID = 998
	BEGIN
		--三人拱
		DECLARE @TheIDSan INT
		SELECT @TheIDSan=ID FROM GameDayStatistics(NOLOCK) WHERE Type=8 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDSan IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(8, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDSan
		END
	END
	ELSE IF @wKindID = 997
	BEGIN
		--四人拱
		DECLARE @TheIDSi INT
		SELECT @TheIDSi=ID FROM GameDayStatistics(NOLOCK) WHERE Type=9 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDSi IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(9, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDSi
		END
	END
	ELSE IF @wKindID = 995
	BEGIN
		--鄂州五十K
		DECLARE @TheIDEr INT
		SELECT @TheIDEr=ID FROM GameDayStatistics(NOLOCK) WHERE Type=21 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDEr IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(21, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDEr
		END
	END
	ELSE IF @wKindID = 996
	BEGIN
		--黄石五十K
		DECLARE @TheIDHuang INT
		SELECT @TheIDHuang=ID FROM GameDayStatistics(NOLOCK) WHERE Type=24 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDHuang IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(24, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDHuang
		END
	END
	ELSE IF @wKindID = 990
	BEGIN
		--黄石五十K
		DECLARE @TheIDQian INT
		SELECT @TheIDQian=ID FROM GameDayStatistics(NOLOCK) WHERE Type=27 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDQian IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(27, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDQian
		END
	END
	ELSE IF @wKindID = 999
	BEGIN
		--赤壁打滚
		DECLARE @TheIDChi INT
		SELECT @TheIDChi=ID FROM GameDayStatistics(NOLOCK) WHERE Type=30 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDChi IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(30, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDChi
		END
	END
	ELSE IF @wKindID = 988
	BEGIN
		--监利开机
		DECLARE @TheIDJian INT
		SELECT @TheIDJian=ID FROM GameDayStatistics(NOLOCK) WHERE Type=33 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDJian IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(33, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDJian
		END
	END
	ELSE IF @wKindID = 987
	BEGIN
		--崇阳
		DECLARE @TheIDChong INT
		SELECT @TheIDChong=ID FROM GameDayStatistics(NOLOCK) WHERE Type=36 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDChong IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(36, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDChong
		END
	END
	ELSE IF @wKindID = 986
	BEGIN
		--通山
		DECLARE @TheIDTong INT
		SELECT @TheIDTong=ID FROM GameDayStatistics(NOLOCK) WHERE Type=39 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDTong IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(39, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDTong
		END
	END
	ELSE IF @wKindID = 989
	BEGIN
		--仙桃
		DECLARE @TheIDXianTao INT
		SELECT @TheIDXianTao=ID FROM GameDayStatistics(NOLOCK) WHERE Type=42 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDXianTao IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(42, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDXianTao
		END
	END
	ELSE IF @wKindID = 994
	BEGIN
		--牛牛
		DECLARE @TheIDNiu INT
		SELECT @TheIDNiu=ID FROM GameDayStatistics(NOLOCK) WHERE Type=10 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDNiu IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(10, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDNiu
		END

		DECLARE @TheTypeNiu INT
		IF @wServerID = 4001 OR @wServerID = 4005
		BEGIN
			SET @TheTypeNiu = 11
		END
		ELSE IF @wServerID = 4002 OR @wServerID = 4006
		BEGIN
			SET @TheTypeNiu = 12
		END
		ELSE IF @wServerID = 4003 OR @wServerID = 4007
		BEGIN
			SET @TheTypeNiu = 13
		END
		ELSE IF @wServerID = 4004 OR @wServerID = 4008
		BEGIN
			SET @TheTypeNiu = 14
		END
		ELSE IF @wServerID = 4009 OR @wServerID = 4010
		BEGIN
			SET @TheTypeNiu = 15
		END
		ELSE
		BEGIN
			SET @TheTypeNiu = 0
		END
		
		--各房间
		DECLARE @TheIDNiuR INT
		SELECT @TheIDNiuR=ID FROM GameDayStatistics(NOLOCK) WHERE Type=@TheTypeNiu AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheIDNiuR IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(@TheTypeNiu, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheIDNiuR
		END
	END
	ELSE IF @wKindID = 961
	BEGIN
		--三张
		DECLARE @TheSanzhang INT
		SELECT @TheSanzhang=ID FROM GameDayStatistics(NOLOCK) WHERE Type=61 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheSanzhang IS NULL
		BEGIN
			INSERT INTO GameDayStatistics(Type, Value) VALUES(61, @lRevenue)
		END
		ELSE
		BEGIN
			UPDATE GameDayStatistics SET Value = Value + @lRevenue WHERE ID=@TheSanzhang
		END
	END
	-- 用户魅力
--	INSERT RecordUserLoveliness (UserID, KindID, ServerID,Loveliness,ClientIP)
--	VALUES (@dwUserID,@wKindID,@wServerID,@lLoveliness,@strClientIP)

	-- 用户经验
--	UPDATE WHGameUserDB.dbo.AccountsInfo SET Experience=Experience+@lExperience,Loveliness=@lLoveliness WHERE UserID=@dwUserID

	-- @lDrawCount取平局，逃跑的不算
	IF @lWinCount + @lLostCount + @lDrawCount > 0
	BEGIN
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
			UPDATE  GameToday SET CollectDate=getDate(),
					      Win = @lWinCount, WinTotal = WinTotal + @lWinCount, Win4Activity = Win4Activity + @lWinCount,
					      Lost = @lLostCount, LostTotal = LostTotal + @lLostCount,Lost4Activity = Lost4Activity + @lLostCount,
					      Flee = @lDrawCount, FleeTotal = FleeTotal + @lDrawCount,Flee4Activity = Flee4Activity + @lDrawCount
			WHERE UserID=@dwUserID and KindID=@wKindID
		END
		ELSE
		BEGIN
			--根据输赢结果来更新计数器
			UPDATE  GameToday SET Win = Win + @lWinCount,WinTotal = WinTotal + @lWinCount,Win4Activity = Win4Activity + @lWinCount,
					      Lost = Lost + @lLostCount,LostTotal = LostTotal + @lLostCount,Lost4Activity = Lost4Activity + @lLostCount,
					      Flee = Flee + @lDrawCount,FleeTotal = FleeTotal + @lDrawCount,Flee4Activity = Flee4Activity + @lDrawCount
			WHERE UserID=@dwUserID and KindID=@wKindID
		END
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------


IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_RoomStartFinish]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_RoomStartFinish]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 房间启动完成
CREATE PROC GSP_GR_RoomStartFinish
	@wKindID INT,			-- 游戏 I D
	@wServerID INT			-- 房间 I D
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @UserID INT

-- 执行逻辑
BEGIN
	-- 删除锁定的用户
	DELETE FROM WHTreasureDB.dbo.GameScoreLocker WHERE ServerID=@wServerID AND KindID=@wKindID
END

RETURN 0

GO

