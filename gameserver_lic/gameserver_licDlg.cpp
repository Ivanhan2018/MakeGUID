
// gameserver_licDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "gameserver_lic.h"
#include "gameserver_licDlg.h"
#include "afxdialogex.h"

#include "INIFile.h"
#include "Encrypt.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////////////////
#include "Hardwareinfo.h"
//��Ϣ����
#define WM_PROCESS_CMD_LINE			(WM_USER+100)						//��������
//////////////////////////////////////////////////////////////////////////////////

#define	WLOG	OutputDebugString

// ��������:  ��ȡ��ǰ�ꡢ�¡��ա�ʱ���֡���
bool GetCurCalendar(int& year, int& month, int& day, int& hour, int& minute, int& second)
{
    SYSTEMTIME st;	
#ifdef WIN32
	::GetLocalTime(&st);
#else
	struct timeval tv;
	gettimeofday (&tv , NULL);

	tm tm_now ;
	localtime_r(&tv.tv_sec,&tm_now);

	st.wYear = tm_now.tm_year+1900;
	st.wMonth = tm_now.tm_mon+1;
	st.wDay = tm_now.tm_mday;
	st.wDayOfWeek = (tm_now.tm_wday+1)%7;
	st.wHour =tm_now.tm_hour;
	st.wMinute = tm_now.tm_min;
	st.wSecond = tm_now.tm_sec;
	st.wMilliseconds = tv.tv_usec/1000;
#endif	
	year = st.wYear;
	month = st.wMonth;
	day = st.wDay;
	hour = st.wHour;
	minute = st.wMinute;
	second = st.wSecond;  
    return true;
}

//���16�����ַ�
CString HexShow(BYTE* sStr, int iLen, int iFlag)
{
	CString strHex;
	if(iLen <= 0)
		return strHex;
	register int iCount;
	for (iCount = 0; iCount < iLen; iCount++)
	{
		if (iCount % 36 == 0) 
			WLOG(L"\n");
		if (iFlag && sStr[iCount] > 0x1f) 
			TRACE(L"%2C ", sStr[iCount]);
		else 
		{
			CString strTemp;
			strTemp.Format(L"%.2X", sStr[iCount]);
			strHex += strTemp;
			TRACE(L"%.2X ", sStr[iCount]);
		}
	}
	if ((iCount - 1) % 36) 
		WLOG(L"\n");
	WLOG(L"\n");
	return strHex;
}

//�򵥼���
void	SimpleDecode(byte* szIn, int nLen)
{
	for(int n=0; n<nLen; n++)
	{
		szIn[n] ^= 0xFF;
		szIn[n] ^= 0xAC;
	}
}

//���ɻ�����
CString	GetMachineCode()
{
	BOOL	bRet = FALSE;
	BYTE	szSystemInfo[1024];
	UINT	uLen=0;
	memset(szSystemInfo, 0x00, sizeof(szSystemInfo));
	bRet = GetMacAddr(szSystemInfo, uLen);
	
	//cpuid
	GetCpuID(szSystemInfo, 12);

#ifdef	_DEBUG
	WLOG(HexShow(szSystemInfo, 10, 0));
#endif
	SimpleDecode(szSystemInfo, 10);
	CString strLocalCode = HexShow(szSystemInfo, 10, 0);
	memset(szSystemInfo, 0x00, sizeof(szSystemInfo));
	bRet = GetHdiskSerial(szSystemInfo, uLen);


#ifdef	_DEBUG
	WLOG(HexShow(szSystemInfo, 32, 0));
#endif	
//	SimpleDecode(szSystemInfo, 32);
	strLocalCode += (char*)szSystemInfo;
	strLocalCode.Replace(L" ", L"");
	strLocalCode.Replace(L"-", L"");
#ifdef _DEBUG
	WLOG(strLocalCode);
#endif
	for(int n=0; n<strLocalCode.GetLength(); n++)
	{
		if(n%6 == 0 && n!= 0)
			strLocalCode.Insert(n, L"-");
	}
#ifdef _DEBUG
	WLOG(L"\n");
	WLOG(strLocalCode);
#endif
	strLocalCode = strLocalCode.Left(48);
	return strLocalCode;
}

