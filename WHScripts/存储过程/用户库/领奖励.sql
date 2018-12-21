
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserGetAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserGetAward]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- I D 登录
CREATE PROC GSP_GP_UserGetAward
	@dwUserID INT,	
	@dwTaskID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @TheScore INT
DECLARE @TheLatestDate DATETIME
DECLARE @TheStatus INT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @TheUserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 查询用户
	IF @TheUserID IS NULL
	BEGIN
		set @ErrorDescribe = N'您的帐号不存在！'
		set @TheStatus = -1
		RETURN -1
	END	

	IF (@dwTaskID >= 10 AND @dwTaskID < 9000) OR (@dwTaskID = 9999)
	BEGIN
		-- 系统任务是否有领奖，不用考虑时间
		SELECT @TheScore=Score
		FROM UserGetAward(NOLOCK) WHERE UserID=@dwUserID and TaskID=@dwTaskID
	END
	ELSE
	BEGIN
		-- 今天是否有领奖
		SELECT @TheScore=Score
		FROM UserGetAward(NOLOCK) WHERE UserID=@dwUserID and TaskID=@dwTaskID and datediff(day,[LatestDate],getdate())=0
	END

	IF @TheScore IS NULL
	BEGIN
		set @TheLatestDate = (select getdate())
		IF @dwTaskID = 1
		BEGIN
			--暂时写死
			--set @TheScore = 1000
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and ToClient=1 and name='wx'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'分享朋友圈活动未开始！'
				set @TheStatus = -2
				RETURN -2
			END
		END
		ELSE IF @dwTaskID = 2
		BEGIN
			--暂时写死
			--set @TheScore = 500
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and ToClient=1 and name='wy'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'分享好友活动未开始！'
				set @TheStatus = -3
				RETURN -3
			END
		END
		ELSE IF @dwTaskID = 9998
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and ToClient=1 and name='qqz'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'分享QQ空间活动未开始！'
				set @TheStatus = -11
				RETURN -11
			END
		END
		ELSE IF @dwTaskID = 9997
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and ToClient=1 and name='qqy'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'分享QQ好友活动未开始！'
				set @TheStatus = -12
				RETURN -12
			END
		END
		ELSE IF @dwTaskID = 3
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='r3_j1'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'三人拱每日盘数活动未开始！'
				set @TheStatus = -4
				RETURN -4
			END
		END
		ELSE IF @dwTaskID = 4
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='r3_j2'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'三人拱每日盘数活动未开始！'
				set @TheStatus = -5
				RETURN -5
			END
		END
		ELSE IF @dwTaskID = 5
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='r3_j3'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'三人拱每日盘数活动未开始！'
				set @TheStatus = -6
				RETURN -6
			END
		END
		ELSE IF @dwTaskID = 6 or @dwTaskID = 10001
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='r4_j1'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'四人拱每日盘数活动未开始！'
				set @TheStatus = -7
				RETURN -7
			END
		END
		ELSE IF @dwTaskID = 7 or @dwTaskID = 10002
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='r4_j2'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'四人拱每日盘数活动未开始！'
				set @TheStatus = -8
				RETURN -8
			END
		END
		ELSE IF @dwTaskID = 8 or @dwTaskID = 10003
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='r4_j3'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'四人拱每日盘数活动未开始！'
				set @TheStatus = -9
				RETURN -9
			END
		END	
		ELSE IF @dwTaskID = 9999
		BEGIN
			SELECT @TheScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='sj_v'
			IF @TheScore IS NULL
			BEGIN
				set @ErrorDescribe = N'账号升级任务获得未开始！'
				set @TheStatus = -10
				RETURN -10
			END
		END
		ELSE IF @dwTaskID = 10 or @dwTaskID = 30 or @dwTaskID = 50 
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 300
		END
		ELSE IF @dwTaskID = 11 or @dwTaskID = 31 or @dwTaskID = 51
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 600
		END
		ELSE IF @dwTaskID = 12 or @dwTaskID = 32 or @dwTaskID = 52
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 1000
		END
		ELSE IF @dwTaskID = 13 or @dwTaskID = 33 or @dwTaskID = 53
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 1500
		END
		ELSE IF @dwTaskID = 14 or @dwTaskID = 34 or @dwTaskID = 54
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 2000
		END
		ELSE IF @dwTaskID = 15 or @dwTaskID = 35 or @dwTaskID = 55
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 3000
		END
		ELSE IF @dwTaskID = 16 or @dwTaskID = 36 or @dwTaskID = 56
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 4600
		END
		ELSE IF @dwTaskID = 17 or @dwTaskID = 37 or @dwTaskID = 57
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 6000
		END
		ELSE IF @dwTaskID = 18 or @dwTaskID = 38 or @dwTaskID = 58
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 8000
		END
		ELSE IF @dwTaskID = 19 or @dwTaskID = 39 or @dwTaskID = 59
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 12000
		END
		ELSE IF @dwTaskID = 20 or @dwTaskID = 40 or @dwTaskID = 60
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 16000
		END
		ELSE IF @dwTaskID = 21 or @dwTaskID = 41 or @dwTaskID = 61
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 20000
		END
		ELSE IF @dwTaskID = 22 or @dwTaskID = 42 or @dwTaskID = 62
		BEGIN
			--暂时写死
			--三人拱系统盘数任务
			set @TheScore = 25000
		END
		ELSE
		BEGIN
			set @ErrorDescribe = N'此任务不支持！'
			set @TheStatus = -10
			RETURN -10
		END

		INSERT INTO UserGetAward(UserID, TaskID, Score, LatestDate) VALUES(@dwUserID, @dwTaskID, @TheScore, @TheLatestDate)

		-- 加分
		UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @TheScore WHERE UserID=@dwUserID
		
		set @ErrorDescribe = N'领奖励成功！'

		set @TheStatus = 0
	END
	ELSE
	BEGIN
		set @TheStatus = 99
	END

	-- 输出变量
	SELECT @TheStatus AS Status, @dwTaskID AS TaskID, @dwUserID AS UserID, @TheScore AS Score
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserCanGetSpreadAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserCanGetSpreadAward]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------------------------------------

