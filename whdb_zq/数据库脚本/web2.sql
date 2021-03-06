USE [ZQWebDB]
GO
/****** Object:  Table [dbo].[yeepay_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[yeepay_log](
	[OrderID] [varchar](20) NOT NULL,
	[UserID] [int] NOT NULL,
	[Amt] [money] NOT NULL,
	[Cur] [varchar](10) NOT NULL,
	[Pid] [varchar](20) NOT NULL,
	[FrpId] [varchar](20) NOT NULL,
	[Hmac] [varchar](36) NOT NULL,
	[CBWMoney] [money] NOT NULL,
	[State] [tinyint] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[CreateIP] [varchar](23) NOT NULL,
	[UpdateTime] [datetime] NULL,
	[UpdateIP] [varchar](23) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vpay_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vpay_log](
	[OrderID] [varchar](20) NOT NULL,
	[UserID] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[CBWMoney] [money] NOT NULL,
	[PostKey] [varchar](32) NOT NULL,
	[RecKey] [varchar](32) NULL,
	[RecVcard] [varchar](20) NULL,
	[RecVpwd] [varchar](10) NULL,
	[RecVtype] [tinyint] NULL,
	[RecOrderID] [varchar](20) NULL,
	[RecFlag] [tinyint] NULL,
	[RecTime] [datetime] NULL,
	[LogTime] [datetime] NOT NULL,
	[LogIP] [varchar](23) NULL,
	[Status] [tinyint] NOT NULL,
	[PayType] [tinyint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserMoneyLog_201811]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserMoneyLog_201811](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreMoney] [numeric](18, 2) NOT NULL,
	[ChangeMoney] [numeric](18, 2) NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserMoneyLog_201811] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserMoneyLog_201811] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMoneyLog_201203]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserMoneyLog_201203](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreMoney] [numeric](18, 2) NOT NULL,
	[ChangeMoney] [numeric](18, 2) NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserMoneyLog_201203] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserMoneyLog_201203] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMoneyLog_201202]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserMoneyLog_201202](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreMoney] [numeric](18, 2) NOT NULL,
	[ChangeMoney] [numeric](18, 2) NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserMoneyLog_201202] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserMoneyLog_201202] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMoneyLog_201201]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserMoneyLog_201201](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreMoney] [numeric](18, 2) NOT NULL,
	[ChangeMoney] [numeric](18, 2) NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserMoneyLog_201201] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserMoneyLog_201201] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMoneyLog_201112]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMoneyLog_201112](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreMoney] [numeric](18, 2) NOT NULL,
	[ChangeMoney] [numeric](18, 2) NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
 CONSTRAINT [PK__UserMoneyLog_201__2739D489] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserMoneyLog_201112] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserMoneyLog_201112] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMoneyLog_201111]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMoneyLog_201111](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreMoney] [numeric](18, 2) NOT NULL,
	[ChangeMoney] [numeric](18, 2) NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
 CONSTRAINT [PK__UserMoneyLog_201__123EB7A3] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserMoneyLog_201111] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserMoneyLog_201111] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMoneyLog_201110]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMoneyLog_201110](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreMoney] [numeric](18, 2) NOT NULL,
	[ChangeMoney] [numeric](18, 2) NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
 CONSTRAINT [PK__UserMoneyLog_201__1EA48E88] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserMoneyLog_201110] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserMoneyLog_201110] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMoneyLog_201109]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMoneyLog_201109](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreMoney] [numeric](18, 2) NOT NULL,
	[ChangeMoney] [numeric](18, 2) NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
 CONSTRAINT [PK__UserMoneyLog_201__160F4887] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserMoneyLog_201109] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserMoneyLog_201109] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGoldLog_201705]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserGoldLog_201705](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LastGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserGoldLog_201705] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserGoldLog_201705] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGoldLog_201203]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserGoldLog_201203](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LastGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserGoldLog_201203] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserGoldLog_201203] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGoldLog_201202]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserGoldLog_201202](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LastGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserGoldLog_201202] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserGoldLog_201202] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGoldLog_201201]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserGoldLog_201201](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LastGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserGoldLog_201201] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserGoldLog_201201] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGoldLog_201112]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGoldLog_201112](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LastGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGoldLog_201111]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGoldLog_201111](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LastGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGoldLog_201110]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGoldLog_201110](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LastGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGoldLog_201109]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGoldLog_201109](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LastGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGemsLog_201204]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserGemsLog_201204](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreGems] [int] NOT NULL,
	[ChangeGems] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserGemsLog_201204] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserGemsLog_201204] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGemsLog_201203]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserGemsLog_201203](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreGems] [int] NOT NULL,
	[ChangeGems] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserGemsLog_201203] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserGemsLog_201203] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGemsLog_201202]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserGemsLog_201202](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreGems] [int] NOT NULL,
	[ChangeGems] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserGemsLog_201202] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserGemsLog_201202] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGemsLog_201201]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UserGemsLog_201201](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreGems] [int] NOT NULL,
	[ChangeGems] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ChangeType] ON [dbo].[UserGemsLog_201201] 
(
	[ChangeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[UserGemsLog_201201] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGemsLog_201112]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGemsLog_201112](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreGems] [int] NOT NULL,
	[ChangeGems] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGemsLog_201111]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGemsLog_201111](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreGems] [int] NOT NULL,
	[ChangeGems] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGemsLog_201110]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGemsLog_201110](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreGems] [int] NOT NULL,
	[ChangeGems] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserGemsLog_201109]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGemsLog_201109](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[PreGems] [int] NOT NULL,
	[ChangeGems] [int] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[ServerID] [int] NOT NULL,
	[Remark] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_updatepwd_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user_updatepwd_log](
	[UserID] [int] NOT NULL,
	[OldPasswd] [varchar](20) NOT NULL,
	[NewPasswd] [varchar](20) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[LogIp] [varchar](23) NOT NULL,
	[LogType] [tinyint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[user_updatepwd_log] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_safe_question]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user_safe_question](
	[UserID] [int] NOT NULL,
	[Question1] [varchar](50) NULL,
	[Question2] [varchar](50) NULL,
	[Question3] [varchar](50) NULL,
	[Answer1] [varchar](100) NULL,
	[Answer2] [varchar](100) NULL,
	[Answer3] [varchar](100) NULL,
	[QuestionTime] [datetime] NULL,
	[QuestionIP] [varchar](23) NULL,
	[Email] [varchar](50) NULL,
	[EmailTime] [datetime] NULL,
	[EmailIP] [varchar](23) NULL,
	[TryNums] [int] NOT NULL,
	[IsLock] [bit] NOT NULL,
	[LockTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_find_passwd]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user_find_passwd](
	[UserID] [int] NOT NULL,
	[FindType] [tinyint] NOT NULL,
	[KeyCode] [varchar](16) NOT NULL,
	[OverTime] [datetime] NOT NULL,
	[IsActive] [tinyint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[user_find_passwd] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_bank_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user_bank_log](
	[UserID] [int] NOT NULL,
	[PreNum] [int] NOT NULL,
	[ChangeNum] [int] NOT NULL,
	[LogType] [tinyint] NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[LogIP] [varchar](16) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_bank]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user_bank](
	[UserID] [int] NOT NULL,
	[TakeOutPass] [varchar](32) NOT NULL,
	[Money] [numeric](18, 2) NOT NULL,
	[Gold] [int] NOT NULL,
	[Gems] [int] NOT NULL,
	[LastTime] [datetime] NOT NULL,
	[LastIP] [varchar](16) NULL,
 CONSTRAINT [PK__user_bank__30C33EC3] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[suggest]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[suggest](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Subject] [varchar](100) NOT NULL,
	[Content] [varchar](1000) NOT NULL,
	[Tel] [varchar](20) NULL,
	[Pic] [varchar](100) NULL,
	[CreateTime] [datetime] NOT NULL,
	[IpAddr] [varchar](23) NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Reply] [varchar](1000) NULL,
	[ReplyAdmin] [int] NULL,
	[ReplyTime] [datetime] NULL,
	[ReplyIp] [varchar](23) NULL,
	[State] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SSO]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSO](
	[UserID] [int] NOT NULL,
	[LoginKey] [nchar](8) NOT NULL,
	[KeyTime] [datetime] NOT NULL,
	[IP] [nvarchar](15) NULL,
	[Flag] [tinyint] NOT NULL,
	[md5] [varchar](32) NULL,
 CONSTRAINT [PK_SSO] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SSO', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登陆Key' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SSO', @level2type=N'COLUMN',@level2name=N'LoginKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成Key时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SSO', @level2type=N'COLUMN',@level2name=N'KeyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户IP地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SSO', @level2type=N'COLUMN',@level2name=N'IP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否有效' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SSO', @level2type=N'COLUMN',@level2name=N'Flag'
GO
/****** Object:  Table [dbo].[recharge_gold_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[recharge_gold_log](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CardID] [int] NOT NULL,
	[CardType] [tinyint] NOT NULL,
	[CurrentGold] [int] NOT NULL,
	[ChangeGold] [int] NOT NULL,
	[IPAddress] [varchar](23) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[Remark] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prop_used]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[prop_used](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[PropID] [int] NOT NULL,
	[PropNum] [int] NOT NULL,
	[WriteDate] [datetime] NOT NULL,
	[ClientIP] [varchar](23) NOT NULL,
	[OverTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prop_shelf]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[prop_shelf](
	[UserID] [int] NOT NULL,
	[PropID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[PropNum] [int] NOT NULL,
	[WriteDate] [datetime] NOT NULL,
	[ClientIP] [varchar](23) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prop_info]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[prop_info](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PropType] [tinyint] NOT NULL,
	[PropName] [varchar](20) NOT NULL,
	[Price] [int] NOT NULL,
	[Gift] [int] NOT NULL,
	[Duration] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[Tips] [varchar](255) NOT NULL,
	[IsActive] [tinyint] NOT NULL,
	[ImageUrl] [varchar](100) NULL,
	[WriteDate] [datetime] NOT NULL,
	[SortID] [int] NOT NULL,
 CONSTRAINT [PK__prop_info__7167D3BD] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prop_history]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[prop_history](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RecordType] [tinyint] NOT NULL,
	[UserID] [int] NOT NULL,
	[PropID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[ServerID] [int] NOT NULL,
	[CurPropNum] [int] NOT NULL,
	[OncePropNum] [int] NOT NULL,
	[TotalPropNum] [int] NOT NULL,
	[ClientIP] [varchar](23) NOT NULL,
	[WriteDate] [datetime] NOT NULL,
	[OverTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[present_gold_apply]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[present_gold_apply](
	[PreAppID] [int] IDENTITY(1,1) NOT NULL,
	[Gold] [int] NULL,
	[PreUserID] [int] NULL,
	[ApplyAdmID] [int] NOT NULL,
	[ApplyIP] [varchar](23) NOT NULL,
	[ApplyTime] [datetime] NOT NULL,
	[ApplyRemark] [varchar](500) NULL,
	[CheckAdmID] [int] NULL,
	[CheckIP] [varchar](23) NULL,
	[CheckTime] [datetime] NULL,
	[CheckRemark] [varchar](500) NULL,
	[PreAdmID] [int] NULL,
	[PreIP] [varchar](23) NULL,
	[PreTime] [datetime] NULL,
	[PreRemark] [varchar](500) NULL,
	[ApplyState] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PreAppID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[present_gems_apply]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[present_gems_apply](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Gems] [int] NULL,
	[PreUserID] [int] NULL,
	[ApplyAdmID] [int] NOT NULL,
	[ApplyIP] [varchar](23) NOT NULL,
	[ApplyTime] [datetime] NOT NULL,
	[ApplyRemark] [varchar](500) NULL,
	[CheckAdmID] [int] NULL,
	[CheckIP] [varchar](23) NULL,
	[CheckTime] [datetime] NULL,
	[CheckRemark] [varchar](500) NULL,
	[PreAdmID] [int] NULL,
	[PreIP] [varchar](23) NULL,
	[PreTime] [datetime] NULL,
	[PreRemark] [varchar](500) NULL,
	[ApplyState] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[pay_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pay_log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ModeType] [tinyint] NOT NULL,
	[PayType] [tinyint] NOT NULL,
	[Price] [numeric](18, 2) NOT NULL,
	[OrderID] [varchar](50) NOT NULL,
	[PayMoney] [numeric](18, 2) NOT NULL,
	[CurrentMoney] [numeric](18, 2) NOT NULL,
	[IpAddr] [varchar](23) NOT NULL,
	[LogTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ModeType] ON [dbo].[pay_log] 
(
	[ModeType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_PayType] ON [dbo].[pay_log] 
(
	[PayType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[pay_log] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpenCardID]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpenCardID](
	[id] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[open_card_detail]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[open_card_detail](
	[OpenApplyID] [int] NOT NULL,
	[AreaOperatorID] [int] NULL,
	[CardValue] [numeric](18, 2) NULL,
	[HaveGold] [int] NULL,
	[BindGems] [int] NULL,
	[Amount] [int] NOT NULL,
	[UseAble] [tinyint] NOT NULL,
	[BuildTime] [datetime] NOT NULL,
	[EffectTime] [datetime] NULL,
	[Remark] [varchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[open_card_apply]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[open_card_apply](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AreaOperatorID] [int] NULL,
	[CardValue] [numeric](18, 2) NOT NULL,
	[HaveGold] [int] NULL,
	[BindGems] [int] NULL,
	[Amount] [int] NOT NULL,
	[EffectTime] [datetime] NULL,
	[ApplyName] [int] NOT NULL,
	[ApplyIP] [varchar](23) NOT NULL,
	[ApplyTime] [datetime] NOT NULL,
	[ApplyRemark] [varchar](500) NULL,
	[State] [tinyint] NOT NULL,
	[AuditorID] [int] NULL,
	[AuditorIP] [varchar](23) NULL,
	[AuditorTime] [datetime] NULL,
	[AuditorRemark] [varchar](500) NULL,
	[BuildID] [int] NULL,
	[BuildIP] [varchar](23) NULL,
	[BuildTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[open_card]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[open_card](
	[OpenCardID] [bigint] NOT NULL,
	[OpenApplyID] [int] NOT NULL,
	[CardNum] [varchar](20) NOT NULL,
	[CardPassword] [varchar](20) NOT NULL,
	[UseAble] [tinyint] NOT NULL,
	[HaveUse] [tinyint] NOT NULL,
	[Remark] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[OpenCardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[news]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[news](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NewsType] [tinyint] NOT NULL,
	[NewsTitle] [varchar](200) NOT NULL,
	[NewsContent] [text] NOT NULL,
	[IsTop] [tinyint] NOT NULL,
	[Issue] [int] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
	[IsActive] [tinyint] NOT NULL,
	[ImgPath] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[message_user]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[message_user](
	[MessageID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[IsDel] [bit] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_MessageID] ON [dbo].[message_user] 
(
	[MessageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[message_user] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[message_content]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[message_content](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [varchar](50) NOT NULL,
	[Content] [text] NOT NULL,
	[SendTime] [datetime] NOT NULL,
	[AdminID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[RecType] [tinyint] NOT NULL,
	[CityID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ip]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ip](
	[ID] [int] NOT NULL,
	[BeginIP] [bigint] NOT NULL,
	[EndIP] [bigint] NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[IPCityID] [int] NULL,
	[IPProvinceID] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[gold_card_detail]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[gold_card_detail](
	[ApplyID] [int] NOT NULL,
	[CityID] [int] NULL,
	[CardValue] [numeric](18, 2) NULL,
	[HaveGold] [int] NULL,
	[Amount] [int] NOT NULL,
	[UseAble] [tinyint] NOT NULL,
	[BuildTime] [datetime] NOT NULL,
	[EffectTime] [datetime] NULL,
	[Remark] [varchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[gold_card_apply]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[gold_card_apply](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CityID] [int] NULL,
	[CardValue] [numeric](18, 2) NOT NULL,
	[HaveGold] [int] NULL,
	[Amount] [int] NOT NULL,
	[EffectTime] [datetime] NULL,
	[ApplyName] [int] NOT NULL,
	[ApplyIP] [varchar](23) NOT NULL,
	[ApplyTime] [datetime] NOT NULL,
	[ApplyRemark] [varchar](500) NULL,
	[State] [tinyint] NOT NULL,
	[AuditorID] [int] NULL,
	[AuditorIP] [varchar](23) NULL,
	[AuditorTime] [datetime] NULL,
	[AuditorRemark] [varchar](500) NULL,
	[BuildID] [int] NULL,
	[BuildIP] [varchar](23) NULL,
	[BuildTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[gold_card]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[gold_card](
	[CardID] [bigint] NOT NULL,
	[ApplyID] [int] NOT NULL,
	[CardNum] [varchar](20) NOT NULL,
	[CardPassword] [varchar](20) NOT NULL,
	[UseAble] [tinyint] NOT NULL,
	[HaveUse] [tinyint] NOT NULL,
	[Remark] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[CardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[download_count]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[download_count](
	[DownloadID] [int] NOT NULL,
	[DownloadCount] [int] NOT NULL,
	[DownloadDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[city]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[city](
	[ID] [int] NOT NULL,
	[SuperID] [int] NULL,
	[CityName] [varchar](50) NOT NULL,
	[Remark] [tinyint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CardID]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardID](
	[id] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AwardID]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AwardID](
	[id] [float] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[award_kind]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[award_kind](
	[KindID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NOT NULL,
	[KindName] [varchar](50) NOT NULL,
	[IsAffect] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[KindID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[award_info]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[award_info](
	[AwardID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[AwardName] [varchar](50) NOT NULL,
	[PhotoPath] [varchar](100) NULL,
	[Intro] [text] NULL,
	[CanExchange] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[NeedGems] [int] NOT NULL,
	[GetWay] [tinyint] NOT NULL,
	[PostageFee] [int] NOT NULL,
	[MonthStock] [int] NOT NULL,
	[NeedGrade] [int] NOT NULL,
	[NeedGameTime] [int] NOT NULL,
	[SortID] [int] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK__award_info__52593CB8] PRIMARY KEY CLUSTERED 
(
	[AwardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_KindID] ON [dbo].[award_info] 
(
	[KindID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[award_exchange_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[award_exchange_log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Gems] [int] NOT NULL,
	[PostageFee] [int] NOT NULL,
	[AwardID] [int] NOT NULL,
	[AwardNum] [int] NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[IpAddress] [varchar](15) NOT NULL,
	[RevAddress] [varchar](100) NULL,
	[Postcode] [varchar](8) NULL,
	[RevName] [varchar](20) NULL,
	[Mobile] [varchar](12) NULL,
	[Tel] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
	[State] [tinyint] NOT NULL,
	[ExpressName] [varchar](50) NULL,
	[ExpressTel] [varchar](20) NULL,
	[ExpressOrder] [nvarchar](30) NULL,
 CONSTRAINT [PK__award_exchange_l__5CD6CB2B] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_AwardID] ON [dbo].[award_exchange_log] 
(
	[AwardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_UserID] ON [dbo].[award_exchange_log] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[award_exchange_audit]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[award_exchange_audit](
	[LogID] [int] NOT NULL,
	[AdminID] [int] NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[LogIp] [varchar](23) NOT NULL,
	[Remark] [varchar](500) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[admin_right_list]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[admin_right_list](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RightName] [varchar](20) NOT NULL,
	[RightPage] [varchar](100) NOT NULL,
	[Remark] [varchar](100) NULL,
 CONSTRAINT [PK_admin_right_list] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[admin_right]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admin_right](
	[AdminID] [int] NOT NULL,
	[RightListID] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admin_op_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[admin_op_log](
	[AdminID] [int] NOT NULL,
	[OperatorTime] [datetime] NOT NULL,
	[ActionURL] [varchar](200) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[admin_login_log]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[admin_login_log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AdminID] [int] NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[LoginIP] [varchar](20) NOT NULL,
 CONSTRAINT [PK_admin_login_log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[admin]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[admin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Password] [varchar](32) NOT NULL,
	[RealName] [varchar](50) NULL,
	[IsActive] [tinyint] NOT NULL,
	[RegisterTime] [datetime] NOT NULL,
 CONSTRAINT [PK_admin] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_admin] ON [dbo].[admin] 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activity_userinfo]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[activity_userinfo](
	[UserID] [int] NOT NULL,
	[QQ] [varchar](16) NOT NULL,
	[Tel] [varchar](16) NOT NULL,
	[OperateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[activity_prize]    Script Date: 11/13/2018 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[activity_prize](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ActivityName] [tinyint] NOT NULL,
	[PrizeType] [tinyint] NOT NULL,
	[PType] [tinyint] NOT NULL,
	[PrizeValue] [int] NOT NULL,
	[IpAddr] [varchar](23) NOT NULL,
	[LogTime] [datetime] NOT NULL,
	[IsGet] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF__yeepay_lo__State__251C81ED]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[yeepay_log] ADD  DEFAULT ((0)) FOR [State]
GO
/****** Object:  Default [DF__yeepay_lo__Creat__2610A626]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[yeepay_log] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
/****** Object:  Default [DF__vpay_log__LogTim__214BF109]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[vpay_log] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__vpay_log__Status__22401542]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[vpay_log] ADD  DEFAULT ((0)) FOR [Status]
GO
/****** Object:  Default [DF_vpay_log_PayType]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[vpay_log] ADD  CONSTRAINT [DF_vpay_log_PayType]  DEFAULT ((0)) FOR [PayType]
GO
/****** Object:  Default [DF__UserMoney__LogTi__2F9A1060]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserMoneyLog_201811] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserMoney__LogTi__2EA5EC27]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserMoneyLog_201203] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserMoney__LogTi__17C286CF]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserMoneyLog_201202] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserMoney__LogTi__2DB1C7EE]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserMoneyLog_201201] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserMoney__LogTi__282DF8C2]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserMoneyLog_201112] ADD  CONSTRAINT [DF__UserMoney__LogTi__282DF8C2]  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserMoney__LogTi__1332DBDC]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserMoneyLog_201111] ADD  CONSTRAINT [DF__UserMoney__LogTi__1332DBDC]  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserMoney__LogTi__1F98B2C1]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserMoneyLog_201110] ADD  CONSTRAINT [DF__UserMoney__LogTi__1F98B2C1]  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserMoney__LogTi__17036CC0]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserMoneyLog_201109] ADD  CONSTRAINT [DF__UserMoney__LogTi__17036CC0]  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGoldL__LogTi__04AFB25B]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGoldLog_201705] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGoldL__LogTi__2BC97F7C]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGoldLog_201203] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGoldL__LogTi__2AD55B43]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGoldLog_201202] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGoldL__LogTi__29E1370A]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGoldLog_201201] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGoldL__LogTi__74794A92]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGoldLog_201112] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGoldL__LogTi__6FB49575]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGoldLog_201111] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGoldL__LogTi__6AEFE058]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGoldLog_201110] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGoldL__LogTi__662B2B3B]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGoldLog_201109] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGemsL__LogTi__28ED12D1]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGemsLog_201204] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGemsL__LogTi__27F8EE98]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGemsLog_201203] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGemsL__LogTi__2704CA5F]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGemsLog_201202] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGemsL__LogTi__55F4C372]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGemsLog_201201] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGemsL__LogTi__51300E55]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGemsLog_201112] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGemsL__LogTi__4C6B5938]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGemsLog_201111] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGemsL__LogTi__47A6A41B]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGemsLog_201110] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__UserGemsL__LogTi__42E1EEFE]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[UserGemsLog_201109] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__user_upda__LogTi__4F12BBB9]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_updatepwd_log] ADD  CONSTRAINT [DF__user_upda__LogTi__4F12BBB9]  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__user_safe__TryNu__3B40CD36]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_safe_question] ADD  DEFAULT ((0)) FOR [TryNums]
GO
/****** Object:  Default [DF__user_safe__IsLoc__3C34F16F]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_safe_question] ADD  DEFAULT ((0)) FOR [IsLock]
GO
/****** Object:  Default [DF__user_find__FindT__3587F3E0]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_find_passwd] ADD  DEFAULT ((0)) FOR [FindType]
GO
/****** Object:  Default [DF__user_find__IsAct__367C1819]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_find_passwd] ADD  DEFAULT ((0)) FOR [IsActive]
GO
/****** Object:  Default [DF__user_bank__Chang__31B762FC]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_bank_log] ADD  DEFAULT ((0)) FOR [ChangeNum]
GO
/****** Object:  Default [DF__user_bank__LogTy__32AB8735]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_bank_log] ADD  DEFAULT ((0)) FOR [LogType]
GO
/****** Object:  Default [DF__user_bank__LogTi__339FAB6E]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_bank_log] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__user_bank__Money__31B762FC]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_bank] ADD  CONSTRAINT [DF__user_bank__Money__31B762FC]  DEFAULT ((0)) FOR [Money]
GO
/****** Object:  Default [DF__user_bank__Gold__32AB8735]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_bank] ADD  CONSTRAINT [DF__user_bank__Gold__32AB8735]  DEFAULT ((0)) FOR [Gold]
GO
/****** Object:  Default [DF__user_bank__Gems__339FAB6E]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_bank] ADD  CONSTRAINT [DF__user_bank__Gems__339FAB6E]  DEFAULT ((0)) FOR [Gems]
GO
/****** Object:  Default [DF__user_bank__LastT__3493CFA7]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[user_bank] ADD  CONSTRAINT [DF__user_bank__LastT__3493CFA7]  DEFAULT (getdate()) FOR [LastTime]
GO
/****** Object:  Default [DF__suggest__CreateT__282DF8C2]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[suggest] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
/****** Object:  Default [DF__suggest__Type__29221CFB]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[suggest] ADD  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF_suggest_State]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[suggest] ADD  CONSTRAINT [DF_suggest_State]  DEFAULT ((0)) FOR [State]
GO
/****** Object:  Default [DF_SSO_KeyTime]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[SSO] ADD  CONSTRAINT [DF_SSO_KeyTime]  DEFAULT (getdate()) FOR [KeyTime]
GO
/****** Object:  Default [DF_SSO_Flag]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[SSO] ADD  CONSTRAINT [DF_SSO_Flag]  DEFAULT ((0)) FOR [Flag]
GO
/****** Object:  Default [DF__recharge___CardT__1CBC4616]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[recharge_gold_log] ADD  DEFAULT ((0)) FOR [CardType]
GO
/****** Object:  Default [DF__recharge___Curre__1DB06A4F]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[recharge_gold_log] ADD  DEFAULT ((0)) FOR [CurrentGold]
GO
/****** Object:  Default [DF__recharge___Chang__1EA48E88]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[recharge_gold_log] ADD  DEFAULT ((0)) FOR [ChangeGold]
GO
/****** Object:  Default [DF__recharge___LogTi__1F98B2C1]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[recharge_gold_log] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__prop_used__Write__17F790F9]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_used] ADD  DEFAULT (getdate()) FOR [WriteDate]
GO
/****** Object:  Default [DF__prop_shel__Write__1332DBDC]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_shelf] ADD  DEFAULT (getdate()) FOR [WriteDate]
GO
/****** Object:  Default [DF__prop_info__PropT__725BF7F6]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_info] ADD  CONSTRAINT [DF__prop_info__PropT__725BF7F6]  DEFAULT ((0)) FOR [PropType]
GO
/****** Object:  Default [DF__prop_info__Gift__73501C2F]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_info] ADD  CONSTRAINT [DF__prop_info__Gift__73501C2F]  DEFAULT ((0)) FOR [Gift]
GO
/****** Object:  Default [DF__prop_info__Durat__74444068]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_info] ADD  CONSTRAINT [DF__prop_info__Durat__74444068]  DEFAULT ((0)) FOR [Duration]
GO
/****** Object:  Default [DF__prop_info__IsAct__753864A1]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_info] ADD  CONSTRAINT [DF__prop_info__IsAct__753864A1]  DEFAULT ((0)) FOR [IsActive]
GO
/****** Object:  Default [DF__prop_info__Image__762C88DA]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_info] ADD  CONSTRAINT [DF__prop_info__Image__762C88DA]  DEFAULT ('') FOR [ImageUrl]
GO
/****** Object:  Default [DF_prop_info_WriteDate]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_info] ADD  CONSTRAINT [DF_prop_info_WriteDate]  DEFAULT (getdate()) FOR [WriteDate]
GO
/****** Object:  Default [DF_prop_info_SortID]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_info] ADD  CONSTRAINT [DF_prop_info_SortID]  DEFAULT ((0)) FOR [SortID]
GO
/****** Object:  Default [DF__prop_hist__Recor__05D8E0BE]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_history] ADD  DEFAULT ((0)) FOR [RecordType]
GO
/****** Object:  Default [DF__prop_hist__KindI__06CD04F7]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_history] ADD  DEFAULT ((0)) FOR [KindID]
GO
/****** Object:  Default [DF__prop_hist__Serve__07C12930]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_history] ADD  DEFAULT ((0)) FOR [ServerID]
GO
/****** Object:  Default [DF__prop_hist__Write__08B54D69]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[prop_history] ADD  DEFAULT (getdate()) FOR [WriteDate]
GO
/****** Object:  Default [DF__present_g__Apply__00200768]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[present_gold_apply] ADD  DEFAULT (getdate()) FOR [ApplyTime]
GO
/****** Object:  Default [DF__present_g__Apply__01142BA1]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[present_gold_apply] ADD  DEFAULT ((0)) FOR [ApplyState]
GO
/****** Object:  Default [DF__present_g__Apply__7A672E12]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[present_gems_apply] ADD  DEFAULT (getdate()) FOR [ApplyTime]
GO
/****** Object:  Default [DF__present_g__Apply__7B5B524B]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[present_gems_apply] ADD  DEFAULT ((0)) FOR [ApplyState]
GO
/****** Object:  Default [DF__pay_log__ModeTyp__70DDC3D8]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[pay_log] ADD  DEFAULT ((0)) FOR [ModeType]
GO
/****** Object:  Default [DF__pay_log__PayType__71D1E811]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[pay_log] ADD  DEFAULT ((0)) FOR [PayType]
GO
/****** Object:  Default [DF__pay_log__Price__72C60C4A]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[pay_log] ADD  DEFAULT ((0)) FOR [Price]
GO
/****** Object:  Default [DF__pay_log__PayMone__73BA3083]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[pay_log] ADD  DEFAULT ((0)) FOR [PayMoney]
GO
/****** Object:  Default [DF__pay_log__Current__74AE54BC]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[pay_log] ADD  DEFAULT ((0)) FOR [CurrentMoney]
GO
/****** Object:  Default [DF__pay_log__LogTime__75A278F5]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[pay_log] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__open_card__CardV__68487DD7]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card_detail] ADD  DEFAULT ((0.00)) FOR [CardValue]
GO
/****** Object:  Default [DF__open_card__Amoun__693CA210]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card_detail] ADD  DEFAULT ((0)) FOR [Amount]
GO
/****** Object:  Default [DF__open_card__UseAb__6A30C649]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card_detail] ADD  DEFAULT ((1)) FOR [UseAble]
GO
/****** Object:  Default [DF__open_card__Build__6B24EA82]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card_detail] ADD  DEFAULT (getdate()) FOR [BuildTime]
GO
/****** Object:  Default [DF__open_card__CardV__6383C8BA]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card_apply] ADD  DEFAULT ((0.00)) FOR [CardValue]
GO
/****** Object:  Default [DF__open_card__Amoun__6477ECF3]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card_apply] ADD  DEFAULT ((0)) FOR [Amount]
GO
/****** Object:  Default [DF__open_card__Apply__656C112C]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card_apply] ADD  DEFAULT (getdate()) FOR [ApplyTime]
GO
/****** Object:  Default [DF__open_card__State__66603565]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card_apply] ADD  DEFAULT ((0)) FOR [State]
GO
/****** Object:  Default [DF__open_card__UseAb__5DCAEF64]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card] ADD  DEFAULT ((1)) FOR [UseAble]
GO
/****** Object:  Default [DF__open_card__HaveU__5EBF139D]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[open_card] ADD  DEFAULT ((0)) FOR [HaveUse]
GO
/****** Object:  Default [DF__news__NewsType__5629CD9C]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[news] ADD  DEFAULT ((0)) FOR [NewsType]
GO
/****** Object:  Default [DF__news__IsTop__571DF1D5]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[news] ADD  DEFAULT ((0)) FOR [IsTop]
GO
/****** Object:  Default [DF__news__UpdateTime__5812160E]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[news] ADD  DEFAULT (getdate()) FOR [UpdateTime]
GO
/****** Object:  Default [DF__news__IsActive__59063A47]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[news] ADD  DEFAULT ((0)) FOR [IsActive]
GO
/****** Object:  Default [DF__message_u__IsRea__5070F446]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[message_user] ADD  DEFAULT ((0)) FOR [IsRead]
GO
/****** Object:  Default [DF__message_u__IsDel__5165187F]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[message_user] ADD  DEFAULT ((0)) FOR [IsDel]
GO
/****** Object:  Default [DF__message_c__SendT__4D94879B]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[message_content] ADD  DEFAULT (getdate()) FOR [SendTime]
GO
/****** Object:  Default [DF__message_c__IsAct__4E88ABD4]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[message_content] ADD  DEFAULT ((0)) FOR [IsActive]
GO
/****** Object:  Default [DF__gold_card__CardV__44FF419A]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card_detail] ADD  DEFAULT ((0.00)) FOR [CardValue]
GO
/****** Object:  Default [DF__gold_card__Amoun__45F365D3]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card_detail] ADD  DEFAULT ((0)) FOR [Amount]
GO
/****** Object:  Default [DF__gold_card__UseAb__46E78A0C]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card_detail] ADD  DEFAULT ((1)) FOR [UseAble]
GO
/****** Object:  Default [DF__gold_card__Build__47DBAE45]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card_detail] ADD  DEFAULT (getdate()) FOR [BuildTime]
GO
/****** Object:  Default [DF__gold_card__CardV__403A8C7D]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card_apply] ADD  DEFAULT ((0.00)) FOR [CardValue]
GO
/****** Object:  Default [DF__gold_card__Amoun__412EB0B6]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card_apply] ADD  DEFAULT ((0)) FOR [Amount]
GO
/****** Object:  Default [DF__gold_card__Apply__4222D4EF]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card_apply] ADD  DEFAULT (getdate()) FOR [ApplyTime]
GO
/****** Object:  Default [DF__gold_card__State__4316F928]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card_apply] ADD  DEFAULT ((0)) FOR [State]
GO
/****** Object:  Default [DF__gold_card__UseAb__3A81B327]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card] ADD  DEFAULT ((1)) FOR [UseAble]
GO
/****** Object:  Default [DF__gold_card__HaveU__3B75D760]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[gold_card] ADD  DEFAULT ((0)) FOR [HaveUse]
GO
/****** Object:  Default [DF__download___Downl__34C8D9D1]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[download_count] ADD  DEFAULT ((0)) FOR [DownloadCount]
GO
/****** Object:  Default [DF__download___Downl__35BCFE0A]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[download_count] ADD  DEFAULT (getdate()) FOR [DownloadDate]
GO
/****** Object:  Default [DF__award_kin__Paren__2F10007B]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_kind] ADD  DEFAULT ((0)) FOR [ParentID]
GO
/****** Object:  Default [DF__award_kin__IsAff__300424B4]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_kind] ADD  DEFAULT ((1)) FOR [IsAffect]
GO
/****** Object:  Default [DF__award_inf__CanEx__534D60F1]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__CanEx__534D60F1]  DEFAULT ((0)) FOR [CanExchange]
GO
/****** Object:  Default [DF__award_inf__IsAff__5441852A]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__IsAff__5441852A]  DEFAULT ((0)) FOR [IsActive]
GO
/****** Object:  Default [DF__award_inf__NeedH__5535A963]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__NeedH__5535A963]  DEFAULT ((0)) FOR [NeedGems]
GO
/****** Object:  Default [DF__award_inf__GetWa__5629CD9C]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__GetWa__5629CD9C]  DEFAULT ((0)) FOR [GetWay]
GO
/****** Object:  Default [DF__award_inf__Posta__571DF1D5]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__Posta__571DF1D5]  DEFAULT ((0)) FOR [PostageFee]
GO
/****** Object:  Default [DF__award_inf__Month__5812160E]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__Month__5812160E]  DEFAULT ((0)) FOR [MonthStock]
GO
/****** Object:  Default [DF__award_inf__NeedG__59063A47]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__NeedG__59063A47]  DEFAULT ((0)) FOR [NeedGrade]
GO
/****** Object:  Default [DF__award_inf__NeedG__59FA5E80]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__NeedG__59FA5E80]  DEFAULT ((0)) FOR [NeedGameTime]
GO
/****** Object:  Default [DF__award_inf__SortI__5AEE82B9]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF__award_inf__SortI__5AEE82B9]  DEFAULT ((0)) FOR [SortID]
GO
/****** Object:  Default [DF_award_info_UpdateTime]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_info] ADD  CONSTRAINT [DF_award_info_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
/****** Object:  Default [DF__award_exc__NeedH__5DCAEF64]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_exchange_log] ADD  CONSTRAINT [DF__award_exc__NeedH__5DCAEF64]  DEFAULT ((0)) FOR [Gems]
GO
/****** Object:  Default [DF__award_exc__Posta__5EBF139D]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_exchange_log] ADD  CONSTRAINT [DF__award_exc__Posta__5EBF139D]  DEFAULT ((0)) FOR [PostageFee]
GO
/****** Object:  Default [DF__award_exc__Award__5FB337D6]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_exchange_log] ADD  CONSTRAINT [DF__award_exc__Award__5FB337D6]  DEFAULT ((1)) FOR [AwardNum]
GO
/****** Object:  Default [DF__award_exc__LogTi__60A75C0F]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_exchange_log] ADD  CONSTRAINT [DF__award_exc__LogTi__60A75C0F]  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF__award_exc__State__619B8048]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_exchange_log] ADD  CONSTRAINT [DF__award_exc__State__619B8048]  DEFAULT ((0)) FOR [State]
GO
/****** Object:  Default [DF_award_exchange_audit_LogTime]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[award_exchange_audit] ADD  CONSTRAINT [DF_award_exchange_audit_LogTime]  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF_admin_op_log_OperatorTime]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[admin_op_log] ADD  CONSTRAINT [DF_admin_op_log_OperatorTime]  DEFAULT (getdate()) FOR [OperatorTime]
GO
/****** Object:  Default [DF_admin_login_log_LoginTime]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[admin_login_log] ADD  CONSTRAINT [DF_admin_login_log_LoginTime]  DEFAULT (getdate()) FOR [LoginTime]
GO
/****** Object:  Default [DF_admin_IsActive]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[admin] ADD  CONSTRAINT [DF_admin_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_admin_RegisterTime]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[admin] ADD  CONSTRAINT [DF_admin_RegisterTime]  DEFAULT (getdate()) FOR [RegisterTime]
GO
/****** Object:  Default [DF__activity___Opera__0AD2A005]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[activity_userinfo] ADD  DEFAULT (getdate()) FOR [OperateTime]
GO
/****** Object:  Default [DF__activity___Activ__014935CB]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[activity_prize] ADD  DEFAULT ((0)) FOR [ActivityName]
GO
/****** Object:  Default [DF__activity___Prize__023D5A04]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[activity_prize] ADD  DEFAULT ((0)) FOR [PrizeType]
GO
/****** Object:  Default [DF__activity___PType__03317E3D]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[activity_prize] ADD  DEFAULT ((0)) FOR [PType]
GO
/****** Object:  Default [DF__activity___Prize__0425A276]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[activity_prize] ADD  DEFAULT ((0)) FOR [PrizeValue]
GO
/****** Object:  Default [DF__activity___LogTi__0519C6AF]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[activity_prize] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
/****** Object:  Default [DF_activity_prize_IsGet]    Script Date: 11/13/2018 14:49:13 ******/
ALTER TABLE [dbo].[activity_prize] ADD  CONSTRAINT [DF_activity_prize_IsGet]  DEFAULT ((0)) FOR [IsGet]
GO
