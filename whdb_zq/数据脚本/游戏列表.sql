
----------------------------------------------------------------------------------------------------

USE ZQServerInfoDB
GO

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

-- 财富游戏
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 1, 1, '按钮梭哈', 'ShowHandAN.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 1, 1, '筹码梭哈', 'ShowHandCM.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 1, 1, '数字梭哈', 'ShowHandSZ.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 2, 1, '按钮五张', 'HKFiveCardAN.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 2, 1, '筹码五张', 'HKFiveCardCM.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 2, 1, '数字五张', 'HKFiveCardSZ.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 3, 1, '德州扑克', 'DZShowHand.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 4, 1, '二人牛牛', 'OxEx.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 5, 1, '牛牛', 'Ox.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 6, 1, '诈金花', 'ZaJinHua.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 7, 1, '十三张', 'Thirteen.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 8, 1, '二八杠', '28Gang.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 9, 1, '推筒子', 'TuiTongZi.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 10, 1, '疯狂斗地主', 'LandCrazy.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 11, 1, '扯旋', 'CheXuan.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 12, 1, '红九', 'RedNine.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 13, 1, '摇骰子', 'Liarsdice.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 14, 1, '牌九', 'PaiJiu.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 15, 1, '十点半', 'TenHalfPoint.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 16, 1, '21 点', 'BlackJack.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 17, 1, '填大坑', 'TianDaKeng.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 18, 1, '四张', 'FourCard.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 19, 1, '二人梭哈', 'ShowHandANEx.exe', 67078, 100, 0, 'ZQTreasureDB')


-- 百人游戏
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 100, 2, '百家乐', 'Baccarat.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 101, 2, '百人单双', 'DanShuangBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 102, 2, '百人梭哈', 'ShowHandBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 103, 2, '十二生肖', 'ZodiacBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 104, 2, '百人牛牛', 'OxBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 105, 2, '两张', 'RedNineBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 106, 2, '百人牌九', 'PaiJiuBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 107, 2, '百人龙虎斗', 'LongHuDouBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 108, 2, '碰碰车', 'BumperCarBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 109, 2, '百人小九', 'NineXiaoBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 110, 2, '百人憋十', 'BieShiBattle.exe', 67078, 100, 0, 'ZQTreasureDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 111, 2, '百人骰子', 'DiceBattle.exe', 67078, 100, 0, 'ZQTreasureDB')

-- 扑克游戏
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 200, 3, '斗地主', 'Land.exe', 67078, 100, 0, 'ZQLandDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 201, 3, '两副斗地主', 'Land2.exe', 67078, 100, 0, 'ZQLand2DB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 202, 3, '两人斗地主', 'LandEx.exe', 67078, 100, 0, 'ZQLandExDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 203, 3, '两幅升级', 'UpGrade2.exe', 67078, 100, 0, 'ZQUpGrade2DB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 204, 3, '三幅升级', 'UpGrade3.exe', 67078, 100, 0, 'ZQUpGrade3DB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 205, 3, '四幅升级', 'UpGrade4.exe', 67078, 100, 0, 'ZQUpGrade4DB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 206, 3, '广西升级', 'UpGradeGX.exe', 67078, 100, 0, 'ZQUpGradeGXDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 207, 3, '广西标分', 'BiaoFen.exe', 67078, 100, 0, 'ZQBiaoFenDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 208, 3, '二人双扣', 'ShuangKouEx.exe', 67078, 100, 0, 'ZQShuangKouExDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 209, 3, '双扣', 'ShuangKou.exe', 67078, 100, 0, 'ZQShuangKouDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 210, 3, '千变双扣', 'ShuangKouQB.exe', 67078, 100, 0, 'ZQShuangKouQBDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 211, 3, '百变双扣', 'ShuangKouBB.exe', 67078, 100, 0, 'ZQShuangKouBBDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 212, 3, '关牌', 'GuanPaiBG.exe', 67078, 100, 0, 'ZQGuanPaiBGDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 213, 3, '关牌', 'GuanPai.exe', 67078, 100, 0, 'ZQGuanPaiDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 214, 3, '锄大地', 'ChuDaDi.exe', 67078, 100, 0, 'ZQChuDaDiDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 215, 3, '拱猪', 'GongZhu.exe', 67078, 100, 0, 'ZQGongZhuDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 216, 3, '挖坑', 'WaKeng.exe', 67078, 100, 0, 'ZQWaKengDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 217, 3, '510K', '510K.exe', 67078, 100, 0, 'ZQ510KDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 218, 3, '红五', 'HongWu.exe', 67078, 100, 0, 'ZQHongWuDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 219, 3, '红五两副', 'HongWu2.exe', 67078, 100, 0, 'ZQHongWu2DB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 220, 3, '红五三副', 'HongWu3.exe', 67078, 100, 0, 'ZQHongWu3DB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 221, 3, '三打一', 'SanDaYi.exe', 67078, 100, 0, 'ZQSanDaYiDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 222, 3, '宿迁掼蛋', 'GuanDanSQ.exe', 67078, 100, 0, 'ZQGuanDanSQDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 223, 3, '淮安掼蛋', 'GuanDanHA.exe', 67078, 100, 0, 'ZQGuanDanHADB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 224, 3, '湖南三打哈', 'SanDaHaHN.exe', 67078, 100, 0, 'ZQSanDaHaHNDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 225, 3, '红十', 'RedTen.exe', 67078, 100, 0, 'ZQRedTenDB')

