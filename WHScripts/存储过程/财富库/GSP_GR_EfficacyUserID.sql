USE [WHTreasureDB]
GO
/****** Object:  StoredProcedure [dbo].[GSP_GR_EfficacyUserID]    Script Date: 2018/12/21 20:24:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec GSP_GR_EfficacyUserID 1103000,'d41d8cd98f00b204e9800998ecf8427e','127.0.0.1','',999,10010
----------------------------------------------------------------------------------------------------

-- I D 登录
create PROC [dbo].[GSP_GR_EfficacyUserID]
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineSerial NCHAR(32),				-- 机器标识
	@wKindID INT,								-- 游戏 I D
	@wServerID INT								-- 房间 I D
  AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @FaceID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @UnderWrite NVARCHAR(63)

-- 扩展信息
DECLARE @GameID INT
DECLARE @GroupID INT
DECLARE @UserRight INT
DECLARE @Gender TINYINT
DECLARE @Loveliness INT
DECLARE @MasterRight INT
DECLARE @MasterOrder INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @GroupName NVARCHAR(31)
DECLARE @CustomFaceVer TINYINT

-- 积分变量
DECLARE @GameGold INT
DECLARE @InsureScore INT
DECLARE @Score INT
DECLARE @WinCount INT
DECLARE @LostCount INT
DECLARE @DrawCount INT
DECLARE @FleeCount INT
DECLARE @Experience INT

DECLARE @gmaeKindId INT
DECLARE @gameServerID INT
DECLARE @paramsInfo NVARCHAR(256)
-- 道具信息
DECLARE @PropCount INT

-- 辅助变量
DECLARE @EnjoinLogon BIGINT
DECLARE @ErrorDescribe AS NVARCHAR(128)

DECLARE @TheVipOrder INT
-- 执行逻辑
BEGIN
	-- 效验地址
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，系统禁止了您所在的 IP 地址的游戏登录权限，请联系客户服务中心了解详细情况！'
		RETURN 8
	END
	
	-- 效验机器
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineSerial AND GETDATE()<EnjoinOverDate
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT [ErrorDescribe]=N'抱歉地通知您，系统禁止了您的机器的游戏登录权限，请联系客户服务中心了解详细情况！'
		RETURN 7
	END
 
	-- 查询用户
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @LogonPass AS NCHAR(32)
	DECLARE	@MachineSerial NCHAR(32)
	DECLARE @MoorMachine AS TINYINT
	SELECT @UserID=UserID, @GameID=GameID, @Accounts=RegAccounts, @LogonPass=LogonPass,
		@Gender=Gender, @Nullity=Nullity, @StunDown=StunDown, @Experience=Experience,
		@MoorMachine=MoorMachine, @MachineSerial=MachineSerial, @TheVipOrder = MemberOrder
	FROM WHGameUserDB.dbo.AccountsInfo WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 1
	END	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		--SELECT [ErrorDescribe]=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		--SELECT @paramsInfo = Comment FROM GMTaskLog WHERE UserID = @dwUserID
		-- 判断是否超过封号时间
		DECLARE @passDate DATETIME
		DECLARE @FinishDate DATETIME
		SET @passDate =( select max(StartDate) FROM [WHGameUserDB].[dbo].[GMTaskLog] where UserID = @UserID and TaskID = 2)
		-- 获取当前时间的解封时间
		SELECT @FinishDate = SubmitDate FROM [WHGameUserDB].[dbo].[GMTaskLog] where UserID = @UserID and StartDate = @passDate
		IF getDate() > @FinishDate and @passDate < @FinishDate 
		BEGIN
			SELECT [ErrorDescribe]=N'您的帐号已经解封，请重新登录！'
			-- 更新帐号信息
			UPDATE WHGameUserDB.dbo.AccountsInfo SET Nullity = 0 WHERE UserID=@UserID and Nullity = 1
			RETURN 5
		END	
		IF EXISTS (SELECT * FROM UserUnBind(NOLOCK) WHERE UserID=@UserID and (Type=1 or getDate()<FinishDate))
		BEGIN
			SELECT [ErrorDescribe]=N'您的帐号已经解封，请重新登录！'
			-- 更新帐号信息
			UPDATE WHGameUserDB.dbo.AccountsInfo SET Nullity = 0 WHERE UserID=@UserID and Nullity = 1
			RETURN 5
		END
		--SELECT @paramsInfo = Params FROM WHGameUserDB.dbo.GMTaskLog WHERE UserID=@dwUserID
		IF @passDate IS NULL
		BEGIN
			SELECT [ErrorDescribe]=N'您的帐号'+convert(varchar(15),@UserID)+N'由于长期未登录已被冻结，请联系客服解封.'
		END
		ELSE
		BEGIN
			SELECT [ErrorDescribe] = Params FROM WHGameUserDB.dbo.GMTaskLog 
			WHERE UserID=@UserID and TaskID = 2 and StartDate = ( select max(StartDate) FROM [WHGameUserDB].[dbo].[GMTaskLog] where UserID = @UserID)
		END
		
		RETURN 2
	END

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SELECT [ErrorDescribe]=N'您的帐号使用了安全关闭功能，必须到重新开通后才能继续使用！'
		RETURN 2
	END	
	
	-- 固定机器
	IF @MoorMachine=1
	BEGIN
		IF @MachineSerial<>@strMachineSerial
		BEGIN
			-- 找出锁在的游戏与房间
			SELECT @gmaeKindId=KindID, @gameServerID=ServerID FROM GameScoreLocker(NOLOCK) WHERE UserID=@dwUserID
		
			SELECT [ErrorDescribe] = CONVERT(varchar(10),@gmaeKindId) + '|' + CONVERT(varchar(10),@gameServerID)
			--SELECT [ErrorDescribe]=N'您的帐号使用固定机器登录功能，您现所使用的机器不是所指定的机器！'
			RETURN 1
		END
	END

	---- 密码判断
	--IF @LogonPass<>@strPassword
	--BEGIN
	--	SELECT [ErrorDescribe]=N'您的帐号不存在或者密码输入有误，请查证后再次尝试！',密码1=@LogonPass,密码2=@strPassword
	--	RETURN 3
	--END


	-- 房间锁定
	IF EXISTS (SELECT UserID FROM GameScoreLocker WHERE UserID=@dwUserID and ServerID!=@wServerID )
	BEGIN
		-- 找出锁在的游戏与房间
		SELECT @gmaeKindId=KindID, @gameServerID=ServerID FROM GameScoreLocker(NOLOCK) WHERE UserID=@dwUserID
		
		SELECT [ErrorDescribe] = CONVERT(varchar(10),@gmaeKindId) + '|' + CONVERT(varchar(10),@gameServerID)
		--SELECT [ErrorDescribe]=N'您已经在其他游戏房间了，不能同时在进入此游戏房间了！'
		RETURN 4
	END
	DELETE FROM GameScoreLocker WHERE UserID=@dwUserID
	INSERT GameScoreLocker (UserID,KindID,ServerID) VALUES (@dwUserID,@wKindID,@wServerID)

	-- 游戏信息
	SELECT @Score=Score, @InsureScore=InsureScore, @WinCount=WinCount, @LostCount=LostCount, @DrawCount=DrawCount,
		@DrawCount=DrawCount
	FROM GameScoreInfo WHERE UserID=@dwUserID

	-- 信息判断
	IF @Score IS NULL
	BEGIN
		SELECT [ErrorDescribe]=N'缺少记录！'
		RETURN 5
	END

	-- 更新信息
	UPDATE GameScoreInfo SET AllLogonTimes=AllLogonTimes+1, LastLogonDate=GETDATE(), LastLogonIP=@strClientIP WHERE UserID=@dwUserID

	-- 金币
	SET @GameGold=@Score

	-- 进入记录
	INSERT RecordUserEnter (UserID, Score, KindID, ServerID, ClientIP) VALUES (@UserID, @Score, @wKindID, @wServerID, @strClientIP)

		-- 游戏信息
	SELECT @WinCount=WinTotal, @LostCount=LostTotal, @FleeCount=FleeTotal
	FROM GameToday WHERE UserID = @dwUserID and KindID = @wKindID
	
	IF @FleeCount IS NULL
	BEGIN
		set @FleeCount = 0
		set @WinCount = 0
		set @LostCount = 0
		set @DrawCount = 0
	END
	-- 输出变量
	SELECT @UserID AS UserID, 0 AS GameID, 0 AS GroupID, @Accounts AS Accounts, N'' AS UnderWrite, 0 AS FaceID, 
		@Gender AS Gender, N'' AS GroupName, @TheVipOrder AS MemberOrder, 0 AS UserRight, 0 AS MasterRight, 
		0 AS MasterOrder, @TheVipOrder AS MemberOrder, @WinCount AS WinCount, @LostCount AS LostCount, 0 AS Loveliness,
		0 AS PropCount, @GameGold AS GameGold, 0 AS InsureScore, 0 AS Loveliness, 0 AS CustomFaceVer,
		@DrawCount AS DrawCount, @FleeCount AS FleeCount, @Score AS Score, @Experience AS Experience, @ErrorDescribe AS ErrorDescribe

END

RETURN 0

