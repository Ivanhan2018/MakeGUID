
----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetBbsPop]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetBbsPop]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取弹窗公告
CREATE PROC GSP_GR_GetBbsPop
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 输出变量: Details,Action,滚动公告的条数，列表公告的最新3个ID值
	SELECT TOP 1 Details,Action,(SELECT COUNT(*) FROM GameBBS WHERE IsValid=1 AND Type = 2) AS ScrollCount,
	(SELECT COUNT(*) FROM GameBBS WHERE IsValid=1 AND Type = 3) AS ListCount,
	(SELECT Top 1 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 ORDER BY Date DESC) AS List1,
	(SELECT Top 1 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ID NOT IN(SELECT Top 1 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 ORDER BY Date DESC)ORDER BY Date DESC) AS List2,
	(SELECT Top 1 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ID NOT IN(SELECT Top 2 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 ORDER BY Date DESC)ORDER BY Date DESC) AS List3
	FROM GameBBS WHERE IsValid=1 AND Type = 1 ORDER BY Date DESC
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetBbsScroll]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetBbsScroll]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取滚动公告
CREATE PROC GSP_GR_GetBbsScroll
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 输出变量
	SELECT TOP 10 Title FROM GameBBS WHERE IsValid=1 AND Type = 2 ORDER BY Date DESC
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetBbsList]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetBbsList]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取列表公告
CREATE PROC GSP_GR_GetBbsList
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	-- 输出变量
	SELECT TOP 3 ID,Title,Details,Action,CONVERT(varchar(11),Date,120)AS D FROM GameBBS WHERE IsValid=1 AND Type = 3 ORDER BY Date DESC
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetBbsPop_V2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetBbsPop_V2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取弹窗公告
CREATE PROC GSP_GR_GetBbsPop_V2
	@szChannelName	NVARCHAR(32)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @ClientName AS NVARCHAR(32)

-- 执行逻辑
BEGIN
	IF LEN(@szChannelName) = 0 OR @szChannelName IS NULL
	BEGIN
		--默认值
		SET @ClientName = N'%'
	END
	ELSE
	BEGIN
		SET @ClientName =  substring(@szChannelName, 1, 2) + N'%'
	END

	-- 输出变量: Details,Action,滚动公告的条数，列表公告的最新3个ID值
	SELECT TOP 1 Details,Action,(SELECT COUNT(*) FROM GameBBS WHERE IsValid=1 AND Type = 2 AND ClientName LIKE @ClientName) AS ScrollCount,
	(SELECT COUNT(*) FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ClientName LIKE @ClientName) AS ListCount,
	(SELECT Top 1 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ClientName LIKE @ClientName ORDER BY Date DESC) AS List1,
	(SELECT Top 1 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ClientName LIKE @ClientName AND ID NOT IN(SELECT Top 1 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ClientName LIKE @ClientName ORDER BY Date DESC)ORDER BY Date DESC) AS List2,
	(SELECT Top 1 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ClientName LIKE @ClientName AND ID NOT IN(SELECT Top 2 ID FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ClientName LIKE @ClientName ORDER BY Date DESC)ORDER BY Date DESC) AS List3
	FROM GameBBS WHERE IsValid=1 AND Type = 1 AND ClientName LIKE @ClientName ORDER BY Date DESC
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetBbsScroll_V2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetBbsScroll_V2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取滚动公告
CREATE PROC GSP_GR_GetBbsScroll_V2
	@szChannelName	NVARCHAR(32)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @ClientName AS NVARCHAR(32)

-- 执行逻辑
BEGIN
	IF LEN(@szChannelName) = 0 OR @szChannelName IS NULL
	BEGIN
		--默认值
		SET @ClientName = N'%'
	END
	ELSE
	BEGIN
		SET @ClientName =  substring(@szChannelName, 1, 2) + N'%'
	END

	-- 输出变量
	SELECT TOP 10 Title FROM GameBBS WHERE IsValid=1 AND Type = 2 AND ClientName LIKE @ClientName ORDER BY Date DESC
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetBbsList_V2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetBbsList_V2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取列表公告
CREATE PROC GSP_GR_GetBbsList_V2
	@szChannelName	NVARCHAR(32)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @ClientName AS NVARCHAR(32)

-- 执行逻辑
BEGIN
	IF LEN(@szChannelName) = 0 OR @szChannelName IS NULL
	BEGIN
		--默认值
		SET @ClientName = N'%'
	END
	ELSE
	BEGIN
		SET @ClientName =  substring(@szChannelName, 1, 2) + N'%'
	END

	-- 输出变量
	SELECT TOP 3 ID,Title,Details,Action,CONVERT(varchar(11),Date,120)AS D FROM GameBBS WHERE IsValid=1 AND Type = 3 AND ClientName LIKE @ClientName ORDER BY Date DESC
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_GetKeFu]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_GetKeFu]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 获取用户反馈
CREATE PROC GSP_GR_GetKeFu
	@dwUserID INT,
	@nPage INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @TheFirst INT
DECLARE @TheSQL	NVARCHAR(256)

