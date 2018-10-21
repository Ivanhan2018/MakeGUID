#ifndef ENCRYPT_HEAD_FILE
#define ENCRYPT_HEAD_FILE

//#include "ComService.h"

//////////////////////////////////////////////////////////////////////////

//MD5 加密类
class CMD5Encrypt
{
	//函数定义
private:
	//构造函数
	CMD5Encrypt() {}

	//功能函数
public:
	//生成密文
	static void EncryptData(LPCSTR pszSrcData, CHAR szMD5Result[33]);
};

//////////////////////////////////////////////////////////////////////////

//6601异或加密类<密钥长度为5>
class CXOREncryptA
{
	//函数定义
private:
	//构造函数
	CXOREncryptA() {}

	//功能函数
public:
	//生成密文
	static WORD EncryptData(LPCSTR pszSrcData, LPSTR pszEncrypData, WORD wSize);
	//解开密文
	static WORD CrevasseData(LPCSTR pszEncrypData, LPSTR pszSrcData, WORD wSize);
};

//6603异或加密类<密钥长度为8>
class CXOREncryptW
{
	//函数定义
private:
	//构造函数
	CXOREncryptW() {}

	//功能函数
public:
	//生成密文
	static WORD EncryptData(LPCWSTR pszSourceData, LPWSTR pszEncrypData, WORD wMaxCount/*unsigned char * pszSrcData, unsigned char* pszEncrypData, WORD wSize*/);
	//解开密文
	static WORD CrevasseData(LPCWSTR pszEncrypData, LPWSTR pszSourceData, WORD wMaxCount/*unsigned char * pszEncrypData, unsigned char* pszSrcData, WORD wSize*/);
};

//////////////////////////////////////////////////////////////////////////

#endif