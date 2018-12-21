
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_CheckID]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_CheckID]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 个人信息
CREATE PROC GSP_GP_CheckID
	@strAccount NVARCHAR(31)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 辅助变量
DECLARE @TheUserID INT
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @TheUserID=UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccount

	-- 查询用户
	IF @TheUserID IS NULL
	BEGIN
		set @ErrorDescribe = N'您的帐号不存在！'

		-- 输出变量
		SELECT @ErrorDescribe AS ErrorDescribe, @strAccount AS Accounts
		RETURN 0
	END	

	set @ErrorDescribe = N'您的帐号已存在！'

	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @strAccount AS Accounts
	RETURN 1
END

RETURN 1

GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_CheckNicKName]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_CheckNicKName]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 个人信息
CREATE PROC GSP_GP_CheckNicKName
	@strNickName NVARCHAR(31)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 辅助变量
DECLARE @TheUserID INT
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @TheUserID=UserID FROM AccountsInfo(NOLOCK) WHERE RegAccounts=@strNickName

	-- 查询用户
	IF @TheUserID IS NULL
	BEGIN
		set @ErrorDescribe = N'您的昵称不存在！'

		-- 输出变量
		SELECT @ErrorDescribe AS ErrorDescribe, @strNickName AS Accounts
		RETURN 0
	END	

	set @ErrorDescribe = N'您的昵称已存在！'

	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @strNickName AS Accounts
	RETURN 1
END

RETURN 1

GO
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_Register]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_Register]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 注册
CREATE PROC GSP_GP_Register
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strNickName NVARCHAR(31),					-- 用户昵称
	@strPhone NVARCHAR(31),						-- 用户手机
	@strPassword NCHAR(32),						-- 用户密码
	@cbGender TINYINT,						-- 用户性别
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineSerial NCHAR(32),					-- 机器标识
	@strChannel NVARCHAR(32)					-- 渠道号
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @ReturnCode INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @NickName NVARCHAR(31)

-- 扩展信息
DECLARE @Gender TINYINT
DECLARE @EnjoinRegister AS INT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN

	-- 效验名字
	IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strAccounts)>0)>0
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'抱歉地通知您，您所输入的帐号名含有限制字符串，请更换帐号名后再次申请帐号！'
		RETURN 3
	END

	-- 效验昵称
	IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strNickName)>0)>0
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'抱歉地通知您，您所输入的昵称含有限制字符串，请更换昵称后再次申请帐号！'
		RETURN 4
	END

	-- 效验地址
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'抱歉地通知您，系统禁止了您所在的 IP 地址的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 5
	END
	
	-- 效验机器
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineSerial AND GETDATE()<EnjoinOverDate
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'抱歉地通知您，系统禁止了您的机器的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 6
	END
 
	-- 查询用户
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'此帐号名已被注册，请换另一帐号名字尝试再次注册！'
		RETURN 7
	END

	-- 查询昵称
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE RegAccounts=@strNickName)
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'此昵称已被注册，请换另一昵称尝试再次注册！'
		RETURN 8
	END

	-- 注册用户
	IF @strPhone <> N''
	BEGIN
		INSERT AccountsInfo (Accounts,RegAccounts,Phone,LogonPass,InsurePass,Gender,MachineSerial,GameLogonTimes,RegisterIP,LastLogonIP,UnderWrite)
		VALUES (@strAccounts,@strNickName,@strPhone,@strPassword,N'',@cbGender,@strMachineSerial,1,@strClientIP,@strClientIP,@strChannel)
	END
	ELSE BEGIN
		INSERT AccountsInfo (Accounts,RegAccounts,LogonPass,InsurePass,Gender,MachineSerial,GameLogonTimes,RegisterIP,LastLogonIP,UnderWrite)
		VALUES (@strAccounts,@strNickName,@strPassword,N'',@cbGender,@strMachineSerial,1,@strClientIP,@strClientIP,@strChannel)
	END
	

	-- 错误判断
	IF @@ERROR<>0
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'帐号已存在，请换另一帐号名字尝试再次注册！'
		RETURN 9
	END
	ELSE BEGIN
		SET @ErrorDescribe = N'注册成功！'
	END

	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @strAccounts AS Accounts
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_IDUpdate]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_IDUpdate]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 升级
CREATE PROC GSP_GP_IDUpdate
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strAccountsNew NVARCHAR(31),					-- 用户新帐号
	@strNickName NVARCHAR(31),					-- 用户昵称
	@strPassword NCHAR(32),						-- 用户密码
	@cbGender TINYINT						-- 用户性别
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @ReturnCode INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @NickName NVARCHAR(31)