-- 执行逻辑
BEGIN
	-- 每页条
	set @TheFirst = 6*@nPage
	set @TheSQL=N'SELECT TOP 6 *,CONVERT(varchar,Date,102)AS D,(select count(*) from GameKeFu WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N')AS T FROM GameKeFu WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N' AND(ID NOT IN(SELECT TOP '
				+convert(varchar(10),@theFirst)
				+N' ID FROM GameKeFu WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N' ORDER BY ID DESC))ORDER BY ID DESC'

	exec sp_executesql @TheSQL; 
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_CommitKeFu]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_CommitKeFu]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 提交用户反馈
CREATE PROC GSP_GR_CommitKeFu
	@dwUserID	INT,
	@Question	NVARCHAR(512),
	@AttachPath	NVARCHAR(127)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @ChannelName AS NVARCHAR(32)

-- 执行逻辑
BEGIN
	--根据用户查询Channel
	SELECT @ChannelName=UnderWrite FROM WHGameUserDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	IF @ChannelName IS NULL
	BEGIN
		SET @ChannelName = N''
	END
	INSERT INTO GameKeFu(UserID, Question, AttachPath, ChannelName) VALUES(@dwUserID, @Question, LTRIM(RTRIM(@AttachPath)), @ChannelName)
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_CommitOnline]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_CommitOnline]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 提交最高在线
CREATE PROC GSP_GR_CommitOnline
	@dwTypeID	INT,
	@dwValue	INT,
	@DateCollect	NVARCHAR(32)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	DECLARE @TheID INT
	SELECT @TheID=ID FROM WHTreasureDB.dbo.GameDayStatistics(NOLOCK) WHERE Type=@dwTypeID AND DATEDIFF(day,CollectDate,@DateCollect)=0 
	IF @TheID IS NULL
	BEGIN
		INSERT INTO WHTreasureDB.dbo.GameDayStatistics(Type, Value, CollectDate) VALUES(@dwTypeID, @dwValue, @DateCollect)
	END
	ELSE
	BEGIN
		UPDATE WHTreasureDB.dbo.GameDayStatistics SET Value = @dwValue,CollectDate=@DateCollect WHERE ID=@TheID
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserSpeakerSend]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserSpeakerSend]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 提交喇叭
CREATE PROC GSP_GP_UserSpeakerSend
	@dwUserID	INT,
	@wType		INT,
	@szMsg		NVARCHAR(256)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

declare @iSpreakerScore int
declare @iCurScore int
declare @szAccount NVARCHAR(33)

-- 执行逻辑
BEGIN
	IF @wType = 1
	BEGIN
		-- 查询用户
		SELECT @szAccount=Accounts FROM WHGameUserDB.dbo.AccountsInfo(NOLOCK) WHERE UserID=@dwUserID
		IF @szAccount IS NULL 
		BEGIN
			-- 输出变量
			SELECT 0 AS Score
			RETURN 1
		END

		-- 房间锁定
		IF EXISTS (SELECT UserID FROM WHTreasureDB.dbo.GameScoreLocker WHERE UserID=@dwUserID)
		BEGIN
			SELECT 0 AS Score
			RETURN 4
		END

		--用户喇叭，要校验财富
		-- 查阈值
		set @iCurScore = 0
		SELECT @iSpreakerScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='speaker'
		IF @iSpreakerScore IS NULL
		BEGIN
			-- 输出变量
			SELECT 0 AS Score
			RETURN 2
		END
		SELECT @iCurScore=Score FROM WHTreasureDB.dbo.GameScoreInfo  WHERE UserID=@dwUserID
		IF @iSpreakerScore > @iCurScore
		BEGIN
			-- 输出变量
			SELECT @iCurScore AS Score
			RETURN 3
		END

		--扣财富
		UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score - @iSpreakerScore WHERE UserID=@dwUserID
		SET @iCurScore = @iCurScore - @iSpreakerScore
	END
	ELSE
	BEGIN
		SET @iCurScore = 0
		SET @szAccount = N'system'
	END

	--写日志
	INSERT INTO GameSpeaker(UserID, Account, Txt, Type) VALUES(@dwUserID, @szAccount, @szMsg, @wType)

	-- 输出变量
	SELECT @iCurScore AS Score
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHServerInfoDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_UserQueryConfig]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_UserQueryConfig]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 查询配置
CREATE PROC GSP_UserQueryConfig
	@dwUserID	INT,
	@dwVersion	INT,
	@dwConfigID	INT,
	@szChannel	NVARCHAR(32)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON
declare @ClientName NVARCHAR(32)

-- 执行逻辑
BEGIN
	IF LEN(@szChannel) = 0 OR @szChannel IS NULL
	BEGIN
		--默认值
		SET @ClientName = N'%'
	END
	ELSE
	BEGIN
		SET @ClientName =  substring(@szChannel, 1, 2) + N'%'
	END

	SELECT K,V FROM UserConfig WHERE (Version = @dwVersion or Version = 0) and (UserID = @dwUserID or UserID = 0) and (ConfigID = @dwConfigID or ConfigID = 0) and IsValid = 1 and ClientName like @ClientName Order by OrderID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