-- 是否能领取推广奖励：新安装的包，在7天内有效
CREATE PROC GSP_GP_UserCanGetSpreadAward
	@dwUserID INT,
	@strMachineSerial NCHAR(32) -- 机器标识
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @TheUserIDR INT
DECLARE @TheDateDiff INT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @TheUserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID
	-- 查询用户
	IF @TheUserID IS NULL
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号不存在！',@TheUserID AS UserID
		RETURN 4
	END

	-- 无领奖记录
	SELECT @TheUserIDR=UserID FROM UserSpreadR(NOLOCK) WHERE MachineSerial=@strMachineSerial
	IF @TheUserIDR IS NULL
	BEGIN
		--再检查是否超过时效: 注册时间为7天以内
		SELECT TOP 1 @TheUserIDR=UserID, @TheDateDiff=DATEDIFF([second], [RegisterDate] , getdate()) FROM AccountsInfo(NOLOCK) 
		WHERE MachineSerial=@strMachineSerial
		ORDER BY RegisterDate ASC;

		-- 查询用户
		IF @TheUserIDR IS NULL
		BEGIN
			SELECT [ErrorDescribe]=N'您的设备未注册！',@TheUserID AS UserID
			RETURN 1
		END

		IF @TheDateDiff > 7*24*3600
		BEGIN
			SELECT [ErrorDescribe]=N'您已经超过领奖励时限！',@TheUserID AS UserID
			RETURN 5
		END

		SELECT [ErrorDescribe]=N'您可以领奖！',@TheUserID AS UserID
		RETURN 0
	END
	
	SELECT [ErrorDescribe]=N'您的帐号已经领过奖励！',@TheUserID AS UserID
	RETURN 2
END

RETURN 3

GO

----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserGetSpreadAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserGetSpreadAward]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------------------------------------