-- 扩展信息
DECLARE @Gender TINYINT
DECLARE @EnjoinUpdate AS INT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN

	-- 效验名字
	IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strAccountsNew)>0)>0
	BEGIN
		SELECT @strAccountsNew AS Accounts, [ErrorDescribe]=N'抱歉地通知您，您所输入的帐号名含有限制字符串，请更换帐号名后再次申请帐号！'
		RETURN 3
	END

	-- 效验昵称
	IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strNickName)>0)>0
	BEGIN
		SELECT @strAccountsNew AS Accounts, [ErrorDescribe]=N'抱歉地通知您，您所输入的昵称含有限制字符串，请更换昵称后再次申请帐号！'
		RETURN 4
	END

	-- 查询昵称
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE RegAccounts=@strNickName and Accounts!=@strAccounts)
	BEGIN
		SELECT @strAccountsNew AS Accounts, [ErrorDescribe]=N'此昵称已被注册，请换另一昵称尝试再次注册！'
		RETURN 8
	END

	-- 查询用户
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
	BEGIN
		--升级
		UPDATE AccountsInfo SET RegAccounts=@strNickName,Phone=@strAccountsNew,LogonPass=@strPassword,InsurePass=@strPassword,Gender=@cbGender,Accounts=@strAccountsNew,IsGuest=0
		WHERE Accounts=@strAccounts
		
		-- 错误判断
		IF @@ERROR<>0
		BEGIN
			SELECT @strAccountsNew AS Accounts, [ErrorDescribe]=N'升级帐号失败！'
			RETURN 9
		END
		ELSE BEGIN
			SELECT @strAccountsNew AS Accounts, [ErrorDescribe]=N'升级成功！'
			RETURN 0
		END
	END


	-- 输出变量
	SET @ErrorDescribe=N'原帐号不存在'
	SELECT @strAccountsNew AS Accounts, @ErrorDescribe AS ErrorDescribe
END

RETURN 10

GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserInfo]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 查询用户信息
CREATE PROC GSP_GP_UserInfo
	@strAccounts NVARCHAR(31)					-- 用户帐号
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @ReturnCode INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @NickName NVARCHAR(31)
DECLARE @Phone NVARCHAR(31)

-- 扩展信息
DECLARE @Gender TINYINT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID, @Gender=Gender, @NickName=RegAccounts, @Phone=Phone, @Accounts=Accounts
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	IF @UserID IS NULL 
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'帐号不存在！'
		RETURN 1
	END

	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @Gender AS Gender, @NickName AS NickName, @Phone AS Phone, @Accounts AS Accounts
	RETURN 0
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_ResetPwd]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_ResetPwd]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 设置密码
CREATE PROC GSP_GP_ResetPwd
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strPassword NVARCHAR(32)					-- 用户密码
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @ReturnCode INT

-- 扩展信息
DECLARE @Accounts NVARCHAR(31)

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	IF @UserID IS NULL 
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'帐号不存在！'
		RETURN 1
	END

	--升级
	UPDATE AccountsInfo SET LogonPass=@strPassword
	WHERE Accounts=@strAccounts

	-- 错误判断
	IF @@ERROR<>0
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'重设密码失败！'
		RETURN 9
	END
	ELSE BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'重设密码成功！'
		RETURN 0
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_ModifyIndividual]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_ModifyIndividual]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 修改用户信息
CREATE PROC GSP_GP_ModifyIndividual
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strNickName NVARCHAR(31),					-- 用户昵称
	@strPhone NCHAR(31),						-- 手机号
	@cbGender TINYINT						-- 用户性别
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @ReturnCode INT

