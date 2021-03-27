
// gameserver_licDlg.h : 头文件
//

#pragma once
#include "afxwin.h"


// Cgameserver_licDlg 对话框
class Cgameserver_licDlg : public CDialogEx
{
// 构造
public:
	Cgameserver_licDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_MAIN_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
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
	CEdit m_ctrlExpireDate;	// 过期日期输入框
	CString m_strDate;	// 过期日期
	CString m_strMCodeLbl;
};
