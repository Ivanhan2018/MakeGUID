
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_UserSignIn]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_UserSignIn]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- I D 登录
CREATE PROC GSP_GP_UserSignIn
	@dwUserID INT	
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @TheUserID INT
DECLARE @LatestTimes INT
DECLARE @TheTimes INT
DECLARE @TheLatestDate DATETIME
DECLARE @iScoreOne INT
DECLARE @iScoreTwo INT
DECLARE @iScoreThree INT
DECLARE @iScoreFour INT
DECLARE @iScoreFive INT

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

	--查配置
	--set @iScoreOne = 500
	--set @iScoreTwo = 800
	--set @iScoreThree = 1200
	--set @iScoreFour = 1500
	--set @iScoreFive = 2000
	SELECT @iScoreOne=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='qd_1'
	IF @iScoreOne IS NULL
	BEGIN
		set @ErrorDescribe = N'签到活动未启动！'
		RETURN 2
	END
	SELECT @iScoreTwo=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='qd_2'
	IF @iScoreTwo IS NULL
	BEGIN
		set @ErrorDescribe = N'签到活动未启动！'
		RETURN 3
	END
	SELECT @iScoreThree=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='qd_3'
	IF @iScoreThree IS NULL
	BEGIN
		set @ErrorDescribe = N'签到活动未启动！'
		RETURN 4
	END
	SELECT @iScoreFour=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='qd_4'
	IF @iScoreFour IS NULL
	BEGIN
		set @ErrorDescribe = N'签到活动未启动！'
		RETURN 5
	END
	SELECT @iScoreFive=value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and name='qd_5'
	IF @iScoreFive IS NULL
	BEGIN
		set @ErrorDescribe = N'签到活动未启动！'
		RETURN 6
	END

	-- 是否有签到
	SELECT @LatestTimes=Times,  @TheLatestDate=LatestDate
	FROM UserSignIn(NOLOCK) WHERE UserID=@dwUserID 

	IF @LatestTimes IS NULL
	BEGIN
		set @TheLatestDate =(select getdate())
		set @TheTimes = 1
		INSERT INTO UserSignIn(UserID, Times, LatestDate) VALUES(@dwUserID, @TheTimes, @TheLatestDate)
		set @ErrorDescribe = N'首次签到成功！'

		-- 加分
		UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @iScoreOne WHERE UserID=@dwUserID
		--日志:1表示签到
		INSERT INTO UserScoreLog(UserID, Type, Score) VALUES(@dwUserID, 1, @iScoreOne)

		-- 输出变量
		--	SELECT @TheTimes AS Times, @TheLatestDate AS LatestDate, @ErrorDescribe AS ErrorDescribe
		--	RETURN 0
	END
	ELSE
	BEGIN
		-- 查询今天是否签到
		set @LatestTimes = 0
		SELECT @LatestTimes=Times,  @TheLatestDate=LatestDate
		FROM UserSignIn(NOLOCK) WHERE UserID=@dwUserID and datediff(day,[LatestDate],getdate())=0 

		IF @LatestTimes > 0
		BEGIN
			set @ErrorDescribe = N'今天已经签到！'
			set @TheTimes = @LatestTimes
			-- 输出变量
			--SELECT @TheTimes AS Times, @TheLatestDate AS LatestDate, @ErrorDescribe AS ErrorDescribe
			--RETURN 0
		END
		ELSE
		BEGIN
			-- 查询昨天是否签到
			set @LatestTimes = 0
			SELECT @LatestTimes=Times,  @TheLatestDate=LatestDate
			FROM UserSignIn(NOLOCK) WHERE UserID=@dwUserID and datediff(day,[LatestDate],getdate())=1

			IF @LatestTimes > 0
			BEGIN
				set @ErrorDescribe = N'昨天已经签到！'
				set @TheLatestDate =(select getdate())
				set @TheTimes = @LatestTimes + 1
				-- 加分
				declare @iScore int
				declare @iStep int
				set @iStep = @TheTimes % 5
				IF @iStep = 0 
					set @iScore = @iScoreFive
				ELSE IF @iStep = 1
					set @iScore = @iScoreOne
				ELSE IF @iStep = 2
					set @iScore = @iScoreTwo
				ELSE IF @iStep = 3
					set @iScore = @iScoreThree
				ELSE IF @iStep = 4
					set @iScore = @iScoreFour
				UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @iScore WHERE UserID=@dwUserID

				UPDATE UserSignIn SET Times = @TheTimes, LatestDate = @TheLatestDate WHERE UserID=@dwUserID 
				--日志:1表示签到
				INSERT INTO UserScoreLog(UserID, Type, Score) VALUES(@dwUserID, 1, @iScore)
			END
			ELSE
			BEGIN
				set @TheLatestDate =(select getdate())
				set @TheTimes = 1
				set @ErrorDescribe = N'循环签到成功！'
				UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score + @iScoreOne WHERE UserID=@dwUserID
				UPDATE UserSignIn SET Times = @TheTimes, LatestDate = @TheLatestDate  WHERE UserID=@dwUserID 
				--日志:1表示签到
				INSERT INTO UserScoreLog(UserID, Type, Score) VALUES(@dwUserID, 1, @iScoreOne)
			END
		END
	END


	-- 输出变量
	SELECT @iScore=Score
	FROM WHTreasureDB.dbo.GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	SELECT @TheTimes AS Times, @TheLatestDate AS LatestDate, @ErrorDescribe AS ErrorDescribe, @iScore AS GoldScore

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
