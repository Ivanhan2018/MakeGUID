
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserWelfare]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserWelfare]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- I D 登录
CREATE PROC GSP_GP_UserWelfare
	@dwUserID INT,
	@TheLost INT output
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @LatestTimes INT
DECLARE @TheTimes INT
DECLARE @TheLatestDate DATETIME

-- 辅助变量
DECLARE @ErrorDescribe AS NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @TheUserID=UserID FROM WHTreasureDB.dbo.GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 查询用户
	IF @TheUserID IS NULL
	BEGIN
		set @ErrorDescribe = N'您的帐号不存在！'
		RETURN -1
	END	

	-- 查阈值
	declare @iCurScore int
	declare @iMaxCount int
	declare @iMaxScore int
	declare @iWelfareScore int
	declare @iBankCurScore int
	declare @iAllCurScore int
	set @iCurScore = 0
	set @iBankCurScore = 0
	set @iAllCurScore = 0
	--set @iMaxCount = 3
	--set @iMaxScore = 2000
	--set @iWelfareScore = 1000
	SELECT @iMaxCount=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='di_c'
	IF @iMaxCount IS NULL
	BEGIN
		set @ErrorDescribe = N'领低保活动未启动！'
		RETURN -4
	END
	SELECT @iMaxScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='di_s'
	IF @iMaxScore IS NULL
	BEGIN
		set @ErrorDescribe = N'领低保活动未启动！'
		RETURN -5
	END
	SELECT @iWelfareScore=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='di_w'
	IF @iWelfareScore IS NULL
	BEGIN
		set @ErrorDescribe = N'领低保活动未启动！'
		RETURN -6
	END

	SELECT @iCurScore=Score, @iBankCurScore=BankScore FROM WHTreasureDB.dbo.GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	-- 保险箱和当前存款之和
	set @iAllCurScore = @iCurScore + @iBankCurScore
	IF @iAllCurScore >= @iMaxScore
	BEGIN
		set @ErrorDescribe = N'财富超过最小值！'
		RETURN -2
	END

	-- 是否有领低保
	SELECT @LatestTimes=Times,  @TheLatestDate=LatestDate
	FROM UserWelfare(NOLOCK) WHERE UserID=@dwUserID 

	IF @LatestTimes IS NULL
	BEGIN
		set @TheLatestDate =(select getdate())
		set @TheTimes = 1
		INSERT INTO UserWelfare(UserID, Times, LatestDate) VALUES(@dwUserID, @TheTimes, @TheLatestDate)
		set @ErrorDescribe = N'首次领低保成功！'

		-- 加分
		UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @iWelfareScore WHERE UserID=@dwUserID
		--日志:2表示领低保
		INSERT INTO UserScoreLog(UserID, Type, Score) VALUES(@dwUserID, 2, @iWelfareScore)
	END
	ELSE
	BEGIN
		-- 查询今天是否签到
		set @LatestTimes = 0
		SELECT @LatestTimes=Times,  @TheLatestDate=LatestDate
		FROM UserWelfare(NOLOCK) WHERE UserID=@dwUserID and datediff(day,[LatestDate],getdate())=0 

		IF @LatestTimes >= @iMaxCount
		BEGIN
			set @ErrorDescribe = N'今天已经超出低保领取次数！'
			RETURN -3
		END
		ELSE IF @LatestTimes > 0
		BEGIN
			-- 可以再领低保
			set @TheLatestDate =(select getdate())
			UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @iWelfareScore WHERE UserID=@dwUserID
			UPDATE UserWelfare SET Times = Times + 1, LatestDate = @TheLatestDate WHERE UserID=@dwUserID 
			SET @TheTimes = @LatestTimes + 1
			--日志:2表示领低保
			INSERT INTO UserScoreLog(UserID, Type, Score) VALUES(@dwUserID, 2, @iWelfareScore)
		END
		ELSE
		BEGIN
			set @TheLatestDate =(select getdate())
			set @TheTimes = 1
			set @ErrorDescribe = N'循环领低保成功！'
			UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @iWelfareScore WHERE UserID=@dwUserID
			UPDATE UserWelfare SET Times = @TheTimes, LatestDate = @TheLatestDate WHERE UserID=@dwUserID 
			--日志:2表示领低保
			INSERT INTO UserScoreLog(UserID, Type, Score) VALUES(@dwUserID, 2, @iWelfareScore)
		END
	END

	-- 输出变量
	--SELECT @iCurScore=Score
	--FROM WHTreasureDB.dbo.GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	--SELECT @TheTimes AS Times, @TheLatestDate AS LatestDate, @ErrorDescribe AS ErrorDescribe, @iCurScore AS GoldScore

	SET @TheLost = @iMaxCount - @TheTimes
--	SELECT @TheTimes AS TheLost 

	RETURN @iWelfareScore
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
