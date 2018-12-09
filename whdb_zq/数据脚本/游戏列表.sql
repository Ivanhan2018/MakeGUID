
----------------------------------------------------------------------------------------------------

USE ZQServerInfoDB
GO

ALTER TABLE [dbo].GameKindItem ADD [GzUrl] [nvarchar](512) NOT NULL CONSTRAINT [DF_GameKindItem_GzUrl]  DEFAULT (N'')
----------------------------------------------------------------------------------------------------

-- 删除数据
DELETE GameTypeItem
DELETE GameKindItem
DELETE GameNodeItem
GO

----------------------------------------------------------------------------------------------------

-- 类型数据
INSERT GameTypeItem (TypeID, TypeName, SortID, Nullity) VALUES ( 1, '财富游戏',100, 0)
INSERT GameTypeItem (TypeID, TypeName, SortID, Nullity) VALUES ( 2, '百人游戏',200, 0)
INSERT GameTypeItem (TypeID, TypeName, SortID, Nullity) VALUES ( 3, '扑克游戏',300, 0)
INSERT GameTypeItem (TypeID, TypeName, SortID, Nullity) VALUES ( 4, '麻将游戏',400, 0)
INSERT GameTypeItem (TypeID, TypeName, SortID, Nullity) VALUES ( 5, '棋类游戏',500, 0)
INSERT GameTypeItem (TypeID, TypeName, SortID, Nullity) VALUES ( 6, '休闲游戏',600, 0)
INSERT GameTypeItem (TypeID, TypeName, SortID, Nullity) VALUES ( 7, '地方游戏',700, 0)


----------------------------------------------------------------------------------------------------

-- 1财富游戏
-- 2百人游戏
-- 3扑克游戏
-- 4麻将游戏
-- 5棋类游戏
-- 6休闲游戏
-- 7地方游戏
----------------------------------------------------------------------------------------------------
GO
delete from GameKindItem where KindID=10 or KindID=303 or KindID=310;
INSERT [dbo].[GameKindItem] ([KindID], [TypeID], [JoinID], [SortID], [KindName], [ProcessName], [MaxVersion], [DataBaseName], [Nullity], [GzUrl]) VALUES (10, 1, 0, 100, N'斗地主', N'LandCrazy.exe', 1, N'ZQTreasureDB', 0, N'LandCrazy.asp')
INSERT [dbo].[GameKindItem] ([KindID], [TypeID], [JoinID], [SortID], [KindName], [ProcessName], [MaxVersion], [DataBaseName], [Nullity], [GzUrl]) VALUES (303, 4, 0, 100, N'转转麻将', N'SparrowZZ.exe', 1, N'ZQTreasureDB', 0, N'SparrowZZ.asp')
INSERT [dbo].[GameKindItem] ([KindID], [TypeID], [JoinID], [SortID], [KindName], [ProcessName], [MaxVersion], [DataBaseName], [Nullity], [GzUrl]) VALUES (310, 4, 0, 100, N'益阳麻将', N'SparrowYY.exe', 1, N'ZQTreasureDB', 0, N'SparrowYY.asp')
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11101, 10, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11102, 10, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11103, 10, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11104, 10, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11105, 10, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11201, 10, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11202, 10, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11203, 10, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11204, 10, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11205, 10, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11301, 10, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11302, 10, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11303, 10, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11304, 10, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11305, 10, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11401, 10, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11402, 10, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11403, 10, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11404, 10, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (11405, 10, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12101, 303, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12102, 303, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12103, 303, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12104, 303, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12105, 303, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12201, 303, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12202, 303, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12203, 303, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12204, 303, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12205, 303, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12301, 303, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12302, 303, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12303, 303, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12304, 303, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12305, 303, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12401, 303, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12402, 303, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12403, 303, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12404, 303, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (12405, 303, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13101, 310, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13102, 310, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13103, 310, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13104, 310, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13105, 310, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13201, 310, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13202, 310, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13203, 310, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13204, 310, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13205, 310, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13301, 310, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13302, 310, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13303, 310, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13304, 310, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13305, 310, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13401, 310, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13402, 310, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13403, 310, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13404, 310, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (13405, 310, 0, 4, N'高级', 0)
INSERT [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (1, 0, 100, N'财富游戏', 0)
INSERT [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (2, 0, 200, N'百人游戏', 0)
INSERT [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (3, 0, 300, N'扑克游戏', 0)
INSERT [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (4, 0, 400, N'麻将游戏', 0)
INSERT [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (5, 0, 500, N'棋类游戏', 0)
INSERT [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (6, 0, 600, N'休闲游戏', 0)
INSERT [dbo].[GameTypeItem] ([TypeID], [JoinID], [SortID], [TypeName], [Nullity]) VALUES (7, 0, 700, N'地方游戏', 0)

INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14101, 6, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14102, 6, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14103, 6, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14104, 6, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14105, 6, 0, 1, N'新手区', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14201, 6, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14202, 6, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14203, 6, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14204, 6, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14205, 6, 0, 2, N'初级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14301, 6, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14302, 6, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14303, 6, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14304, 6, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14305, 6, 0, 3, N'中级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14401, 6, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14402, 6, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14403, 6, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14404, 6, 0, 4, N'高级', 0)
INSERT [dbo].[GameNodeItem] ([NodeID], [KindID], [JoinID], [SortID], [NodeName], [Nullity]) VALUES (14405, 6, 0, 4, N'高级', 0)