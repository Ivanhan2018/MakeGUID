
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_CheckGMTask]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_CheckGMTask]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 检查GM工具发放的财富
CREATE PROC GSP_GP_CheckGMTask
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
DECLARE @OldPhone NVARCHAR(32)
DECLARE @OldPwd NVARCHAR(32)
DECLARE @OldScore BIGINT
DECLARE @OldBankScore BIGINT
DECLARE @DelScoreTotal INT
DECLARE @DelScore INT
DECLARE @DelBankScore INT
DECLARE @IsGuest INT
DECLARE @ThePasswordX AS NVARCHAR(32)

DECLARE @CurMinute INT
DECLARE @OldGold INT


-- 执行逻辑
BEGIN
	-- TODO:放在这里不太合适，偷点小懒：每个小时执行一次的任务
	SELECT @CurMinute=DateName(minute,GetDate())
	-- 因为此存储过程会2分钟触发一次
	IF @CurMinute < 2
	BEGIN
		INSERT INTO WHTreasureDB.dbo.TotalScoreLog(Total, Score, BankScore) SELECT sum(Score)+sum(BankScore),sum(Score),sum(BankScore) FROM WHTreasureDB.dbo.GameScoreInfo
	END

	--TODO:复用一下定时器,检查是否有活动要即将开始,如果有，要做数据清理。因为此存储过程会2分钟触发一次，所以这里选择3分钟，至少会执行一次
	DECLARE c2 cursor for SELECT KindID FROM  UserActivity WHERE Deleted=0 AND DateDiff(minute,BeginDate,GetDate()) > -4 AND DateDiff(minute,BeginDate,GetDate()) < 0
        DECLARE @kindid int
        OPEN c2  
        FETCH c2 INTO @kindid
        WHILE @@fetch_status=0  
        BEGIN  
		--清理数据
		UPDATE WHTreasureDB.dbo.GameToday SET Win4Activity=0,Lost4Activity=0,Flee4Activity=0 WHERE KindID=@kindid
	END 
	CLOSE c2
	DEALLOCATE c2

	--TODO:清掉超时6h被锁定的帐号
	DELETE FROM WHTreasureDB.dbo.GameScoreLocker where datediff(mi , CollectDate ,getdate()) > 360

	--检查公告系统
	UPDATE WHServerInfoDB.dbo.GameBBS SET IsValid=1 WHERE getdate() > StartDate AND getdate() < EndDate AND IsValid != 1
	UPDATE WHServerInfoDB.dbo.GameBBS SET IsValid=0 WHERE getdate() >= EndDate AND IsValid != 0

	-- 查询任务。每个周期只执行前5条任务
	DECLARE c1 cursor for SELECT Top 50 ID,TaskID,UserID,Params from  GMTask WHERE getdate() >= StartDate order by Priority asc
        DECLARE @id int, @taskid int, @userid int, @params VARCHAR(256), @passwd VARCHAR(9)
        OPEN c1  
        FETCH c1 INTO @id, @taskid,@userid,@params
        WHILE @@fetch_status=0  
        BEGIN  
		IF @taskid = 1
		BEGIN
			--发财富任务
			EXEC dbo.GSP_GP_CheckUserGMScore @userid
		END
		ELSE IF @taskid = 7
		BEGIN
			--发第三方系统财富任务

			INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'发第三方财富' FROM GMTask WHERE ID=@id
		--需要定制	EXEC dbo.GSP_GP_UserExtendThirdAccount @userid
			DELETE FROM GMTask WHERE ID=@id
		END
		ELSE IF @taskid = 8
		BEGIN
			--发金豆
			INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'发金豆' FROM GMTask WHERE ID=@id
			
			--是否原来就有
			SELECT @OldGold=Gold FROM UserExchangeInfo Where UserID=@userid
			IF @OldGold IS NULL
			BEGIN
				INSERT INTO UserExchangeInfo(UserID, Gold) VALUES(@userid, convert(int,@params))
			END
			ELSE
			BEGIN
				UPDATE UserExchangeInfo SET Gold=Gold+convert(int,@params) WHERE UserID=@userid
			END

			DELETE FROM GMTask WHERE ID=@id
		END
		ELSE IF @taskid = 9
		BEGIN
			--系统喇叭任务，这里不处理，在另一个存储过程中处理
			SET @taskid = 9
		END
		ELSE IF @taskid = 6
		BEGIN
			--扣财富任务:会扣银行的
			-- 游戏信息
			SELECT @OldScore=Score,@OldBankScore=BankScore FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@userid
			SET @DelScoreTotal = convert(int,@params)
			-- 信息判断
			IF @OldScore IS NOT NULL
			BEGIN
				SET @DelScore = 0
				SET @DelBankScore = 0
				--开始扣分:先从银行扣
				IF @DelScoreTotal > @OldBankScore
				BEGIN
					SET @DelBankScore = @OldBankScore
				END
				ELSE
				BEGIN
					SET @DelBankScore = @DelScoreTotal
				END

				SET @DelScoreTotal = @DelScoreTotal - @DelBankScore

				IF @DelScoreTotal > @OldScore
				BEGIN
					SET @DelScore = @OldScore
				END
				ELSE
				BEGIN
					SET @DelScore = @DelScoreTotal
				END

				SET @DelScoreTotal = @DelScoreTotal - @DelScore

				IF @DelScoreTotal > 0
				BEGIN
					INSERT INTO GMTaskLog SELECT *,getdate(),N'失败',N'财富不足' FROM GMTask WHERE ID=@id
				END
				ELSE
				BEGIN
					INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'扣银行'+convert(varchar(32),@DelBankScore)+N'钱包'+convert(varchar(32),@DelScore)+N'原'+convert(varchar(32),@OldBankScore)+N'/'+convert(varchar(32),@OldScore) FROM GMTask WHERE ID=@id
					UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score - @DelScore, BankScore = BankScore - @DelBankScore WHERE UserID=@userid
				END
				DELETE FROM GMTask WHERE ID=@id
			END
		END
		ELSE IF @taskid = 2
		BEGIN
			-- 封号
			INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'封号'+convert(varchar(32),@userid) FROM GMTask WHERE ID=@id
			EXEC dbo.GSP_GR_CongealAccounts @userid,0,N''
			DELETE FROM GMTask WHERE ID=@id
		END
		ELSE IF @taskid = 5
		BEGIN
			-- 解封
			INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'解封'+convert(varchar(32),@userid) FROM GMTask WHERE ID=@id
			EXEC dbo.GSP_GR_UnCongealAccounts @userid,0,N''
			DELETE FROM GMTask WHERE ID=@id
		END
		ELSE IF @taskid = 3
		BEGIN
			-- 更新手机号
			SELECT @OldPhone=Phone FROM AccountsInfo(NOLOCK) WHERE UserID=@userid
			INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'原手机号'+@OldPhone FROM GMTask WHERE ID=@id
			UPDATE AccountsInfo SET Phone=@params WHERE UserID=@userid
			DELETE FROM GMTask WHERE ID=@id
		END
		ELSE IF @taskid = 4
		BEGIN
			-- 设置密码
			SELECT @OldPwd=LogonPass, @IsGuest=IsGuest FROM AccountsInfo(NOLOCK) WHERE UserID=@userid
			SET @passwd = substring(@params, 1, 9)
			SET @ThePasswordX = substring(sys.fn_VarBinToHexStr(hashbytes('MD5',@passwd)),3,32)
			IF @IsGuest = 1
			BEGIN
				INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'游客，原密码'+@OldPwd FROM GMTask WHERE ID=@id
				UPDATE AccountsInfo SET LogonPass=@ThePasswordX,InsurePass=@params WHERE UserID=@userid and IsGuest = 1
			END
			ELSE
			BEGIN
				INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'原密码'+@OldPwd FROM GMTask WHERE ID=@id
				UPDATE AccountsInfo SET LogonPass=@ThePasswordX WHERE UserID=@userid and IsGuest = 0
			END
			DELETE FROM GMTask WHERE ID=@id
		END
		ELSE IF @taskid = 10
		BEGIN
			-- 消耗财富：仅扣钱包的

			--是否被锁在游戏房间
			IF NOT EXISTS (SELECT UserID FROM WHTreasureDB.dbo.GameScoreLocker WHERE UserID=@userid)
			BEGIN
				-- 游戏信息
				SELECT @OldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@userid
				SET @DelScoreTotal = convert(int,@params)
				-- 信息判断
				IF @OldScore IS NOT NULL
				BEGIN
					IF @DelScoreTotal > @OldScore
					BEGIN
						INSERT INTO GMTaskLog SELECT *,getdate(),N'失败',N'财富不足' FROM GMTask WHERE ID=@id
					END
					ELSE
					BEGIN
						INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'钱包'+convert(varchar(32),@DelScoreTotal)+N'原'+convert(varchar(32),@OldScore) FROM GMTask WHERE ID=@id
						UPDATE WHTreasureDB.dbo.GameScoreInfo SET Score = Score - @DelScoreTotal WHERE UserID=@userid
					END
					DELETE FROM GMTask WHERE ID=@id
				END
			END
		END
		ELSE
		BEGIN
			-- 不支持的任务
			INSERT INTO GMTaskLog SELECT *,getdate(),N'不支持',N'此任务暂不支持' FROM GMTask WHERE ID=@id
			DELETE FROM GMTask WHERE ID=@id
		END

		FETCH c1 INTO @id,@taskid,@userid,@params  
        END 
	CLOSE c1
	DEALLOCATE c1
