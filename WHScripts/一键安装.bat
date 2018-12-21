@echo off

TITLE 棋牌数据库【Ver6.6_Spreader】 建立脚本启动中... [期间请勿关闭]

if not exist "G:\WHDB" (
		md G:\WHDB
	)

Rem 建主数据库三个
set rootPath=数据库脚本\
osql -E -i "%rootPath%数据库删除.sql"
osql -E -i "%rootPath%1_1_用户库脚本.sql"
osql -E -i "%rootPath%1_2_平台库脚本.sql"
osql -E -i "%rootPath%1_3_财富库脚本.sql"
osql -E -i "%rootPath%2_1_用户表脚本.sql"
osql -E -i "%rootPath%2_2_平台表脚本.sql"
osql -E -i "%rootPath%2_3_财富表脚本.sql"

Rem 建连接服务和填充数据
set rootPath=数据脚本\
osql -E -i "%rootPath%配置数据.sql"

Rem 存储过程
set rootPath=存储过程\用户库\
osql -E  -i "%rootPath%标识登录.sql"
osql -E  -i "%rootPath%帐号登陆V3R4.sql"
osql -E  -i "%rootPath%注册帐号V3R4.sql"
osql -E  -i "%rootPath%用户权限.sql"
osql -E  -i "%rootPath%禁用帐号.sql"
osql -E  -i "%rootPath%自定义头像.sql"
osql -E  -i "%rootPath%标识登录.sql"
osql -E  -i "%rootPath%定时任务.sql"
osql -E  -i "%rootPath%领低保.sql"
osql -E  -i "%rootPath%领奖励.sql"
osql -E  -i "%rootPath%商城充值.sql"
osql -E  -i "%rootPath%商城兑换.sql"
osql -E  -i "%rootPath%升级成微信帐号.sql"
osql -E  -i "%rootPath%微信帐号绑定手机号.sql"
osql -E  -i "%rootPath%微信帐号注册.sql"
osql -E  -i "%rootPath%修改个人签名.sql"
osql -E  -i "%rootPath%用户签到.sql"
osql -E  -i "%rootPath%用户权限.sql"
osql -E  -i "%rootPath%用户中心.sql"

set rootPath=存储过程\平台库\
osql -E  -i "%rootPath%提交喇叭.sql"
osql -E  -i "%rootPath%运营工具.sql"

set rootPath=存储过程\财富库\
osql -E  -i "%rootPath%标识登录.sql"
osql -E  -i "%rootPath%加载机器人.sql"
osql -E  -i "%rootPath%离开房间.sql"
osql -E  -i "%rootPath%游戏写分.sql"
osql -E  -i "%rootPath%用户权限.sql"
osql -E  -i "%rootPath%购买道具.sql"
osql -E  -i "%rootPath%魅力兑换.sql"
osql -E  -i "%rootPath%鲜花赠送.sql"
osql -E  -i "%rootPath%银行记录.sql"
osql -E  -i "%rootPath%ID登录房间V3R4.sql"
osql -E  -i "%rootPath%读取排行榜V3R4.sql"
osql -E  -i "%rootPath%生成排行榜V3R4.sql"
osql -E  -i "%rootPath%运营工具.sql"

pause

COLOR 0A
CLS
@echo off
cls
echo ------------------------------
echo.
echo	主要数据库建立完成，请根据自己平台的积分游戏执行 
echo.
echo.
echo	版权所有： 深圳市网狐科技有限公司
echo ------------------------------

pause


