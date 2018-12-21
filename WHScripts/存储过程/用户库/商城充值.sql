
USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserMallProduct') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserMallProduct
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 商城的商品(android)
CREATE PROC GSP_GP_UserMallProduct
	@dwUserID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	--查询节点
	SELECT productID,productPrice,productImg,productName, CASE 
		WHEN getdate()>HotBeginDate AND getdate()<HotEndDate THEN HotFlag
		ELSE 0 END AS HotFlag, CASE 
		WHEN getdate()>HotBeginDate AND getdate()<HotEndDate THEN ProductNameAdd
		ELSE N'' END AS ProductNameAdd
	FROM [WHGameUserDB].[dbo].[UserMallProduct] where Deleted=0 and Type=0 ORDER BY OrderID

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserMallProduct_IOS') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserMallProduct_IOS
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 商城的商品(ios)
CREATE PROC GSP_GP_UserMallProduct_IOS
	@dwUserID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	--查询节点
	SELECT productID,productPrice,productImg,productName, CASE 
		WHEN getdate()>HotBeginDate AND getdate()<HotEndDate THEN HotFlag
		ELSE 0 END AS HotFlag, CASE 
		WHEN getdate()>HotBeginDate AND getdate()<HotEndDate THEN ProductNameAdd
		ELSE N'' END AS ProductNameAdd
	FROM [WHGameUserDB].[dbo].[UserMallProduct] where Deleted=0 and Type=1 ORDER BY OrderID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserMallPlaceOrder]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserMallPlaceOrder]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 下订单
CREATE PROC GSP_GP_UserMallPlaceOrder
	@dwUserID INT,
	@dwProductID INT,
	@RechargeWay NVARCHAR(10)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheOrderNum NVARCHAR(20)
DECLARE @TheOrderState INT
DECLARE @TheOrderTime DATETIME
DECLARE @TheProductName NVARCHAR(20)
DECLARE @TheProductNameAdd NVARCHAR(20)
DECLARE @TheToken NVARCHAR(20)
DECLARE @TheproductPrice INT
DECLARE @TheProductBilling NVARCHAR(20)
DECLARE @TheRechargeScore INT
DECLARE @TheHotFlag TINYINT

-- 执行逻辑
BEGIN
	--日期部分为当前日期。
	DECLARE @TheTime varchar(20)
	set @TheTime = rtrim(convert(char,getdate(),102))+' '+(convert(char,getdate(),108)) 
	DECLARE @a datetime,@tmp varchar(20),@tmp1 varchar(20)
	set @a=convert(datetime,@TheTime)
	set @tmp=convert(char(8),@a,112)
	
	--set @tmp1=convert(char(6),datepart(hh,@a)*10000 + datepart(mi,@a)*100 + datepart(ss,@a))
	
	--set @tmp=@tmp+@tmp1

	DECLARE @date NVARCHAR(20)
	declare @num nvarchar(20)
	set @date = convert(VARCHAR(20),getdate(),112)--格式为20130117
	--set @date = rtrim(convert(char,getdate(),112))+''+(convert(char,getdate(),108))
	--判断表中是否存在当日的数据
	DECLARE @CountMax nvarchar(20)
	
	--select @CountMax = MAX(OrderID) FROM UserRechargeOrder WHERE convert(varchar(10),rtrim(ltrim(@date))) = convert(varchar(10),rtrim(ltrim(getdate())))
	--如果@CountMax不等于空，则表示表中有当日的数据

	--不存在就以日期加‘0001’为今日的第一条订单
	
	set @TheOrderNum =  '91' + @tmp +  '000001'
	SELECT @CountMax = MAX(OrderID) FROM UserRechargeOrder(NOLOCK)
	IF (@CountMax <> '')
		BEGIN
			
			--在今天取到的最大订单上取最右边（后面）6位数转为int型加一
			IF (@tmp = right(left(@CountMax,10),8))
				BEGIN
					set @num = convert(varchar(20),convert(int,right(@CountMax,6))+1)
					--用replicate函数,重复赋值‘0’，补上高位
					set @num = replicate('0',6-len(@num))+@num
				END
			ELSE
				BEGIN
					set @num = '000001'
				END
			--print @TheOrderNum
			set @TheOrderNum =  '91' + @tmp + @num
		END

	set @date = @a
	set @TheOrderState = 0

	-- 随机取一个6位数
	set @TheToken = cast(ceiling(rand() * 1000000) as int)

--	set @TheOrderTime = (select getdate())
	-- 查询商品表
	SELECT @TheProductName=ProductName,@TheProductPrice=productPrice,@TheProductBilling=BillingIndex,
	@TheProductNameAdd=(CASE 
		WHEN getdate()>HotBeginDate AND getdate()<HotEndDate THEN ProductNameAdd
		ELSE N'' END),
	@TheRechargeScore=(CASE 
		WHEN getdate()>HotBeginDate AND getdate()<HotEndDate THEN scoreNum+ScoreNumAdd
		ELSE scoreNum END ),
	@TheHotFlag=(CASE 
		WHEN getdate()>HotBeginDate AND getdate()<HotEndDate THEN HotFlag
		ELSE 0 END)
	FROM UserMallProduct(NOLOCK) WHERE @dwProductID = productID
