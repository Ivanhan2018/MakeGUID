
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_RegisterAccounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_RegisterAccounts]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 帐号注册
CREATE PROC GSP_GP_RegisterAccounts
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strPassword NCHAR(32),						-- 用户密码
	@strSpreader NVARCHAR(31),					-- 推广员名
	@wFaceID INT,							-- 头像标识
	@cbGender TINYINT,							-- 用户性别
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
DECLARE @TmpRegAccounts NVARCHAR(31)
DECLARE @UnderWrite NVARCHAR(63)

-- 扩展信息
DECLARE @GameID INT
DECLARE @SpreaderID INT
DECLARE @Gender TINYINT
DECLARE @Experience INT
DECLARE @Loveliness INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @CustomFaceVer TINYINT
DECLARE @IsGuest TINYINT
DECLARE @GOLDSCORE INT

-- 辅助变量
DECLARE @EnjoinLogon AS INT
DECLARE @EnjoinRegister AS INT
DECLARE @ErrorDescribe AS NVARCHAR(128)
DECLARE @Rule AS NVARCHAR(512)
DECLARE @guestAccounts NVARCHAR(31)		-- 游客帐号
DECLARE @guestPasswordX NVARCHAR(32)		-- 游客密码
DECLARE @guestPassword NVARCHAR(32)		-- 游客密码明文
DECLARE @guestGender TINYINT			-- 游客性别
DECLARE @NeedGuest AS INT			-- 是否需要游客帐号
DECLARE @iCount AS INT				-- 循环计数器
DECLARE @TheWeekday AS INT --当天星期几

-- 执行逻辑
BEGIN
	-- 效验名字
	IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strAccounts)>0)>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，您所输入的帐号名含有限制字符串，请更换帐号名后再次申请帐号！'
		RETURN 4
	END

	-- 效验地址
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，系统禁止了您所在的 IP 地址的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 5
	END
	
	-- 效验机器
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineSerial AND GETDATE()<EnjoinOverDate
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，系统禁止了您的机器的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 6
	END
 
	-- 查询用户
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
	BEGIN
		SELECT [ErrorDescribe]=N'此帐号名已被注册，请换另一帐号名字尝试再次注册！'
		RETURN 7
	END

	SET @RegAccounts = @strAccounts

	--获取游客帐号
	SET @NeedGuest = 1
	IF LEN(@strAccounts) = 0
	BEGIN
		--先根据机器码进行关联
		SELECT TOP 1 @strAccounts=Accounts,@GuestPassword=InsurePass,@TmpRegAccounts=RegAccounts FROM AccountsInfo(NOLOCK) WHERE MachineSerial=@strMachineSerial AND IsGuest=1
		IF LEN(@strAccounts) <> 0
		BEGIN
			--SELECT [ErrorDescribe]=N'复用绑定设备的帐号！'
			SET @NeedGuest = 0
			SET @RegAccounts = @TmpRegAccounts
		END
		ELSE
		BEGIN
			SET @iCount = 0
			WHILE @iCount < 100
			BEGIN
				SET @iCount = @iCount + 1
				SELECT TOP 1 @guestAccounts=Accounts, @guestPassword=Password, @guestPasswordX=PasswordX, @guestGender=Gender from GuestInfo
				IF @guestAccounts IS NULL
				BEGIN
					SELECT [ErrorDescribe]=N'游客账号用完了！'
					RETURN 9
				END
				set @strAccounts = @guestAccounts
				set @strPassword = @guestPasswordX
				set @cbGender = @guestGender
				SET @RegAccounts = @strAccounts

				DELETE FROM GuestInfo WHERE Accounts = @strAccounts

				-- 查询用户
				IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
				BEGIN
					SELECT [ErrorDescribe]=N'此游客帐号名已被注册，请换另一帐号名字尝试再次注册！'
					--RETURN 10
				END
				ELSE 
				BEGIN
					BREAK
				END
			END
		END
	END

	IF @iCount = 100
	BEGIN
		SELECT [ErrorDescribe]=N'游客帐号已用完！'
		RETURN 10
	END

	--校验推广员信息 @strSpreader
	--要求帐号的推广员与设备绑定，只认可设备第一次安装时的推广渠道
	DECLARE @strOldSpreader NVARCHAR(31)
	DECLARE @strTheSpreader NVARCHAR(31)
	SELECT TOP 1 @strOldSpreader=SpreaderID FROM AccountsInfo WHERE MachineSerial=@strMachineSerial ORDER BY UserID ASC
	IF @strOldSpreader IS NOT NULL
	BEGIN
		--从客户端提交的渠道号，被临时写入字段UnderWrite，备查
		SET @strTheSpreader = N''
	END
	ELSE
	BEGIN
		SET @strTheSpreader = @strSpreader
	END

	IF @NeedGuest <> 0
	BEGIN
		-- 注册用户
		INSERT AccountsInfo (Accounts,RegAccounts,LogonPass,InsurePass,SpreaderID,UnderWrite,Gender,FaceID,MachineSerial,GameLogonTimes,RegisterIP,LastLogonIP,IsGuest)
		VALUES (@strAccounts,@strAccounts,@strPassword,@GuestPassword,@strTheSpreader,@strSpreader,@cbGender,@wFaceID,@strMachineSerial,1,@strClientIP,@strClientIP,1)
		

		-- 错误判断
		IF @@ERROR<>0
		BEGIN
			SELECT [ErrorDescribe]=N'帐号已存在，请换另一帐号名字尝试再次注册！'
			RETURN 8
		END
	END

	-- 查询用户
	SELECT @UserID=UserID, @Accounts=Accounts, @UnderWrite=UnderWrite, @Gender=Gender, @FaceID=FaceID, @Experience=Experience,
		@MemberOrder=MemberOrder, @MemberOverDate=MemberOverDate, @Loveliness=Loveliness,@CustomFaceVer=CustomFaceVer
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	-- 分配标识
	SELECT @GameID=GameID FROM GameIdentifier(NOLOCK) WHERE UserID=@UserID
	IF @GameID IS NULL 
	BEGIN
		SET @GameID=0
		SET @ErrorDescribe=N'用户注册成功，但未成功获取游戏 ID 号码，系统稍后将给您分配！'
	END
	ELSE UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@UserID	
	
	-- 游戏信息
	SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID

	-- 信息判断
	IF @GoldScore IS NULL
	BEGIN
		-- 插入资料
		INSERT INTO WHTreasureDB.dbo.GameScoreInfo (UserID, LastLogonIP, RegisterIP)	VALUES (@UserID,@strClientIP,@strClientIP)

		-- 游戏信息
		SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID
	END

	-- 查询系统参数配置
	SET @Rule = N''
	DECLARE c1 cursor for SELECT name,value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and ToClient=1
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

	-- 记录日志
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameRegisterSuccess=GameRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, GameRegisterSuccess) VALUES (@DateID, 1)

	-- 输出变量
	SET @IsGuest = 1
	SELECT @UserID AS UserID, @GameID AS GameID, @Accounts AS Accounts, @RegAccounts AS NickName, @GuestPassword AS GuestPassword, @UnderWrite AS UnderWrite, @FaceID AS FaceID, @Gender AS Gender, @Experience AS Experience, @MemberOrder AS MemberOrder, @MemberOverDate AS MemberOverDate,@ErrorDescribe AS ErrorDescribe, @Loveliness AS Loveliness,@CustomFaceVer AS CustomFaceVer,@GoldScore AS GoldScore, @Rule AS LobbyRule, @IsGuest AS IsGuest

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserCreateGuestAccount') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserCreateGuestAccount
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 兑换的商品
CREATE PROC GSP_GP_UserCreateGuestAccount
	@dwBegin INT,
	@dwCount INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @TheIndex INT
