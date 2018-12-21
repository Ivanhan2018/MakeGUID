USE [WHServerInfoDB]
GO
/****** Object:  StoredProcedure [dbo].[GSP_LoadGameKindItem]    Script Date: 2018/12/21 16:13:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------------

-- 游戏类型
create  PROCEDURE [dbo].[GSP_LoadGameKindItem]   AS

-- 设置属性
SET NOCOUNT ON

-- 游戏类型
SELECT * FROM GameKindItem(NOLOCK) WHERE (GameKindItem.Nullity = 0) ORDER BY SortID

RETURN 0