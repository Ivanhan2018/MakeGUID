#ifndef ENCRYPT_HEAD_FILE
#define ENCRYPT_HEAD_FILE



//////////////////////////////////////////////////////////////////////////

//MD5 ������ 
class  CMD5Encrypt
{
	//��������
private:
	//���캯��
	CMD5Encrypt() {}

	//���ܺ���
public:
	//��������
	static void EncryptData(LPCTSTR pszSrcData, TCHAR szMD5Result[33]);
};

//////////////////////////////////////////////////////////////////////////

//��������
class  CXOREncrypt
{
	//��������
private:
	//���캯��
	CXOREncrypt() {}

	//���ܺ���
public:
	//��������
	static WORD EncryptData(LPCTSTR pszSrcData, LPTSTR pszEncrypData, WORD wSize);
	//�⿪����
	static WORD CrevasseData(LPCTSTR pszEncrypData, LPTSTR pszSrcData, WORD wSize);
};

//////////////////////////////////////////////////////////////////////////

#endif