-- 扩展信息

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	IF @UserID IS NULL 
	BEGIN
		SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'帐号不存在！'
		RETURN 1
	END

	--更新
	SET @ReturnCode = 0
	IF @strNickName <> N''
	BEGIN
		-- 效验昵称
		IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strNickName)>0)>0
		BEGIN
			SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'抱歉地通知您，您所输入的昵称含有限制字符串，请更换昵称。！'
			RETURN 4
		END

		-- 查询昵称
		IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE RegAccounts=@strNickName)
		BEGIN
			SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'此昵称已被注册，请换另一昵称！'
			RETURN 8
		END

		UPDATE AccountsInfo SET RegAccounts=@strNickName WHERE Accounts=@strAccounts

		-- 错误判断
		IF @@ERROR<>0
		BEGIN
			SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'修改昵称失败！'
			RETURN 9
		END
	END
	
	IF @strPhone <> N''
	BEGIN
		UPDATE AccountsInfo SET Phone=@strPhone WHERE Accounts=@strAccounts

		-- 错误判断
		IF @@ERROR<>0
		BEGIN
			SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'绑定手机失败！'
			RETURN 10
		END
	END

	IF @cbGender <> 0
	BEGIN
		UPDATE AccountsInfo SET Gender=@cbGender WHERE Accounts=@strAccounts

		-- 错误判断
		IF @@ERROR<>0
		BEGIN
			SELECT @strAccounts AS Accounts, [ErrorDescribe]=N'修改性别失败！'
			RETURN 11
		END
	END

	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @strAccounts AS Accounts
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_GetIDCard]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_GetIDCard]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 查询用户实名认证信息
CREATE PROC GSP_GP_GetIDCard
	@dwUserID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @IDName NVARCHAR(32)
DECLARE @IDCard NVARCHAR(32)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID, @IDName=IDName, @IDCard=IDCard  FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	IF @UserID IS NULL 
	BEGIN
		RETURN 1
	END

	-- 输出变量
	SELECT @IDName AS IDName, @IDCard AS IDCard
	RETURN 0
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_CommitIDCard]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_CommitIDCard]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 修改用户实名认证信息
CREATE PROC GSP_GP_CommitIDCard
	@dwUserID INT,
	@IDName NVARCHAR(32),
	@IDCard NVARCHAR(32)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	IF @UserID IS NULL 
	BEGIN
		RETURN 1
	END

	--更新
	UPDATE AccountsInfo SET IDName=@IDName, IDCard=@IDCard WHERE UserID=@dwUserID

	RETURN 0
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserBankInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserBankInfo]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 查询用户银行信息
CREATE PROC GSP_GP_UserBankInfo
	@dwUserID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	IF @UserID IS NULL 
	BEGIN
		RETURN 1
	END

	--是否被锁在游戏房间
	IF EXISTS (SELECT UserID FROM WHTreasureDB.dbo.GameScoreLocker WHERE UserID=@dwUserID)
	BEGIN
		RETURN 2
	END

	--查询财富
	SELECT Score AS curScore, BankScore AS bankScore FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserBankCharge]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserBankCharge]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 用户操作银行
CREATE PROC GSP_GP_UserBankCharge
	@nOpCode INT,
	@dwUserID INT,
	@dwCurScore INT,
	@dwBankScore INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @CurScore INT
