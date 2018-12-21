USE [WHServerInfoDB]
GO
/****** Object:  StoredProcedure [dbo].[GSP_LoadGameTypeItem]    Script Date: 2018/12/21 16:34:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------------


--加载种类
create  PROCEDURE [dbo].[GSP_LoadGameTypeItem]   AS

--设置属性
SET NOCOUNT ON

--查询种类
SELECT * FROM GameTypeItem(NOLOCK) WHERE Nullity=0 ORDER BY SortID

RETURN 0