//У��License.
//����ֵ��0	�ɹ�
//1 �ļ������ڣ�2 �ļ��ѹ��ڣ�3 �ļ���ʽ����ȷ��
int checkLicense(CString strInputCode, CString& strExpireDate)
{
	CString strLicenseFile = CINIFile::GetAppPath()+L"License.dat";
	if(!CINIFile::IsFileExist(strLicenseFile))
		return 1;
	CINIFile	iniFile(strLicenseFile);
	strExpireDate = iniFile.GetKeyVal(L"LICENSE", L"EXPRIREDATE",L"20090101");
	CString strLicenseCode= iniFile.GetKeyVal(L"LICENSE", L"LicenseCode",L"0123456789");
	if(strExpireDate.IsEmpty() || strExpireDate.GetLength() < 8)
		return 3;
	CTime tmExpire = CTime(_wtoi(strExpireDate.Left(4)), _wtoi(strExpireDate.Mid(4, 2)), _wtoi(strExpireDate.Right(2)), \
		0, 0, 0);
	CTime tmNow = CTime::GetCurrentTime();

	bool bIsValid = (tmExpire - tmNow) >= 0;
	if( !bIsValid )
		return 2;

	USES_CONVERSION;
	CString strInputLicense = strInputCode.GetBuffer(1);
	strInputLicense.Replace(L"-", L"");
	strInputLicense.Insert(5,strExpireDate.Left(2));
	strInputLicense.Insert(10, strExpireDate.Mid(2, 2));
	strInputLicense.Insert(15, strExpireDate.Mid(4, 2));
	strInputLicense.Insert(20, strExpireDate.Right(2));

	TCHAR szMD5Result[33];
	memset(szMD5Result, 0x00, sizeof(szMD5Result));
	CMD5Encrypt::EncryptData((LPCTSTR)strInputLicense , szMD5Result);
	
	CString strUpperCode = HexShow((BYTE*)W2A(szMD5Result), _tcsclen(szMD5Result), 0);
	strUpperCode.MakeUpper();
	if(strLicenseCode.MakeUpper().Compare(strUpperCode) == 0)
		return 0;
	else
		return 2;
}

bool CreateLicenseFile(TCHAR* szFileName, TCHAR* szMachineCode, TCHAR* szExpireCode)
{
	CFile licenseFile;
	if(licenseFile.Open(szFileName,CFile::modeReadWrite|CFile::modeCreate))
	{
		CString strLicenseCode = szMachineCode;
		strLicenseCode.Replace(L"-", L"");
		CString strExpireCode = szExpireCode;
		strLicenseCode.Insert(5,  strExpireCode.Left(2));
		strLicenseCode.Insert(10, strExpireCode.Mid(2, 2));
		strLicenseCode.Insert(15, strExpireCode.Mid(4, 2));
		strLicenseCode.Insert(20, strExpireCode.Right(2));

		USES_CONVERSION;
		TCHAR szMD5Result[33];
		memset(szMD5Result, 0x00, sizeof(szMD5Result));
		CMD5Encrypt::EncryptData((LPCTSTR)strLicenseCode, szMD5Result);
		licenseFile.Write("[LICENSE]\n", strlen("[LICENSE]\n"));
		licenseFile.Write("VERSION=2.0\nPROVIDER=Typingsoft\n", strlen("VERSION=2.0\nPROVIDER=Typingsoft\n"));
		licenseFile.Write("EXPRIREDATE=", strlen("EXPRIREDATE="));
		licenseFile.Write(W2A(szExpireCode), strlen(W2A(szExpireCode)));
		licenseFile.Write("\n", strlen("\n"));
		licenseFile.Write("LicenseCode=", strlen("LicenseCode="));

		CString strMd5Code = HexShow((BYTE*)W2A(szMD5Result), _tcsclen(szMD5Result), 0);
		strMd5Code.MakeUpper();
		licenseFile.Write(W2A(strMd5Code.GetBuffer(1)), strMd5Code.GetLength());
		licenseFile.Write("\n", strlen("\n"));
		licenseFile.Close();
	}
	return true;
}