-- 推广奖励
CREATE PROC GSP_GP_UserGetSpreadAward
	@dwUserID INT,	
	@dwSpreaderID INT,
	@strMachineSerial NCHAR(32) -- 机器标识
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @TheSpreaderID INT
DECLARE @TheCount INT
DECLARE @TheCountR INT
DECLARE @TheType INT
DECLARE @TheGoldConfig INT
DECLARE @TheGold INT
DECLARE @TheGoldR INT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户,不允许游客帐号
	SELECT @TheUserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID AND IsGuest!=1

	-- 查询用户
	IF @TheUserID IS NULL
	BEGIN
		SELECT [ErrorDescribe]=N'请先到用户中心升级为正式帐号！',@dwUserID AS UserID
		RETURN 1
	END
	
	-- 查询推广员
	SELECT @TheSpreaderID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwSpreaderID
	IF @TheSpreaderID IS NULL
	BEGIN
		SELECT [ErrorDescribe]=N'话费码不存在！',@TheUserID AS UserID
		RETURN 2
	END

	SELECT @TheGoldConfig=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='fx_enable'
	IF @TheGoldConfig IS NULL
	BEGIN
		set @ErrorDescribe = N'推广活动未启动！'
		RETURN 3
	END

	--校验机器码
	IF LEN(LTRIM(RTRIM(@strMachineSerial))) < 12
	BEGIN
		SELECT [ErrorDescribe]=N'请联系客服！',@TheUserID AS UserID
		RETURN 4
	END

	-- 是否已经领奖
	SELECT @TheCount=Amount
	FROM UserSpreadR(NOLOCK) WHERE MachineSerial=@strMachineSerial
	IF @TheCount IS NULL
	BEGIN
		SET @TheCount = @TheGoldConfig
		SET @TheType = 1
		--记录
		INSERT INTO UserSpreadR(UserID,SpreaderID,Amount,Type,AwardDate,MachineSerial) 
		VALUES(@dwUserID, @dwSpreaderID, @TheCount, @TheType, getdate(),@strMachineSerial);

		--发奖(被推广者)
		-- 是否有兑换信息
		SELECT @TheGold=Gold
		FROM UserExchangeInfo(NOLOCK) WHERE UserID=@dwUserID 
		IF @TheGold IS NULL
		BEGIN
			set @TheGold = @TheCount
			INSERT INTO UserExchangeInfo(UserID, Gold, Phone) VALUES(@dwUserID, @TheGold, N'')
		END
		ELSE
		BEGIN
			UPDATE UserExchangeInfo SET Gold = Gold + @TheCount WHERE UserID = @dwUserID
			SET @TheCount = @TheGold + @TheCount
		END

		--发奖(推广员)
		-- 是否有兑换信息
		SET @TheCountR = @TheGoldConfig
		SELECT @TheGoldR=Gold
		FROM UserExchangeInfo(NOLOCK) WHERE UserID=@dwSpreaderID 
		IF @TheGoldR IS NULL
		BEGIN
			INSERT INTO UserExchangeInfo(UserID, Gold, Phone) VALUES(@dwSpreaderID, @TheCountR, N'')
		END
		ELSE
		BEGIN
			UPDATE UserExchangeInfo SET Gold = Gold + @TheCountR WHERE UserID = @dwSpreaderID
		END

		--统计今天推广金豆新增
		DECLARE @TheID INT
		SELECT @TheID=ID FROM WHTreasureDB.dbo.GameDayStatistics(NOLOCK) WHERE Type=3 AND DATEDIFF(day,CollectDate,GETDATE())=0 
		IF @TheID IS NULL
		BEGIN
			INSERT INTO WHTreasureDB.dbo.GameDayStatistics(Type, Value) VALUES(3, @TheCountR)
		END
		ELSE
		BEGIN
			UPDATE WHTreasureDB.dbo.GameDayStatistics SET Value = Value+@TheCountR WHERE ID=@TheID
		END

		SET @ErrorDescribe = N'发放奖励成功！'
	END
	ELSE
	BEGIN
		SELECT [ErrorDescribe]=N'您已经领过奖励了！',@TheUserID AS UserID
		RETURN 3
	END

	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @TheCount AS Amount, @TheType AS Type, @TheUserID AS UserID, @TheSpreaderID AS Spreader
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserGetSpreadInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserGetSpreadInfo]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------------------------------------

-- 推广信息
CREATE PROC GSP_GP_UserGetSpreadInfo
	@dwSpreaderID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUsers INT
DECLARE @TheSpreaderID INT
DECLARE @TheCount INT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	--查询总数
	SELECT @TheUsers=COUNT(*), @TheCount=SUM(Amount) FROM UserSpreadR(NOLOCK) WHERE SpreaderID=@dwSpreaderID
	IF @TheUsers = 0
	BEGIN
		SELECT [ErrorDescribe]=N'您没有推广记录！',@dwSpreaderID AS S
		RETURN 1
	END

	--查询前10条记录
	SELECT TOP 10 (SELECT A.RegAccounts from AccountsInfo(NOLOCK) AS A where A.UserID=R.UserID) AS N,UserID,Amount AS M,
	CONVERT(varchar,AwardDate,102)AS D,@TheUsers AS T, @TheCount AS C,@dwSpreaderID AS S
	FROM UserSpreadR(NOLOCK) AS R WHERE SpreaderID=@dwSpreaderID ORDER BY AwardDate DESC
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