DECLARE @BankScore INT
DECLARE @IncScore INT
DECLARE @DescScore INT

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	IF @UserID IS NULL 
	BEGIN
		RETURN 1
	END

	--是否被锁在游戏房间
	IF EXISTS (SELECT UserID FROM WHTreasureDB.dbo.GameScoreLocker WHERE UserID=@dwUserID)
	BEGIN
		RETURN 2
	END

	--查询财富
	SELECT @CurScore=Score, @BankScore=BankScore FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID
	IF @CurScore IS NULL 
	BEGIN
		RETURN 3
	END

	--财富总和不能变化
	SET @IncScore = @dwCurScore - @CurScore
	SET @DescScore = @BankScore - @dwBankScore
	IF @IncScore <>  @DescScore OR @dwCurScore < 0 OR @dwBankScore < 0
	BEGIN
		RETURN 4
	END

	--操作合法性
	IF @nOpCode = 1
	BEGIN
		--存
		IF (@dwCurScore >= @CurScore) OR (@dwBankScore <= @BankScore)
		BEGIN
			RETURN 6
		END
	END
	ELSE IF @nOpCode = 2
	BEGIN
		--取
		IF (@dwCurScore <= @CurScore) OR (@dwBankScore >= @BankScore)
		BEGIN
			RETURN 7
		END
	END
	ELSE
	BEGIN
		RETURN 5
	END

	--写库
	UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @IncScore, BankScore = BankScore - @DescScore WHERE UserID=@dwUserID
	--写日志
	INSERT INTO WHTreasureDB.dbo.GameBankLog(UserID, ExpectScore, ExpectBankScore, OpCode, PreScore, PreBankScore, IncScore, DescScore) VALUES(@dwUserID, @dwCurScore, @dwBankScore, @nOpCode, @CurScore, @BankScore, @IncScore, @DescScore)
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_GetActivityList]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_GetActivityList]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取活动列表
CREATE PROC GSP_GP_GetActivityList
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 输出变量
	SELECT TOP 5 ID,Type,Title,Text,IconUrl,LinkUrl,CASE 
		WHEN getdate()<BeginDate AND Type=2 THEN '1'
		WHEN getdate()>EndDate AND Type=2 THEN '3'
		WHEN Type=2 THEN '2'
		ELSE '0' END AS Status
	FROM UserActivity WHERE Deleted=0 ORDER BY OrderID

END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_GetActivity]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_GetActivity]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取活动
CREATE PROC GSP_GP_GetActivity
	@dwUserID INT,
	@dwActivityID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @CheckDate INT
DECLARE @UserID INT
DECLARE @KindID INT
DECLARE @MaxAmount INT
DECLARE @HadAmount INT
DECLARE @TotalAmount INT
DECLARE @DengAmount INT
DECLARE @Unit INT
DECLARE @ImageUrl NVARCHAR(50)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID
	IF @UserID IS NULL 
	BEGIN
		RETURN 1
	END

	-- 查询活动
	SELECT @KindID=KindID, @ImageUrl=ImageUrl, @Unit=CAST(Param AS INT) FROM UserActivity(NOLOCK) WHERE ID=@dwActivityID AND Deleted=0
	IF @KindID IS NULL 
	BEGIN
		RETURN 2
	END

	
	-- 校验数据：
	--校验活动时间
	SELECT @CheckDate=ID FROM UserActivity WHERE ID=@dwActivityID AND Deleted=0 AND getdate()>BeginDate AND getdate()<EndDate
	IF @CheckDate IS NULL 
	BEGIN
		SET @MaxAmount = 0
		SET @HadAmount = 0
		SET @TotalAmount = 0
	END
	ELSE
	BEGIN
		-- 统计数据
		SELECT @TotalAmount=Win4Activity+Lost4Activity+Flee4Activity FROM WHTreasureDB.dbo.GameToday(NOLOCK) WHERE UserID=@dwUserID AND KindID=@KindID
		SELECT @HadAmount=count(*) FROM UserActivityR(NOLOCK) WHERE UserID=@dwUserID AND ActivityID=@dwActivityID

		--转换成次数
		SET @MaxAmount = @TotalAmount / @Unit
	END

	-- 走马灯
	SELECT @DengAmount=count(*) FROM  UserActivityR(NOLOCK) WHERE ActivityID=@dwActivityID
	IF @DengAmount IS NULL
	BEGIN
		SELECT N'' AS UserName, N'' AS PrizeName,@ImageUrl AS ImageUrl, @MaxAmount AS M, @HadAmount AS N, @TotalAmount AS T, @Unit AS U
		RETURN 0
	END
	IF @DengAmount = 0
	BEGIN
		SELECT N'' AS UserName, N'' AS PrizeName,@ImageUrl AS ImageUrl, @MaxAmount AS M, @HadAmount AS N, @TotalAmount AS T, @Unit AS U
		RETURN 0
	END 

	-- 取消显示跑马灯内容
	--SELECT N'' AS UserName, N'' AS PrizeName,@ImageUrl AS ImageUrl, @MaxAmount AS M, @HadAmount AS N, @TotalAmount AS T, @Unit AS U
	--显示跑马灯内容，取前5个
	SELECT TOP 5 UserName,PrizeName,@ImageUrl AS ImageUrl, @MaxAmount AS M, @HadAmount AS N, @TotalAmount AS T, @Unit AS U
	FROM  UserActivityR(NOLOCK) WHERE ActivityID=@dwActivityID Order By Price Desc, ExchangeDate Desc

	RETURN 0
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_GetActivityLuckyList]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_GetActivityLuckyList]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 供抽奖的列表
CREATE PROC GSP_GP_GetActivityLuckyList
	@dwUserID INT,
	@dwActivityID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @UserID INT
