use ZQServerInfoDB;
GO
/****** Object:  Table [dbo].[HallVersion]    Script Date: 2018/11/12 23:02:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HallVersion](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HashID] [varchar](32) NOT NULL,
	[CreateTime] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET IDENTITY_INSERT [dbo].[HallVersion] ON 

INSERT [dbo].[HallVersion] ([ID], [HashID], [CreateTime]) VALUES (1, N'h123456', CAST(N'2011-10-15 00:00:00.000' AS DateTime))
INSERT [dbo].[HallVersion] ([ID], [HashID], [CreateTime]) VALUES (2, N'h123457', CAST(N'2011-10-16 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[HallVersion] OFF