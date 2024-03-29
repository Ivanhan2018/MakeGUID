#ifndef WH_SERVICE_HEAD_FILE
#define WH_SERVICE_HEAD_FILE

#pragma once

#include "ServiceCoreHead.h"

//////////////////////////////////////////////////////////////////////////////////

//系统服务
class SERVICE_CORE_CLASS CWHService
{
	//函数定义
private:
	//构造函数
	CWHService();

	//系统功能
public:
	//拷贝字符
	static bool SetClipboardString(LPCTSTR pszString);

	//?UTF8ToUnicode@CWHService@@SA_NPB_WQA_WG@Z
	//?UnicodeToUTF8@CWHService@@SA_NPB_WQA_WG@Z
	//把UTF-8转换成Unicode
	static bool UTF8ToUnicode(LPCTSTR pszSourceData, TCHAR pszEncrypData[256], WORD wMaxCount);
	// Unicode转换成UTF-8
	static bool UnicodeToUTF8(LPCTSTR pszEncrypData, TCHAR pszSourceData[256], WORD wMaxCount);

	//机器标识
public:
	//机器标识
	static bool GetMachineID(TCHAR szMachineID[LEN_MACHINE_ID]);
	//网卡地址
	static bool GetMACAddress(TCHAR szMACAddress[LEN_NETWORK_ID]);

	//系统热键
public:
	//注销热键
	static bool UnRegisterHotKey(HWND hWnd, UINT uKeyID);
	//注册热键
	static bool RegisterHotKey(HWND hWnd, UINT uKeyID, WORD wHotKey);

	//系统文件
public:
	//工作目录
	static bool GetWorkDirectory(TCHAR szWorkDirectory[], WORD wBufferCount);
	//文件版本
	static bool GetModuleVersion(LPCTSTR pszModuleName, DWORD & dwVersionInfo);

	//压缩函数
public:
	//压缩数据
	static ULONG CompressData(LPBYTE pcbSourceData, ULONG lSourceSize, BYTE cbResultData[], ULONG lResultSize);
	//解压数据
	static ULONG UnCompressData(LPBYTE pcbSourceData, ULONG lSourceSize, BYTE cbResultData[], ULONG lResultSize);
	//压缩数据
	static ULONG LZCompressData(LPBYTE pcbSourceData, ULONG lSourceSize, BYTE cbResultData[], ULONG lResultSize);
	//解压数据
	static ULONG LZUnCompressData(LPBYTE pcbSourceData, ULONG lSourceSize, BYTE cbResultData[], ULONG lResultSize);
};

//////////////////////////////////////////////////////////////////////////////////

#endif