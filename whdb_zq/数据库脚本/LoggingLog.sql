use ZQGameUserDB;
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoggingLog]    Script Date: 2018/11/12 23:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoggingLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[LoggingMode] [int] NOT NULL CONSTRAINT [DF_LoggingLog_LoggingMode]  DEFAULT ((0)),
	[ClientIP] [nvarchar](15) NULL,
	[LoggingDate] [datetime] NOT NULL CONSTRAINT [DF_LoggingLog_LoggingDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_LoggingLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
