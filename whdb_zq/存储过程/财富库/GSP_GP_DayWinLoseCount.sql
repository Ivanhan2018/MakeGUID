USE ZQTreasureDB;
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go



-- =============================================
-- Author:		<Author,cxf>
-- Create date: <Create Date,2012-03-02>
-- Description:	<Description,当天输赢取局数>
-- =============================================
create PROCEDURE [dbo].[GSP_GP_DayWinLoseCount]
	@KindID								INT,						--游戏ID
	@UserID								INT							--用户ID
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Today						NVARCHAR(8)					--日期
	DECLARE @TableName					NVARCHAR(30)				--表名
	DECLARE @CSql						NVARCHAR(2000)				--
    --取当天玩家在线时长
	SET @Today=LEFT(CONVERT(NVARCHAR(20),GETDATE(),112),8)
	SET @TableName='WriteGameEndLog_'+LEFT(@Today,6)

	IF EXISTS(SELECT * FROM ZQTreasureDB.DBO.SYSOBJECTS WHERE name=@TableName)
	BEGIN
--		EXEC ('SELECT ISNULL(SUM(CASE WHEN WinCount=1  THEN 1 ELSE 0 END),0) AS KindIDWinCount,
--					  ISNULL(SUM(CASE WHEN LostCount=1 THEN 1 ELSE 0 END),0) AS KindIDLostCount,
--					  ISNULL(SUM(CASE WHEN DrawCount=1 THEN 1 ELSE 0 END),0) AS KindIDDrawCount,
--					  ISNULL(SUM(CASE WHEN FleeCount=1 THEN 1 ELSE 0 END),0) AS KindIDFleeCount FROM '+@TableName+'
--				WHERE UserID=CONVERT(NVARCHAR(10),'+@UserID+') AND KindID=CONVERT(NVARCHAR(10),'+@KindID+') 
--					AND CONVERT(INT,CreateDate,12)=CONVERT(INT,GETDATE(),12)')	
		--过程体
		SET @CSql='SELECT ISNULL(SUM(CASE WHEN WinCount=1  THEN 1 ELSE 0 END),0) AS KindIDWinCount,
					  ISNULL(SUM(CASE WHEN LostCount=1 THEN 1 ELSE 0 END),0) AS KindIDLostCount,
					  ISNULL(SUM(CASE WHEN DrawCount=1 THEN 1 ELSE 0 END),0) AS KindIDDrawCount,
					  ISNULL(SUM(CASE WHEN FleeCount=1 THEN 1 ELSE 0 END),0) AS KindIDFleeCount FROM '+@TableName+'
				WHERE UserID=CONVERT(NVARCHAR(10),'+CONVERT(NVARCHAR(10),@UserID)+') AND KindID=CONVERT(NVARCHAR(10),'+CONVERT(NVARCHAR(10),@KindID)+') 
					AND CONVERT(NVARCHAR(10),CreateDate,12)=CONVERT(NVARCHAR(10),GETDATE(),12)'
		EXEC sp_executesql @CSql OUTPUT

		RETURN 1
	END

	RETURN 0
END



