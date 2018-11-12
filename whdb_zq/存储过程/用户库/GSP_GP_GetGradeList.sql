use ZQGameUserDB;
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

---获取等级列表
create PROCEDURE [dbo].[GSP_GP_GetGradeList]
	
AS

DECLARE @Count					INT						--等级总数

BEGIN
	--等级总数量
	SELECT @Count = COUNT(*) FROM GradeList
	IF(@Count>0)
		SELECT * FROM GradeList --等级列表

	RETURN @Count
END