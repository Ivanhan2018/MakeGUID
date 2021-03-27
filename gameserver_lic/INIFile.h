#pragma once

#include "afxwin.h"

//////////////////////////////////////////////////////////////////////////////////
class CINIFile  
{
  CString	m_lpFileName ;
  DWORD		m_mMaxSize ;
public:
	//�ж��ļ��Ƿ����
	static bool IsFileExist(CString fileName);

	//�ж�Ŀ¼�Ƿ����
	static bool	IsFolderExist(CString strFolder);

	//�����ļ�
	static void CopyFileTo(CString destFileName,CString srcFileName);
	
	//����INI�ļ�����
	void SetINIFileName(CString fileName);

	//���ϵͳ·��
	static CString GetWinSysPath();
	
	//���Ӧ�ó���·����EXE��
	static CString GetAppPath();

	//����KEY���INI�ļ���ֵ
	int GetKeyVal(CString secName,CString keyName,int lpDefault);

	//����KEY���INI�ļ���ֵ
//	double GetKeyVal(CString secName,CString keyName,double ldDefault);

	//����Key���INI�ļ���ֵ
	CString GetKeyVal(CString secName,CString keyName,LPCTSTR lpDefault);
	
	//дINI�ļ�
	void SetKeyValString(CString secName,CString keyName,CString Val);

	//���캯��		
	CINIFile(CString FileName,int maxsize=255);

	//��������
	~CINIFile();
};

//////////////////////////////////////////////////////////////////////////////////