-- 麻将游戏
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 300, 4, '大众麻将', 'SparrowDZ.exe', 67078, 100, 0, 'ZQSparrowDZDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 301, 4, '国标麻将', 'SparrowGB.exe', 67078, 100, 0, 'ZQSparrowGBDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 302, 4, '血战麻将', 'SparrowXZ.exe', 67078, 100, 0, 'ZQSparrowXZDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 303, 4, '长沙麻将', 'SparrowCS.exe', 67078, 100, 0, 'ZQSparrowCSDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 304, 4, '浙江麻将', 'SparrowZJ.exe', 67078, 100, 0, 'ZQSparrowZJDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 305, 4, '长春麻将', 'SparrowCC.exe', 67078, 100, 0, 'ZQSparrowCCDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 306, 4, '二人麻将', 'SparrowER.exe', 67078, 100, 0, 'ZQSparrowERDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 307, 4, '温州麻将', 'SparrowWZ.exe', 67078, 100, 0, 'ZQSparrowWZDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 308, 4, '温州二人麻将', 'SparrowWZEX.exe', 67078, 100, 0, 'ZQSparrowWZEXDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 309, 4, '宁海麻将', 'SparrowNH.exe', 67078, 100, 0, 'ZQSparrowNHDB')



-- 棋类游戏
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 400, 5, '中国象棋', 'ChinaChess.exe', 67078, 100, 0, 'ZQChinaChessDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 401, 5, '五子棋', 'GoBang.exe', 67078, 100, 0, 'ZQGoBangDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 402, 5, '四国军棋', 'FourEnsign.exe', 67078, 100, 0, 'ZQFourEnsignDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 403, 5, '围棋', 'WeiQi.exe', 67078, 100, 0, 'ZQWeiQiDB')


-- 休闲游戏
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 500, 6, '连连看', 'LLShow.exe', 67078, 100, 0, 'ZQLLShowDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 501, 6, '飞行棋', 'Plane.exe', 67078, 100, 0, 'ZQPlaneDB')


-- 地方游戏
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 600, 7, '义乌牛公', 'OxYW.exe', 67078, 100, 0, 'ZQOxYWDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 601, 7, '湖南跑得快', 'RunFastHN.exe', 67078, 100, 0, 'ZQRunFastHNDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 602, 7, '跑胡子', 'PaoHuZi.exe', 67078, 100, 0, 'ZQPaoHuZiDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 603, 7, '东北红十', 'RedTenDB.exe', 67078, 100, 0, 'ZQRedTenDBDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 604, 7, '辽源红十', 'RedTenLY.exe', 67078, 100, 0, 'ZQRedTenLYDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 605, 7, '丹东红十', 'RedTenDD.exe', 67078, 100, 0, 'QRedTenDDDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 606, 7, '奉化双扣', 'ShuangKouFH.exe', 67078, 100, 0, 'ZQShuangKouFHDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 607, 7, '宁波斗地主', 'LandLB.exe', 67078, 100, 0, 'ZQLandLBDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 608, 7, '丹东五狼腿', 'WuLangTui.exe', 67078, 100, 0, 'ZQWuLangTuiDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 609, 7, '辽源刨幺', 'PaoYao.exe', 67078, 100, 0, 'ZQPaoYaoDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 610, 7, '三七十', 'SanQiShi.exe', 67078, 100, 0, 'ZQSanQiShiDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 611, 7, '打纵', 'DaZong.exe', 67078, 100, 0, 'ZQDaZongDB')
INSERT GameKindItem (KindID, TypeID, KindName, ProcessName, MaxVersion, SortID, Nullity, DataBaseName) VALUES ( 612, 7, '南京跑得快', 'RunFastNJ.exe', 67078, 100, 0, 'ZQRunFastNJDB')

----------------------------------------------------------------------------------------------------
GO