DECLARE @TheAccounts AS NVARCHAR(32)
DECLARE @TmpAccounts AS NVARCHAR(32)

--注意类型
DECLARE @ThePassword AS VARCHAR(8)
DECLARE @ThePasswordX AS NVARCHAR(32)


-- 执行逻辑
BEGIN
	SET @TheIndex = 0
	WHILE @TheIndex < @dwCount
	BEGIN
		SET @TheAccounts = 'kaa' + convert(varchar(10), cast(ceiling(rand() * 1000000) as int) + @dwBegin)
		SET @ThePassword = convert(varchar(10),cast(ceiling(rand() * 10000000) as int) + 10000000)
		SET @ThePasswordX = substring(sys.fn_VarBinToHexStr(hashbytes('MD5',@ThePassword)),3,32)

		-- 检验是否重复
		SELECT @TmpAccounts=Accounts FROM GuestInfo(NOLOCK) WHERE Accounts=@TheAccounts
		IF @TmpAccounts IS NULL 
		BEGIN
			--再检查用户表
			SELECT @TmpAccounts=Accounts FROM AccountsInfo(NOLOCK) WHERE Accounts=@TheAccounts
			IF @TmpAccounts IS NULL 
			BEGIN
				--插入
				IF @TheIndex%2 = 0
				BEGIN
					INSERT GuestInfo(Accounts, PasswordX, Password, Gender) VALUES(@TheAccounts, @ThePasswordX, @ThePassword, 48)
				END
				ELSE
				BEGIN
					INSERT GuestInfo(Accounts, PasswordX, Password, Gender) VALUES(@TheAccounts, @ThePasswordX, @ThePassword, 49)
				END
				
				SET @TheIndex = @TheIndex + 1
			END
			ELSE
			BEGIN
				SET @TmpAccounts = NULL
			END
		END
		ELSE
		BEGIN
			SET @TmpAccounts = NULL
		END
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserCreateSpecialAccount') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserCreateSpecialAccount
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 陪打帐号
CREATE PROC GSP_GP_UserCreateSpecialAccount
	@TheA AS NVARCHAR(32),
	@TheP AS VARCHAR(8),
	@TheS AS NVARCHAR(32)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @TheIndex INT
DECLARE @TheAccounts AS NVARCHAR(32)
DECLARE @TmpAccounts AS NVARCHAR(32)

--注意类型
DECLARE @ThePassword AS VARCHAR(8)
DECLARE @ThePasswordX AS NVARCHAR(32)


DECLARE	@return_value int

-- 执行逻辑
BEGIN

SET @ThePasswordX = substring(sys.fn_VarBinToHexStr(hashbytes('MD5',@TheP)),3,32)

EXEC	@return_value = [dbo].[GSP_GP_RegisterAccounts]
		@strAccounts = @TheA,
		@strPassword = @ThePasswordX,
		@strSpreader = @TheS,
		@wFaceID = 9999,
		@cbGender = 48,
		@strClientIP = N'1.1.1.1',
		@strMachineSerial = N'1111'

SELECT	'Return Value' = @return_value

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

