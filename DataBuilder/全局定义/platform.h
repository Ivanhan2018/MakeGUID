#ifndef PLATFORM_HEAD_FILE
#define PLATFORM_HEAD_FILE

//////////////////////////////////////////////////////////////////////////////////
//�����ļ�

//�����ļ�
#include "Macro.h"
#include "Define.h"

//�ṹ�ļ�
#include "Struct.h"
#include "Packet.h"

//ģ���ļ�
#include "Array.h"
#include "Module.h"
#include "PacketAide.h"
#include "ServerRule.h"
#include "RightDefine.h"

//////////////////////////////////////////////////////////////////////////////////

//����汾
#define VERSION_FRAME				PROCESS_VERSION(6,0,3)				//��ܰ汾
#define VERSION_PLAZA				PROCESS_VERSION(29,0,16)				//�����汾
#define VERSION_MOBILE				PROCESS_VERSION(6,0,3)				//�ֻ��汾

//������汾
#define VERSION_EFFICACY			0									//Ч��汾
#define VERSION_FRAME_SDK			INTERFACE_VERSION(6,3)				//��ܰ汾

//////////////////////////////////////////////////////////////////////////////////
//�����汾

#ifndef _DEBUG
//ƽ̨����
const TCHAR szProduct[]=TEXT("��������");							//��Ʒ����
const TCHAR szPlazaClass[]=TEXT("AQYGamePlaza");						//�㳡����
const TCHAR szProductKey[]=TEXT("AQYGamePlatform");						//��Ʒ����

//��ַ����
const TCHAR szCookieUrl[]=TEXT("http://reg.hhsmtw.com");					//��¼��ַ
//const TCHAR szLogonServer[]=TEXT("127.0.0.1");						//��¼��ַ
//const TCHAR szLogonServer[]=TEXT("210.56.60.26");						//��¼��ַ
const TCHAR szPlatformLink[]=TEXT("http://114.55.52.46:9999/");					//ƽ̨��վ
const TCHAR szPlatformPublicize[]=TEXT("http://www.baidu.com/ads/GameIndex.aspx");		//������վ
const TCHAR szPlatformTopPublicize[]=TEXT("http://www.baidu.com/ads/GameTopNotice.aspx");	//��������
const TCHAR szPlatformLeftPublicize[]=TEXT("http://www.baidu.com/ads/PlazaIndex.html");	//���½ǹ��
const TCHAR szValidateLink[]=TEXT("UserService/ClientHandler.ashx?action=clientlogon&UID=%d&PWD=%s&URL=/"); //��֤��ַ 


#else

//////////////////////////////////////////////////////////////////////////////////
//�ڲ�汾
//ƽ̨����
const TCHAR szProduct[]=TEXT("��������");							//��Ʒ����
const TCHAR szPlazaClass[]=TEXT("3HQPGamePlaza");						//�㳡����
const TCHAR szProductKey[]=TEXT("3HQPGamePlatform");						//��Ʒ����

//��ַ����
const TCHAR szCookieUrl[]=TEXT("http://www.3hqipai.com");					//��¼��ַ
const TCHAR szLogonServer[]=TEXT("www.3hqipai.com");						//��¼��ַ
const TCHAR szPlatformLink[]=TEXT("http://www.3hqipai.com/");					//ƽ̨��վ
const TCHAR szPlatformPublicize[]=TEXT("http://www.3hqipai.com/ads/GameIndex.aspx");		//������վ
const TCHAR szPlatformTopPublicize[]=TEXT("http://www.3hqipai.com/ads/GameTopNotice.aspx");	//��������
const TCHAR szPlatformLeftPublicize[]=TEXT("http://www.3hqipai.com/ads/PlazaIndex.html");	//���½ǹ��
const TCHAR szValidateLink[]=TEXT("UserService/ClientHandler.ashx?action=clientlogon&UID=%d&PWD=%s&URL=/"); //��֤��ַ 

#endif
//////////////////////////////////////////////////////////////////////////////////

//���ݿ���
const TCHAR 		szPlatformDB[]=TEXT("QPPlatformDB");						//ƽ̨���ݿ�
const TCHAR 		szAccountsDB[]=TEXT("QPAccountsDB");						//�û����ݿ�
const TCHAR		szTreasureDB[]=TEXT("QPTreasureDB");						//�Ƹ����ݿ�
const TCHAR		szEducateDB[]=TEXT("QPEducateDB");						//��ϰ���ݿ� 


//////////////////////////////////////////////////////////////////////////////////

//��Ȩ��Ϣ
const TCHAR szCompilation[]=TEXT("345E2FFA-891E-4021-A57E-80ECF3466896");


//////////////////////////////////////////////////////////////////////////////////

#endif