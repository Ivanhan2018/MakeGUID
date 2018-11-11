
----------------------------------------------------------------------------------------------------

USE ZQGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_SafeBind]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_SafeBind]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_SafeUnBind]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_SafeUnBind]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 绑定机器
CREATE PROC GSP_GP_SafeBind
	@dwUserID INT,								-- 用户ID	
	@strInsurePass NCHAR(32),					--银行密码
	@strMachineSerial NCHAR(32)				-- 机器标识
WITH ENCRYPTION AS

declare @InsurePass NCHAR(32)


-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	select @InsurePass = InsurePass from AccountsInfo where UserID=@dwUserID
	if @strInsurePass = @InsurePass
		begin 
			UPDATE AccountsInfo SET MoorMachine = 1, MachineSerial = @strMachineSerial WHERE UserID=@dwUserID
			select [ErrorDescribe] = N'恭喜你！机器绑定成功！'
			RETURN 0
		end
	else
		select [ErrorDescribe] = N'银行密码错误！机器绑定失败！'

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 解除绑定
CREATE PROC GSP_GP_SafeUnBind
	@dwUserID INT,								-- 用户ID
	@strInsurePass NCHAR(32)					--银行密码
WITH ENCRYPTION AS

declare @InsurePass NCHAR(32)

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	select @InsurePass = InsurePass from AccountsInfo where UserID=@dwUserID

if @strInsurePass = @InsurePass
		begin 
			UPDATE AccountsInfo SET MoorMachine = 0 WHERE UserID=@dwUserID
			select [ErrorDescribe] = N'恭喜你！机器解除绑定成功！'
			RETURN 0
		end
	else
		select [ErrorDescribe] = N'银行密码错误！机器解除绑定失败！'
	

END

RETURN 0

GO
