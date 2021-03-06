USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_ModifyUnderWrite]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_ModifyUnderWrite]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------------------------------
-- 修改个人签名
CREATE PROC [dbo].[GSP_GP_ModifyUnderWrite]
	@UserId INT,						-- 用户ID
	@strUnderWrite NVARCHAR(63)					-- 个性签名
  AS

-- 属性设置
SET NOCOUNT ON

-- 扩展信息
-- 辅助变量
DECLARE @strAccounts NVARCHAR(32)
-- 辅助变量
DECLARE @ErrorDescribe NVARCHAR(128)

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @strAccounts=Accounts FROM AccountsInfo(NOLOCK) WHERE UserID=@UserId

	IF @strAccounts IS NULL 
	BEGIN
		SELECT @UserId AS UserID, [ErrorDescribe]=N'帐号不存在！'
		RETURN 1
	END
	
	--IF @strDescribe IS NULL
	--BEGIN
	--	SELECT @UserId AS UserID, [ErrorDescribe]=N'个性签名为空！'
	--	RETURN 2
	--END
	-- 
	UPDATE AccountsInfo SET UnderWrite=@strUnderWrite WHERE UserID=@UserId
	-- 输出变量
	SELECT @ErrorDescribe AS ErrorDescribe, @strAccounts AS Accounts
END

RETURN 0



