
// gameserver_licDlg.h : ͷ�ļ�
//

#pragma once
#include "afxwin.h"


// Cgameserver_licDlg �Ի���
class Cgameserver_licDlg : public CDialogEx
{
// ����
public:
	Cgameserver_licDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_MAIN_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
protected:
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()

	afx_msg void OnBnClickedBtInt2str();
	afx_msg void OnEnChangeEditFromInt();
	afx_msg void OnEnChangeEditFromString();
	afx_msg void OnBnClickedBtStr2int();

public:

	CEdit m_ctrlToString;
	CEdit m_ctrlMCode;	
	CEdit m_ctrlExpireDate;	// �������������
	CString m_strDate;	// ��������
	CString m_strMCodeLbl;
};
