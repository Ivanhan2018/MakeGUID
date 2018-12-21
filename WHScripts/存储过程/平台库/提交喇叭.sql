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