DECLARE @KindID INT
DECLARE @MaxAmount INT
DECLARE @HadAmount INT
DECLARE @TotalAmount INT
DECLARE @Unit INT

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID
	IF @UserID IS NULL 
	BEGIN
		RETURN 1
	END

	-- 查询活动
	SELECT @KindID=KindID, @Unit=CAST(Param AS INT) FROM UserActivity(NOLOCK) WHERE ID=@dwActivityID AND Deleted=0
	IF @KindID IS NULL 
	BEGIN
		RETURN 2
	END

	-- 统计数据
	SELECT @TotalAmount=Win4Activity+Lost4Activity+Flee4Activity FROM WHTreasureDB.dbo.GameToday(NOLOCK) WHERE UserID=@dwUserID AND KindID=@KindID
	SELECT @HadAmount=count(*) FROM UserActivityR(NOLOCK) WHERE UserID=@dwUserID AND ActivityID=@dwActivityID
	
	-- 校验数据：
	--转换成次数
	SET @MaxAmount = @TotalAmount / @Unit
	IF @HadAmount >= @MaxAmount
	BEGIN
		RETURN 3
	END

	--可以供抽奖的商品
	SELECT PrizeID AS PID, PrizeUrl, Price, PrizeName, Stock, Possibility, MaxCount, 
		(SELECT count(*) FROM UserActivityR WHERE PrizeID = UserActivityPrize.PrizeID AND DateDiff(day, getdate(), ExchangeDate)=0) AS TodayCount
	FROM UserActivityPrize WHERE Deleted=0 AND ActivityID=@dwActivityID

END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_GetActivityLucky]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_GetActivityLucky]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------


-- 抽取指定商品
CREATE PROC GSP_GP_GetActivityLucky
	@dwUserID INT,
	@dwActivityID INT,
	@dwPrizeID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @UserID INT
