
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_CheckUserGMScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_CheckUserGMScore]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 检查GM工具发放的财富
CREATE PROC GSP_GP_CheckUserGMScore
	@dwUserID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @TheCount INT
DECLARE @GoldScore INT
DECLARE @Status NVARCHAR(32)
DECLARE @Comment NVARCHAR(64)

-- 执行逻辑
BEGIN
	-- 查询用户的发财富任务（1）
	SELECT @TheUserID=UserID, @TheCount=sum(convert(int,Params))  FROM GMTask(NOLOCK) WHERE UserID=@dwUserID and TaskID=1 group by UserID

	-- 没有任务
	IF @TheUserID IS NULL
	BEGIN
		RETURN 0
	END	

	-- 游戏信息
	SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID
	-- 信息判断
	IF @GoldScore IS NULL
	BEGIN
		SET @TheCount = 0
		SET @Status = N'失败'
		SET @Comment = N'财富表中ID不存在'
	END
	ELSE
	BEGIN
		SET @Status = N'成功'
		SET @Comment = N'发放财富'+convert(varchar(32),@TheCount)
	END

	-- 执行任务
	INSERT INTO GMTaskLog SELECT *,getdate(),@Status,@Comment FROM GMTask WHERE UserID=@dwUserID and TaskID=1
	UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @TheCount WHERE UserID=@dwUserID
	DELETE FROM GMTask WHERE UserID=@dwUserID and TaskID=1

	RETURN @TheCount
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_EfficacyAccounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_EfficacyAccounts]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 帐号登陆
CREATE PROC GSP_GP_EfficacyAccounts
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineSerial NCHAR(32)					-- 机器标识
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @FaceID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @RegAccounts NVARCHAR(31)
DECLARE @UnderWrite NVARCHAR(63)

-- 扩展信息
DECLARE @GameID INT
DECLARE @Gender TINYINT
DECLARE @Experience INT
DECLARE @Loveliness INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @CustomFaceVer TINYINT
DECLARE @IsGuest TINYINT
DECLARE @GOLDSCORE INT
DECLARE @Welfare INT
DECLARE @WelfareLost INT
DECLARE @GMScore INT


-- 辅助变量
DECLARE @EnjoinLogon AS INT
DECLARE @ErrorDescribe AS NVARCHAR(128)
DECLARE @Rule AS NVARCHAR(512)

-- 执行逻辑
BEGIN
	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，系统禁止了您所在的 IP 地址的登录功能，请联系客户服务中心了解详细情况！'
		RETURN 4
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineSerial AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，系统禁止了您的机器的登录功能，请联系客户服务中心了解详细情况！'
		RETURN 7
	END
 
	-- 查询用户
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE	@MachineSerial NCHAR(32)
	DECLARE @MoorMachine AS TINYINT
	SELECT @UserID=UserID, @GameID=GameID,  @Accounts=Accounts, @RegAccounts=RegAccounts, @UnderWrite=UnderWrite, @LogonPass=LogonPass, @FaceID=FaceID,
		@Gender=Gender, @Nullity=Nullity, @StunDown=StunDown, @Experience=Experience, @MemberOrder=MemberOrder, @MemberOverDate=MemberOverDate, 
		@MoorMachine=MoorMachine, @MachineSerial=MachineSerial, @Loveliness=Loveliness,@CustomFaceVer=CustomFaceVer,@IsGuest=IsGuest
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 1
	END	

	-- 帐号禁止
