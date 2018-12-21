
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserExchangeInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserExchangeInfo]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 个人信息
CREATE PROC GSP_GP_UserExchangeInfo
	@dwUserID INT,
	@strPhone NCHAR(31)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @TheGold INT
DECLARE @ThePhone AS NVARCHAR(31)

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
		RETURN 1
	END	

	-- 是否有兑换信息
	SELECT @TheGold=Gold,  @ThePhone=Phone
	FROM UserExchangeInfo(NOLOCK) WHERE UserID=@dwUserID 

	IF @TheGold IS NULL
	BEGIN
		set @TheGold = 0
		set @ThePhone = N''
		INSERT INTO UserExchangeInfo(UserID, Gold, Phone) VALUES(@dwUserID, @TheGold, @ThePhone)
		set @ErrorDescribe = N'首次提交兑换信息成功！'
	END
	ELSE
	BEGIN
		IF LEN(@strPhone) > 0
		BEGIN
			UPDATE UserExchangeInfo SET Phone = @strPhone WHERE UserID=@dwUserID 
			set @ErrorDescribe = N'更新信息成功！'
			set @ThePhone = @strPhone
		END
	END

	-- 输出变量
	SELECT @TheGold AS Gold, @ThePhone AS Phone, @ErrorDescribe AS ErrorDescribe

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserExchangeProduct') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserExchangeProduct
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 兑换的商品
CREATE PROC GSP_GP_UserExchangeProduct
	@dwUserID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	--查询节点
	SELECT * FROM UserExchangeProduct(NOLOCK) WHERE Deleted=0 ORDER BY OrderID,AwardID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserExchange]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserExchange]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 兑换
CREATE PROC GSP_GP_UserExchange
	@dwUserID INT,
	@dwAwardID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @TheGold INT
DECLARE @TheAwardID INT
DECLARE @TheLeft INT
DECLARE @ThePrice INT
DECLARE @TheExchangeDate DATETIME
DECLARE @ScoreNum INT
DECLARE @TheType INT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)
DECLARE @TheAwardName AS NVARCHAR(32)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @TheUserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 查询用户
	IF @TheUserID IS NULL
	BEGIN
		set @ErrorDescribe = N'您的帐号不存在！'
		RETURN 1
	END	

	-- 查询商品
	SELECT @TheAwardID=AwardID, @TheAwardName=AwardName, @TheLeft=Lefts, @ThePrice=Price, @ScoreNum=ScoreNum, @TheType=Type FROM UserExchangeProduct(NOLOCK) WHERE AwardID=@dwAwardID

	-- 查询商品
	IF @TheAwardID IS NULL
	BEGIN
		set @ErrorDescribe = N'商品不存在！'
		RETURN 2
	END

	-- 金豆是否够
	SELECT @TheGold=Gold FROM UserExchangeInfo(NOLOCK) WHERE UserID=@dwUserID 

	-- 是否有库存
	IF @TheLeft > 0 AND @TheGold >= @ThePrice
	BEGIN
		set @TheExchangeDate = (select getdate())
		set @TheGold = @TheGold - @ThePrice 
		UPDATE UserExchangeInfo SET Gold = @TheGold WHERE UserID = @dwUserID
		UPDATE UserExchangeProduct SET Lefts = Lefts - 1 WHERE AWARDID = @dwAwardID

		INSERT INTO UserExchgR(UserID, AwardID, AwardName, Price, ExchangeDate, TotalScore) VALUES(@dwUserID, @dwAwardID, @TheAwardName, @ThePrice, @TheExchangeDate, 0)

		set @ErrorDescribe = N'兑换成功！'

		IF @TheType = 1
		BEGIN
			--统计今天兑换欢乐豆消耗
			DECLARE @TheIDDou INT
			SELECT @TheIDDou=ID FROM WHTreasureDB.dbo.GameDayStatistics WHERE Type=5 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDDou IS NULL
			BEGIN
				INSERT INTO WHTreasureDB.dbo.GameDayStatistics(Type, Value) VALUES(5, @ThePrice)
			END
			ELSE
			BEGIN
				UPDATE WHTreasureDB.dbo.GameDayStatistics SET Value = Value + @ThePrice WHERE ID=@TheIDDou
			END
		END
		ELSE
		BEGIN
			--统计今天兑换话费消耗
			DECLARE @TheIDHua INT
			SELECT @TheIDHua=ID FROM WHTreasureDB.dbo.GameDayStatistics WHERE Type=4 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDHua IS NULL
			BEGIN
				INSERT INTO WHTreasureDB.dbo.GameDayStatistics(Type, Value) VALUES(4, @ThePrice)
			END
			ELSE
			BEGIN
				UPDATE WHTreasureDB.dbo.GameDayStatistics SET Value = Value + @ThePrice WHERE ID=@TheIDHua
			END

		END
	END
	ELSE
	BEGIN
		set @ErrorDescribe = N'库存不足！'
		RETURN 3
	END

	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @TheGold AS Gold, @TheAwardID AS AwardID, @ScoreNum AS TotalScore
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserExchange_V2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserExchange_V2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 兑换
CREATE PROC GSP_GP_UserExchange_V2
	@dwUserID INT,
	@dwAwardID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @TheGold INT
