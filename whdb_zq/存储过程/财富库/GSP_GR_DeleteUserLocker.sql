USE ZQTreasureDB;
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

create PROCEDURE [dbo].[GSP_GR_DeleteUserLocker]
--解锁用户
	@UserID		INT		--用户ID
AS
BEGIN
	--删除已锁用户标识
	DELETE FROM GameScoreLocker WHERE UserID = @UserID
	RETURN 0
END