--	IF @Nullity<>0
--	BEGIN
--		SELECT [ErrorDescribe]=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
--		RETURN 2
--	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	
	
	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineSerial<>@strMachineSerial
		BEGIN
			SELECT [ErrorDescribe]=N'您的帐号使用固定机器登陆功能，您现所使用的机器不是所指定的机器！'
			RETURN 1
		END
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 3
	END

	-- 固定机器
	IF @MoorMachine=2
	BEGIN
		SET @MoorMachine=1
		SET @ErrorDescribe=N'您的帐号成功使用了固定机器登陆功能！'
		UPDATE AccountsInfo SET MoorMachine=@MoorMachine, MachineSerial=@strMachineSerial WHERE UserID=@UserID
	END

	-- 会员等级
	IF GETDATE()>=@MemberOverDate 
	BEGIN 
		SET @MemberOrder=0

		-- 删除过期会员身份
		DELETE FROM MemberInfo WHERE UserID=@UserID
	END
	ELSE 
	BEGIN
		DECLARE @MemberCurDate DATETIME

		-- 当前会员时间
		SELECT @MemberCurDate=MIN(MemberOverDate) FROM MemberInfo WHERE UserID=@UserID

		-- 删除过期会员
		IF GETDATE()>=@MemberCurDate
		BEGIN
			-- 删除会员期限过期的所有会员身份
			DELETE FROM MemberInfo WHERE UserID=@UserID AND MemberOverDate<=GETDATE()

			-- 切换到下一级别会员身份
			SELECT @MemberOrder=MAX(MemberOrder) FROM MemberInfo WHERE UserID=@UserID
			IF @MemberOrder IS NOT NULL
			BEGIN
				UPDATE AccountsInfo SET MemberOrder=@MemberOrder WHERE UserID=@UserID
			END
			ELSE SET @MemberOrder=0
		END
	END

	--检查低保
	EXEC @Welfare=dbo.GSP_GP_UserWelfare @UserID,@WelfareLost output

	-- 游戏信息
	SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID

	-- 信息判断
	IF @GoldScore IS NULL
	BEGIN
		-- 插入资料
		INSERT INTO WHTreasureDB.dbo.GameScoreInfo (UserID, LastLogonIP, RegisterIP)	VALUES (@UserID,@strClientIP,@strClientIP)

		-- 游戏信息
		SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID

		SET @Welfare=-2
		SET @WelfareLost=0
	END

	
	--检查GM工具发放的奖励
	EXEC @GMScore=dbo.GSP_GP_CheckUserGMScore @UserID
	SET @GoldScore = @GoldScore + @GMScore

	-- 更新信息
	UPDATE AccountsInfo SET MemberOrder=@MemberOrder, GameLogonTimes=GameLogonTimes+1,LastLogonDate=GETDATE(),
		LastLogonIP=@strClientIP WHERE UserID=@UserID

	-- 查询系统参数配置
	SET @Rule = N''
	DECLARE c1 cursor for SELECT name,value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and ToClient=1
        DECLARE @sname varchar(32), @svalue varchar(64)  
        OPEN c1  
        FETCH c1 INTO @sname,@svalue  
        WHILE @@fetch_status=0  
        BEGIN  
		IF @Rule = ''  
		BEGIN  
			SET @Rule = @sname + ':' + @svalue
		END
		ELSE 
		BEGIN  
			SET @Rule = @Rule + '|' + @sname + ':' + @svalue
		END 

		FETCH c1 INTO @sname,@svalue  
        END 
	CLOSE c1
	DEALLOCATE c1

	-- 记录日志
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameLogonSuccess=GameLogonSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, GameLogonSuccess) VALUES (@DateID, 1)

	-- 输出变量
	SELECT @UserID AS UserID, @GameID AS GameID, @Accounts AS Accounts,@RegAccounts AS NickName, @UnderWrite AS UnderWrite, @FaceID AS FaceID, 
		@Gender AS Gender, @Experience AS Experience, @MemberOrder AS MemberOrder, @MemberOverDate AS MemberOverDate,
		@ErrorDescribe AS ErrorDescribe, @Loveliness AS Loveliness,@CustomFaceVer AS CustomFaceVer, @GoldScore AS GoldScore, @Welfare AS Welfare, @WelfareLost AS WelfareLost, @Rule AS LobbyRule, @IsGuest AS IsGuest

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_EfficacyAccounts_v2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_EfficacyAccounts_v2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 帐号登陆
CREATE PROC GSP_GP_EfficacyAccounts_v2
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineSerial NCHAR(32),					-- 机器标识
	@strLoginServer NVARCHAR(15)		-- 登录服务器名称，用来区分不同的客户端，以返回不同的数据
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @FaceID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @RegAccounts NVARCHAR(31)
DECLARE @UnderWrite NVARCHAR(63)

-- 扩展信息
DECLARE @GameID INT
DECLARE @Gender TINYINT
DECLARE @Experience INT
DECLARE @Loveliness INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @CustomFaceVer TINYINT
DECLARE @IsGuest TINYINT
DECLARE @GOLDSCORE INT
DECLARE @Welfare INT
DECLARE @WelfareLost INT
DECLARE @GMScore INT


-- 辅助变量
DECLARE @EnjoinLogon AS INT
DECLARE @ErrorDescribe AS NVARCHAR(128)
DECLARE @Rule AS NVARCHAR(512)

DECLARE @TheWeekday AS INT --当天星期几