const CString GetLicenseDesc(int nCode)
{
	if(nCode == 1)
		return TEXT("�ļ������ڣ�������ΪLicense.dat���ļ�����ȷ�ϸ��ļ��ڷ����������·���У�\n������Ϊ��");
	else if(nCode == 2)
		return TEXT("License.dat�ļ��ѹ��ڣ�����ϵ�������ṩ���µ�License��������Ϊ��");
	else if(nCode == 3)
		return TEXT("�ļ���ʽ����ȷ������License.dat�ļ���������Ϊ��");
	else
		return TEXT("LicenseУ��ɹ���");
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ����Ӧ�ó��򡰹��ڡ��˵���� CAboutDlg �Ի���

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// �Ի�������
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

// ʵ��
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// Cgameserver_licDlg �Ի���




Cgameserver_licDlg::Cgameserver_licDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(Cgameserver_licDlg::IDD, pParent)
	, m_strMCodeLbl(_T("�����룺"))
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	int year, month, day, hour, minute,second;
    GetCurCalendar(year, month, day, hour, minute, second);
	m_strDate.Format(_T("%d%02d%02d"), year, month, day);
}

void Cgameserver_licDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT_TO_STRING, m_ctrlToString);
	DDX_Control(pDX, IDC_EDIT_FROM_STRING, m_ctrlMCode);
	DDX_Control(pDX, IDC_EDIT_TO_HEX, m_ctrlExpireDate);
	DDX_Text(pDX, IDC_EDIT_FROM_INT, m_strDate);
	DDX_Text(pDX, IDC_EDIT_TO_INT, m_strMCodeLbl);
}

BEGIN_MESSAGE_MAP(Cgameserver_licDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BT_INT2STR, &Cgameserver_licDlg::OnBnClickedBtInt2str)

	ON_EN_CHANGE(IDC_EDIT_FROM_INT, &Cgameserver_licDlg::OnEnChangeEditFromInt)
	ON_EN_CHANGE(IDC_EDIT_FROM_STRING, &Cgameserver_licDlg::OnEnChangeEditFromString)
	ON_BN_CLICKED(IDC_BT_STR2INT, &Cgameserver_licDlg::OnBnClickedBtStr2int)
END_MESSAGE_MAP()


// Cgameserver_licDlg ��Ϣ�������

BOOL Cgameserver_licDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// ��������...���˵�����ӵ�ϵͳ�˵��С�

	// IDM_ABOUTBOX ������ϵͳ���Χ�ڡ�
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������
	CString strMcode = GetMachineCode();
	m_ctrlToString.SetWindowText(strMcode);
	m_ctrlMCode.SetWindowText(strMcode);
	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

void Cgameserver_licDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void Cgameserver_licDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR Cgameserver_licDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

void Cgameserver_licDlg::OnEnChangeEditFromInt()
{
	UpdateData();
}

void Cgameserver_licDlg::OnEnChangeEditFromString()
{
	UpdateData();
}

// ���License
void Cgameserver_licDlg::OnBnClickedBtInt2str()
{
	CString strMcode = GetMachineCode();
	CString strExpireDate;
	int nCode = checkLicense(strMcode, strExpireDate);
	m_ctrlExpireDate.SetWindowText(strExpireDate);
	if ( nCode != 0)
	{
		MessageBox(GetLicenseDesc(nCode)+strMcode);
		return;
	}
}

// ��Ȩ��
void Cgameserver_licDlg::OnBnClickedBtStr2int()
{
	UpdateData(FALSE);
	CString strLicenseFile = CINIFile::GetAppPath()+_T("License.dat");
	bool bRet=CreateLicenseFile((TCHAR *)strLicenseFile.GetString(), (TCHAR *)m_strMCodeLbl.GetString(),(TCHAR *)m_strDate.GetString());
	if ( bRet)
	{
		CString strTmp;
		strTmp.Format(_T("�ɹ�������Ȩ�ļ�%s"), strLicenseFile);
		return;
	}
}