END

RETURN 0

GO



----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_CheckSpeakerTask]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_CheckSpeakerTask]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 检查GM工具发放的系统喇叭
CREATE PROC GSP_GP_CheckSpeakerTask
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @Params NVARCHAR(256)
DECLARE @UserID INT
DECLARE @ID INT

-- 执行逻辑
BEGIN

	SELECT top 1 @ID=ID, @UserID=UserID, @Params=Params FROM GMTask where TaskID=9 and getdate() >=StartDate order by StartDate
	IF @ID IS NULL
	BEGIN
		RETURN 0
	END

	INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'系统喇叭' FROM GMTask WHERE ID=@id
	DELETE FROM GMTask WHERE ID=@id

	SELECT @UserID AS UserID, @Params As Params
END

RETURN 0

GO



----------------------------------------------------------------------------------------------------
--因为权限问题，不能使用触发器。改成计划任务。
-------USE WHGameUserDB
-------GO

-------IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[TR_GP_GMTask]') and OBJECTPROPERTY(ID, N'IsTrigger') = 1)
-------DROP TRIGGER [dbo].[TR_GP_GMTask]
-------GO

-------CREATE TRIGGER TR_GP_GMTask On GMTask FOR INSERT
-------AS

-- 扩展信息
-------DECLARE @OldPhone NVARCHAR(32)
-------DECLARE @OldPwd NVARCHAR(32)
-------DECLARE @IsGuest INT
-------DECLARE @ThePasswordX AS NVARCHAR(32)
-------DECLARE @id int, @taskid int, @userid int, @params VARCHAR(32), @passwd VARCHAR(9)
-------
-------	SELECT @id=ID, @taskid=TaskID, @userid=UserID, @params=Params, @passwd=Params from inserted
-------	IF @taskid = 1
-------	BEGIN
-------		--发财富任务
-------		EXEC dbo.GSP_GP_CheckUserGMScore @userid
-------	END
-------	ELSE IF @taskid = 2
-------	BEGIN
-------		-- 封号
-------		INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'封号'+convert(varchar(32),@userid) FROM GMTask WHERE ID=@id
-------		EXEC dbo.GSP_GR_CongealAccounts @userid,0,N''
-------		DELETE FROM GMTask WHERE ID=@id
-------	END
-------	ELSE IF @taskid = 5
-------	BEGIN
-------		-- 解封
-------		INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'解封'+convert(varchar(32),@userid) FROM GMTask WHERE ID=@id
-------		EXEC dbo.GSP_GR_UnCongealAccounts @userid,0,N''
-------		DELETE FROM GMTask WHERE ID=@id
-------	END
-------	ELSE IF @taskid = 3
-------	BEGIN
-------		-- 更新手机号
-------		SELECT @OldPhone=Phone FROM AccountsInfo(NOLOCK) WHERE UserID=@userid
-------		INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'原手机号'+@OldPhone FROM GMTask WHERE ID=@id
-------		UPDATE AccountsInfo SET Phone=@params WHERE UserID=@userid
-------		DELETE FROM GMTask WHERE ID=@id
-------	END
-------	ELSE IF @taskid = 4
-------	BEGIN
-------		-- 设置密码
-------		SELECT @OldPwd=LogonPass, @IsGuest=IsGuest FROM AccountsInfo(NOLOCK) WHERE UserID=@userid
-------		SET @ThePasswordX = substring(sys.fn_VarBinToHexStr(hashbytes('MD5',@passwd)),3,32)
-------		IF @IsGuest = 1
-------		BEGIN
-------			INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'游客，原密码'+@OldPwd FROM GMTask WHERE ID=@id
-------			UPDATE AccountsInfo SET LogonPass=@ThePasswordX,InsurePass=@params WHERE UserID=@userid and IsGuest = 1
-------		END
-------		ELSE
-------		BEGIN
-------			INSERT INTO GMTaskLog SELECT *,getdate(),N'完成',N'原密码'+@OldPwd FROM GMTask WHERE ID=@id
-------			UPDATE AccountsInfo SET LogonPass=@ThePasswordX WHERE UserID=@userid and IsGuest = 0
-------		END
-------		DELETE FROM GMTask WHERE ID=@id
-------	END
-------	ELSE
-------	BEGIN
-------		-- 不支持的任务
-------		INSERT INTO GMTaskLog SELECT *,getdate(),N'不支持',N'此任务暂不支持' FROM GMTask WHERE ID=@id
-------		DELETE FROM GMTask WHERE ID=@id
-------	END
-------GO