-- 执行逻辑
BEGIN
	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，系统禁止了您所在的 IP 地址的登录功能，请联系客户服务中心了解详细情况！'
		RETURN 4
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineSerial AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，系统禁止了您的机器的登录功能，请联系客户服务中心了解详细情况！'
		RETURN 7
	END
 
	-- 查询用户
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE	@MachineSerial NCHAR(32)
	DECLARE @MoorMachine AS TINYINT
	SELECT @UserID=UserID, @Accounts=Accounts, @RegAccounts=RegAccounts, @LogonPass=LogonPass,
		@Gender=Gender, @Nullity=Nullity, @StunDown=StunDown, @MachineSerial=MachineSerial, @IsGuest=IsGuest
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 1
	END	

	-- 帐号禁止
--	IF @Nullity<>0
--	BEGIN
--		SELECT [ErrorDescribe]=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
--		RETURN 2
--	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	
	
	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineSerial<>@strMachineSerial
		BEGIN
			SELECT [ErrorDescribe]=N'您的帐号使用固定机器登陆功能，您现所使用的机器不是所指定的机器！'
			RETURN 1
		END
	END

	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 3
	END

	--检查低保
	EXEC @Welfare=dbo.GSP_GP_UserWelfare @UserID,@WelfareLost output

	-- 游戏信息
	SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID

	-- 信息判断
	IF @GoldScore IS NULL
	BEGIN
		-- 插入资料
		INSERT INTO WHTreasureDB.dbo.GameScoreInfo (UserID, LastLogonIP, RegisterIP)	VALUES (@UserID,@strClientIP,@strClientIP)

		-- 游戏信息
		SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID

		SET @Welfare=-2
		SET @WelfareLost=0
	END

	
	--检查GM工具发放的奖励
	EXEC @GMScore=dbo.GSP_GP_CheckUserGMScore @UserID
	SET @GoldScore = @GoldScore + @GMScore

	-- 更新信息
	UPDATE AccountsInfo SET GameLogonTimes=GameLogonTimes+1,LastLogonDate=GETDATE(),
		LastLogonIP=@strClientIP WHERE UserID=@UserID

	-- 查询系统参数配置
	SET @Rule = N''
	DECLARE c1 cursor for SELECT name,value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and ToClient=1 and (LoginServer like '%,'+@strLoginServer+',%' or LoginServer = 'all')
        DECLARE @sname varchar(32), @svalue varchar(64), @nWeekday INT, @nLen INT, @nTemp INT
        OPEN c1  
        FETCH c1 INTO @sname,@svalue  
        WHILE @@fetch_status=0  
        BEGIN  
		
		IF @sname='wx_task'	--判断任务面板中的微信分享是否显示
		BEGIN
			SET @nTemp = 0
			SET @TheWeekday=CONVERT(INT, datepart(weekday, getdate()))-1 --当前星期几
			IF @TheWeekday = 0		--星期天时值为7
				SET @TheWeekday = 7
				
			WHILE @svalue<>''
			BEGIN
				SET @nLen = LEN(@svalue)
				IF @nLen = 1
				BEGIN
					SET @nWeekday = CONVERT(INT, LEFT(@svalue, 1))
					SET @svalue = STUFF(@svalue, 1, 1, '')
				END
				ELSE
				BEGIN
					SET @nWeekday = CONVERT(INT, LEFT(@svalue, CHARINDEX('/', @svalue)-1))
					SET @svalue = STUFF(@svalue, 1, 2, '')
				END
				
				IF @TheWeekday = @nWeekday
				BEGIN
					SET @nTemp = 1
					BREAK
				END
			END
			
			IF @nTemp = 1
			BEGIN
				SET @svalue = '1'
			END
			ELSE 
			BEGIN
				SET @svalue = '0'
			END
		END
		
		IF @Rule = ''  
		BEGIN  
			SET @Rule = @sname + ':' + @svalue
		END
		ELSE 
		BEGIN  
			SET @Rule = @Rule + '|' + @sname + ':' + @svalue
		END 

		FETCH c1 INTO @sname,@svalue  
        END 
	CLOSE c1
	DEALLOCATE c1

	-- 输出变量
	SELECT @UserID AS UserID, 0 AS GameID, @Accounts AS Accounts,@RegAccounts AS NickName, N'' AS UnderWrite, 0 AS FaceID, 
		@Gender AS Gender, 0 AS Experience, 0 AS MemberOrder, 0 AS MemberOverDate,
		@ErrorDescribe AS ErrorDescribe, 0 AS Loveliness,0 AS CustomFaceVer, @GoldScore AS GoldScore, @Welfare AS Welfare, @WelfareLost AS WelfareLost, @Rule AS LobbyRule, @IsGuest AS IsGuest

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
