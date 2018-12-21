
----------------------------------------------------------------------------------------------------

USE WHServerInfoDB
GO

----------------------------------------------------------------------------------------------------

-- É¾³ýÊý¾Ý
DELETE GameConfig
GO

----------------------------------------------------------------------------------------------------

-- Êý¾Ý
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'qd_1', 500, '20150101', 'qiandao 1', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'qd_2', 800, '20150101', 'qiandao 2', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'qd_3', 1000, '20150101', 'qiandao 3', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'qd_4', 1200, '20150101', 'qiandao 4', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'qd_5', 1500, '20150101', 'qiandao 5', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'qd', '500,800,1000,1200,1500', '20150101', 'qiandao', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'wx', 1000, '20150101', 'wx', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'wy', 500, '20150101', 'wy', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'di_c', 3, '20150101', 'di_c', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'di_s', 1000, '20150101', 'zui shao caifu', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'di_w', 1000, '20150101', 'fa fang shu', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'fx', 100, '20150101', 'fen xiang', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'fj', 5, '20150101', 'fa jiang', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'r3', '5/300,20/1000,50/1500', '20150101', 'pan shu', 1, ',daye,yangxin,')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'r3_j1', '300', '20150101', 'jiang 1', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'r3_j2', '1000', '20150101', 'jiang 2', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'r3_j3', '1500', '20150101', 'jiang 3', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'r4', '5/300,20/1000,50/1500', '20150101', 'pan shu', 1, ',huangshi,daye,')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'r4_j1', '300', '20150101', 'jiang 1', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'r4_j2', '1000', '20150101', 'jiang 2', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'r4_j3', '1500', '20150101', 'jiang 3', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'wx_task', '6', '20150101', 'wei xin kai guan', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'bk', '20000', '20150101', 'bank', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'tg', '0', '20150101', 'tui guang', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'dx2', '0/1/1/1/0', '20150101', 'duandai,zhifubao,weixin,yinlian,app,yinlian2', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'apppay', '0/1/1/0/1', '20150101', 'duandai,zhifubao,weixin,yinlian,apppay', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'yxapppay', '0/1/1/0/1', '20150101', 'duandai,zhifubao,weixin,yinlian,apppay', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'yxap_21', '0/1/1/0/1', '20150101', 'duandai,zhifubao,weixin,yinlian,apppay', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'ap_24', '0/1/1/1/1', '20150101', 'duandai,zhifubao,weixin,yinlian,apppay', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'cx', '10', '20150101', 'cu xiao, yan shi', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'lb', '15/3/5000/60', '20150101', 'yanshi,pai dui,hua fei,jian ge', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'speaker', '5000', '20150101', 'hua fei', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'f_cb196', '1/0/0', '20150101', 'func android', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'f_cb212', '1/1/1', '20150101', 'func ios', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'sj', '10000', '20150101', 'guest account sheng ji client', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'sj_v', '10000', '20150101', 'guest account sheng ji server', 0, '')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'qqz', '1000', '20150101', 'qq zone', 1, 'all')
INSERT GameConfig (Name, Value, ValidDate, Describe, ToClient, LoginServer) VALUES ( 'qqy', '500', '20150101', 'qq', 1, 'all')


-----------------------------------------------------------

INSERT UserConfig (K, V, IsValid, OrderID, Version) VALUES ( 'wx_t', 'Íøºü¿Æ¼¼', 1, 1, 0)
INSERT UserConfig (K, V, IsValid, OrderID, Version) VALUES ( 'wx_c', '»¶Ó­Ê¹ÓÃÍøºü¿Æ¼¼²úÆ·', 1, 1, 0)
INSERT UserConfig (K, V, IsValid, OrderID, Version) VALUES ( 'wx_a', 'http://www.kaayou.com', 1, 1, 0)
INSERT UserConfig (K, V, IsValid, OrderID, Version) VALUES ( 'wx_p', 'http://img.kaayou.com/fenxiang/share2.png', 1, 1, 0)
INSERT UserConfig (K, V, IsValid, OrderID, Version) VALUES ( 'qq_p', 'http://img.kaayou.com/fenxiang/share1.png', 1, 1, 0)