DECLARE @szUserName NVARCHAR(32)
DECLARE @KindID INT
DECLARE @MaxAmount INT
DECLARE @HadAmount INT
DECLARE @TotalAmount INT
DECLARE @Unit INT
DECLARE @Stock INT
DECLARE @TotalCount INT
DECLARE @TodayCount INT
DECLARE @MaxCount INT
DECLARE @Price INT
DECLARE @PrizeType INT
DECLARE @szPrizeName NVARCHAR(49)
DECLARE @szPrizeUrl NVARCHAR(49)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @UserID=UserID, @szUserName=RegAccounts FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID
	IF @UserID IS NULL 
	BEGIN
		RETURN 1
	END

	-- 查询活动
	SELECT @KindID=KindID, @Unit=CAST(Param AS INT) FROM UserActivity(NOLOCK) WHERE ID=@dwActivityID AND Deleted=0 AND getdate()>BeginDate AND getdate()<EndDate
	IF @KindID IS NULL 
	BEGIN
		RETURN 2
	END

	-- 统计数据
	SELECT @TotalAmount=Win4Activity+Lost4Activity+Flee4Activity FROM WHTreasureDB.dbo.GameToday(NOLOCK) WHERE UserID=@dwUserID AND KindID=@KindID
	SELECT @HadAmount=count(*) FROM UserActivityR(NOLOCK) WHERE UserID=@dwUserID AND ActivityID=@dwActivityID
	
	-- 校验数据：
	--转换成次数
	SET @MaxAmount = @TotalAmount / @Unit
	IF @HadAmount >= @MaxAmount
	BEGIN
		RETURN 3
	END

	--可以供抽奖的商品
	SELECT @Price=Price, @szPrizeUrl=PrizeUrl, @szPrizeName=PrizeName, @Stock=Stock, @MaxCount=MaxCount,@PrizeType=PrizeType FROM UserActivityPrize WHERE  PrizeID=@dwPrizeID and ActivityID=@dwActivityID
	SELECT @TodayCount=count(*) FROM UserActivityR WHERE PrizeID=@dwPrizeID and ActivityID=@dwActivityID AND DateDiff(day, getdate(), ExchangeDate)=0

	--校验参数
	IF @Stock IS NULL
	BEGIN
		RETURN 4
	END

	IF @Stock <= 0
	BEGIN
		RETURN 5
	END

	IF @TodayCount >= @MaxCount
	BEGIN
		RETURN 6
	END

	--可以抽了
	UPDATE UserActivityPrize SET Stock = Stock -1 WHERE PrizeID=@dwPrizeID and ActivityID=@dwActivityID
	IF @PrizeType = 1
	BEGIN
		INSERT INTO UserActivityR(UserID, UserName, ActivityID, PrizeID, PrizeName, Price, Status, AttachInfo) 
			VALUES(@dwUserID, @szUserName, @dwActivityID, @dwPrizeID, @szPrizeName, @Price, N'已发放', N'System')
		--发欢乐豆
		UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @Price WHERE UserID=@dwUserID
	END
	ELSE
	BEGIN
		INSERT INTO UserActivityR(UserID, UserName, ActivityID, PrizeID, PrizeName, Price) 
			VALUES(@dwUserID, @szUserName, @dwActivityID, @dwPrizeID, @szPrizeName, @Price)
	END

	--输出结果
	SELECT @dwPrizeID AS PID, @szPrizeUrl AS PrizeUrl, @Price AS Price, @szPrizeName AS PrizeName
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_GetActivityRecord') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_GetActivityRecord
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 抽奖记录
CREATE PROC GSP_GP_GetActivityRecord
	@dwUserID INT,
	@dwActivityID INT,
	@nPage INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheTotal INT
DECLARE @TheFirst INT
DECLARE @TheSQL	NVARCHAR(512)

-- 执行逻辑
BEGIN
	--查询总数
	SELECT @TheTotal=count(*) FROM UserActivityR(NOLOCK) WHERE UserID=@dwUserID AND ActivityID=@dwActivityID

	-- 每页条
	set @TheFirst = 6*@nPage
	set @TheSQL=N'SELECT TOP 6 *,CONVERT(varchar,ExchangeDate,102)AS D,(select count(*) from UserActivityR WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N' AND ActivityID='
				+convert(varchar(10),@dwActivityID)
				+N')AS T FROM UserActivityR WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N' AND ActivityID='
				+convert(varchar(10),@dwActivityID)
				+N' AND(ID NOT IN(SELECT TOP '
				+convert(varchar(10),@theFirst)
				+N' ID FROM UserActivityR WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N' AND ActivityID='
				+convert(varchar(10),@dwActivityID)
				+N' ORDER BY ID DESC))ORDER BY ID DESC'

	exec sp_executesql @TheSQL;  
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