DECLARE @TheAwardID INT
DECLARE @TheLeft INT
DECLARE @ThePrice INT
DECLARE @TheExchangeDate DATETIME
DECLARE @ScoreNum INT
DECLARE @TheType INT

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)
DECLARE @TheAwardName AS NVARCHAR(32)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @TheUserID=UserID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 查询用户
	IF @TheUserID IS NULL
	BEGIN
		set @ErrorDescribe = N'您的帐号不存在！'
		RETURN 1
	END	

	-- 查询商品
	SELECT @TheAwardID=AwardID, @TheAwardName=AwardName, @TheLeft=Lefts, @ThePrice=Price, @ScoreNum=ScoreNum, @TheType=Type FROM UserExchangeProduct(NOLOCK) WHERE AwardID=@dwAwardID

	-- 查询商品
	IF @TheAwardID IS NULL
	BEGIN
		set @ErrorDescribe = N'商品不存在！'
		RETURN 2
	END

	-- 金豆是否够
	SELECT @TheGold=Gold FROM UserExchangeInfo(NOLOCK) WHERE UserID=@dwUserID 

	-- 是否有库存
	IF @TheLeft > 0 AND @TheGold >= @ThePrice
	BEGIN
		set @TheExchangeDate = (select getdate())
		set @TheGold = @TheGold - @ThePrice 
		UPDATE UserExchangeInfo SET Gold = @TheGold WHERE UserID = @dwUserID
		UPDATE UserExchangeProduct SET Lefts = Lefts - 1 WHERE AWARDID = @dwAwardID

		--发放欢乐豆
		IF @TheType = 1
		BEGIN
			INSERT INTO UserExchgR(UserID, AwardID, AwardName, Price, ExchangeDate, TotalScore, Status, AttachInfo) VALUES(@dwUserID, @dwAwardID, @TheAwardName, @ThePrice, @TheExchangeDate, @ScoreNum, N'已发放', N'system')
			UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @ScoreNum WHERE UserID = @dwUserID
			SELECT @ScoreNum = Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID = @dwUserID

			--统计今天兑换欢乐豆消耗
			DECLARE @TheIDDou INT
			SELECT @TheIDDou=ID FROM WHTreasureDB.dbo.GameDayStatistics WHERE Type=5 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDDou IS NULL
			BEGIN
				INSERT INTO WHTreasureDB.dbo.GameDayStatistics(Type, Value) VALUES(5, @ThePrice)
			END
			ELSE
			BEGIN
				UPDATE WHTreasureDB.dbo.GameDayStatistics SET Value = Value + @ThePrice WHERE ID=@TheIDDou
			END
		END
		ELSE
		BEGIN
			INSERT INTO UserExchgR(UserID, AwardID, AwardName, Price, ExchangeDate, TotalScore) VALUES(@dwUserID, @dwAwardID, @TheAwardName, @ThePrice, @TheExchangeDate, @ScoreNum)

			--统计今天兑换话费消耗
			DECLARE @TheIDHua INT
			SELECT @TheIDHua=ID FROM WHTreasureDB.dbo.GameDayStatistics WHERE Type=4 AND DATEDIFF(day,CollectDate,GETDATE())=0 
			IF @TheIDHua IS NULL
			BEGIN
				INSERT INTO WHTreasureDB.dbo.GameDayStatistics(Type, Value) VALUES(4, @ThePrice)
			END
			ELSE
			BEGIN
				UPDATE WHTreasureDB.dbo.GameDayStatistics SET Value = Value + @ThePrice WHERE ID=@TheIDHua
			END
		END

		set @ErrorDescribe = N'兑换成功！'
	END
	ELSE
	BEGIN
		set @ErrorDescribe = N'库存不足！'
		RETURN 3
	END

	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @TheGold AS Gold, @TheAwardID AS AwardID, @ScoreNum AS TotalScore
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserExchangeRecord') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserExchangeRecord
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 兑换记录
CREATE PROC GSP_GP_UserExchangeRecord
	@dwUserID INT,
	@nPage INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheTotal INT
DECLARE @TheFirst INT
DECLARE @TheSQL	NVARCHAR(256)

-- 执行逻辑
BEGIN
	--查询总数
	SELECT @TheTotal=count(*) FROM UserExchgR(NOLOCK) WHERE UserID=@dwUserID

	-- 每页条
	set @TheFirst = 6*@nPage
	set @TheSQL=N'SELECT TOP 6 *,CONVERT(varchar,ExchangeDate,102)AS D,(select count(*) from UserExchgR WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N')AS T FROM UserExchgR WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N' AND(ID NOT IN(SELECT TOP '
				+convert(varchar(10),@theFirst)
				+N' ID FROM UserExchgR WHERE UserID='
				+convert(varchar(10),@dwUserID)
				+N' ORDER BY ID DESC))ORDER BY ID DESC'

	exec sp_executesql @TheSQL;  
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