----------------------------------------------------------------------------------------------------


USE WHGameUserDB
GO

----------------------------------------------------------------------------------------------------

-- É¾³ýÊý¾Ý
DELETE UserExchangeProduct
GO


INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, AwardName, AwardImg) VALUES (1, 200, 5, 0, 4, '10Ôª»°·Ñ', 'http://img.kaayou.com/duihuan/1.png')
INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, AwardName, AwardImg) VALUES (2, 570, 90, 0, 5, '30Ôª»°·Ñ', 'http://img.kaayou.com/duihuan/2.png')
INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, AwardName, AwardImg) VALUES (3, 900, 80, 0, 6, '50Ôª»°·Ñ', 'http://img.kaayou.com/duihuan/3.png')
INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, AwardName, AwardImg) VALUES (4, 40000, 1, 0, 7, 'Ð¡Ã×ÊÖ»ú4', 'http://img.kaayou.com/duihuan/4.png')
INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, AwardName, AwardImg) VALUES (5, 60000, 1, 0, 8, 'iPad mini3 16G Wifi°æ', 'http://img.kaayou.com/duihuan/5.png')
INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, AwardName, AwardImg) VALUES (6, 100000, 1, 0, 9, 'iPhone6', 'http://img.kaayou.com/duihuan/6.png')

INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, Type, ScoreNum, AwardName, AwardImg) VALUES (7, 10, 10, 0, 1, 1, 10000, '10000»¶ÀÖ¶¹', 'http://img.kaayou.com/duihuan/dou3.png')
INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, Type, ScoreNum, AwardName, AwardImg) VALUES (8, 28, 10, 0, 2, 1, 30000, '30000»¶ÀÖ¶¹', 'http://img.kaayou.com/duihuan/dou2.png')
INSERT UserExchangeProduct (AwardID, Price, Lefts, Deleted, OrderID, Type, ScoreNum, AwardName, AwardImg) VALUES (9, 45, 10, 0, 3, 1, 50000, '50000»¶ÀÖ¶¹', 'http://img.kaayou.com/duihuan/dou1.png')


GO

-----------------------Ìí¼ÓÉÌÆ·
-- É¾³ýÊý¾Ý
DELETE UserMallProduct
GO

INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 1, 100, 0, '8888»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao1.png', '001', 0, 8888, 1)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 2, 500, 0, '100,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao2.png', '002', 0, 100000, 2)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 3, 1000, 0, '200,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao3.png', '003', 0, 200000, 3)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 4, 3000, 0, '612,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao4.png', '004', 0, 612000, 4)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 5, 5000, 0, '1,050,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao5.png', '005', 0, 1050000, 5)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 6, 10000, 0, '2,100,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao5.png', '006', 0, 2100000, 6)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 7, 30000, 0, '6,300,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao6.png', '007', 0, 6300000, 7)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 8, 50000, 0, '11000000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao8.png', '008', 0, 11000000, 8)


INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 99, 300, 0, '60,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao1.png', '201601110000', 1, 60000, 99)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 100, 600, 0, '120,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao1.png', '201601110001', 1, 120000, 100)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 101, 1200, 0, '240,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao2.png', '201601110002', 1, 240000, 101)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 102, 1800, 0, '367,200»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao3.png', '201601110003', 1, 367200, 102)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 103, 4000, 0, '816,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao4.png', '201601110004', 1, 836000, 103)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 104, 6800, 0, '1,428,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao5.png', '201601110005', 1, 1428000, 104)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 105, 12800, 0, '2,688,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao6.png', '201601110006', 1, 2688000, 105)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 106, 19800, 0, '4,158,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao7.png', '201601110007', 1, 4158000, 106)
INSERT UserMallProduct (productID,productPrice,Deleted,ProductName,productImg,BillingIndex,Type,scoreNum,OrderID) VALUES ( 107, 28800, 0, '6,048,000»¶ÀÖ¶¹', 'http://img.kaayou.com/shangcheng/tubiao8.png', '201601110008', 1, 6088000, 107)

GO

