USE [WHServerInfoDB]
GO
/****** Object:  StoredProcedure [dbo].[GSP_LoadGameNodeItem]    Script Date: 2018/12/21 16:38:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------------

--加载节点
create  PROCEDURE [dbo].[GSP_LoadGameNodeItem]   AS

--设置属性
SET NOCOUNT ON

--查询节点
SELECT * FROM GameNodeItem(NOLOCK) WHERE Nullity=0 ORDER BY SortID

RETURN 0