--	SELECT @TheProductPrice = productPrice FROM UserMallProduct(NOLOCK) WHERE @dwProductID = productID
--	SELECT @TheProductBilling = BillingIndex FROM UserMallProduct(NOLOCK) WHERE @dwProductID = productID
--	SELECT @TheRechargeScore=scoreNum FROM UserMallProduct WHERE productID = @dwProductID


	--插入订单表
	INSERT INTO UserRechargeOrder(UserID,ProductID,OrderId,ProductName,ProductNameAdd,HotFlag,ProductPrice,RechargeDate,States,RechargeWay,TotalScore) VALUES(@dwUserID,@dwProductID,@TheOrderNum,@TheProductName,@TheProductNameAdd,@TheHotFlag,@TheProductPrice,@date,@TheOrderState,@RechargeWay,@TheRechargeScore)
	--插入token表
	INSERT INTO UserToken(UserID,ProductId,RechargeDate,Token,OrderId) VALUES(@dwUserID,@dwProductID,@date,@TheToken,@TheOrderNum)
	
	--输出变量
	SELECT @TheOrderNum AS dwOrderID, @TheProductName AS productName, @TheToken AS token, @TheproductPrice AS productPrice, @TheProductBilling AS billingIndex

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserCancelOrder') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserCancelOrder
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 取消订单
CREATE PROC GSP_GP_UserCancelOrder
	@dwOrderID nvarchar(20)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	--查询节点
	delete from UserRechargeOrder where OrderId= @dwOrderID
	--SELECT * FROM UserMallProduct(NOLOCK) WHERE Deleted=0 ORDER BY productID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserMallBuyResult') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserMallBuyResult
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 商城购买结果
CREATE PROC GSP_GP_UserMallBuyResult
	@dwOrderNum nvarchar(20)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT --玩家id
DECLARE @TheRechargeScore INT --充值的欢乐豆数
DECLARE @TheProductID INT
DECLARE @ThedwGoldScore INT --玩家的欢乐豆数

-- 辅助变量
DECLARE @TheState AS INT --支付状态

-- 执行逻辑
BEGIN
	--校验支付状态
	SELECT @TheState=States FROM UserRechargeOrder WHERE OrderID = @dwOrderNum
	IF @TheState<>0
	BEGIN
		RETURN 1 --已支付状态
	END

	--更新订单状态和时间
	UPDATE UserRechargeOrder SET States=1,HookDate=getdate() WHERE OrderID = @dwOrderNum
	--
	SELECT @TheUserID=UserID, @TheProductID=productID, @TheRechargeScore=TotalScore FROM UserRechargeOrder WHERE OrderID = @dwOrderNum
--	SELECT @TheRechargeScore=scoreNum FROM UserMallProduct WHERE productID = @TheProductID
	--更新玩家欢乐豆信息
	UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @TheRechargeScore WHERE UserID=@TheUserID
	SELECT @ThedwGoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@TheUserID

	--输出
	SELECT @TheUserID AS UserID, @TheProductID AS productID, @ThedwGoldScore AS dwGoldScore
	
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------



USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GP_UserMallUpdateResult') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GP_UserMallUpdateResult
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 商城更新结果
CREATE PROC GSP_GP_UserMallUpdateResult
	@dwOrderNum nvarchar(20)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT --玩家id
DECLARE @TheRechargeScore INT --充值的欢乐豆数
DECLARE @TheProductID INT
DECLARE @ThedwGoldScore INT --玩家的欢乐豆数

-- 辅助变量
DECLARE @TheState AS INT --支付状态

-- 执行逻辑
BEGIN
	--校验支付状态
	SELECT @TheState=States FROM UserRechargeOrder WHERE OrderID = @dwOrderNum
	IF @TheState<>0
	BEGIN
		RETURN 1 --已支付状态
	END

	--更新订单状态
	UPDATE UserRechargeOrder SET States=1,HookDate=getdate() WHERE OrderID = @dwOrderNum
	
	SELECT @TheUserID=UserID, @TheProductID=productID, @TheRechargeScore=TotalScore FROM UserRechargeOrder WHERE OrderID = @dwOrderNum
	--SELECT @TheRechargeScore=scoreNum FROM UserMallProduct WHERE productID = @TheProductID
	--更新玩家欢乐豆信息
	UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @TheRechargeScore WHERE UserID=@TheUserID
	SELECT @ThedwGoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@TheUserID

	--输出
	SELECT @TheUserID AS UserID, @TheProductID AS productID, @ThedwGoldScore AS dwGoldScore
	
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

