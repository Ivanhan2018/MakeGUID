use ZQGameUserDB;
GO
/****** Object:  Table [dbo].[PlacardCommon]    Script Date: 2018/11/12 23:00:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlacardCommon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[State] [tinyint] NOT NULL,
	[Context] [text] NOT NULL,
	[Flag] [tinyint] NOT NULL CONSTRAINT [DF_PlacardInfo_Flag]  DEFAULT ((1)),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Placard_info_create_date]  DEFAULT (getdate()),
 CONSTRAINT [PK_placard_info] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
