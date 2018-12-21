
----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_CongealAccounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_CongealAccounts]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE GSP_GR_CongealAccounts
  	@dwUserID INT,
	@dwMasterUserID INT,
	@strClientIP VARCHAR(15)
WITH ENCRYPTION AS

SET NOCOUNT ON

BEGIN

	-- 设置标志
	UPDATE AccountsInfo SET Nullity=1 WHERE UserID=@dwUserID
	--不入排行榜
	UPDATE WHTreasureDB.dbo.GameScoreInfo SET RankingStatus=0 WHERE UserID=@dwUserID
END

RETURN 0
----------------------------------------------------------------------------------------------------

GO

SET QUOTED_IDENTIFIER OFF 
GO

SET ANSI_NULLS ON 
GO


----------------------------------------------------------------------------------------------------

USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_UnCongealAccounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_UnCongealAccounts]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE GSP_GR_UnCongealAccounts
  	@dwUserID INT,
	@dwMasterUserID INT,
	@strClientIP VARCHAR(15)
WITH ENCRYPTION AS

SET NOCOUNT ON

BEGIN

	-- 设置标志
	UPDATE AccountsInfo SET Nullity=0 WHERE UserID=@dwUserID

END

RETURN 0
----------------------------------------------------------------------------------------------------

GO

SET QUOTED_IDENTIFIER OFF 
GO

SET ANSI_NULLS ON 
GO
