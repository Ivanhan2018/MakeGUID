use ZQGameUserDB;
ALTER TABLE [dbo].IndividualDatum ADD [BirthDay] [datetime] NULL
ALTER TABLE [dbo].IndividualDatum ADD [CityID] [int] NOT NULL CONSTRAINT [DF_IndividualDatum_CityID]  DEFAULT ((0))
ALTER TABLE [dbo].IndividualDatum ADD [Education] [tinyint] NOT NULL CONSTRAINT [DF_IndividualDatum_Education]  DEFAULT ((0))
ALTER TABLE [dbo].IndividualDatum ADD [Vocation] [tinyint] NOT NULL CONSTRAINT [DF_IndividualDatum_Vocation]  DEFAULT ((0))
ALTER TABLE [dbo].IndividualDatum ADD [InCome] [tinyint] NOT NULL CONSTRAINT [DF_IndividualDatum_InCome]  DEFAULT ((0))
ALTER TABLE [dbo].IndividualDatum ADD [NetType] [varchar](30) NULL CONSTRAINT [DF_IndividualDatum_NetType]  DEFAULT ((0))
ALTER TABLE [dbo].IndividualDatum ADD [FaceID] [int] NOT NULL CONSTRAINT [DF_IndividualDatum_FaceID]  DEFAULT ((0))