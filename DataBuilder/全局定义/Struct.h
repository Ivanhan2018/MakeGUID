#ifndef STRUCT_HEAD_FILE
#define STRUCT_HEAD_FILE

#pragma pack(1)

//////////////////////////////////////////////////////////////////////////////////
//��Ϸ�б�

//��Ϸ����
struct tagGameType
{
	WORD							wSortID;							//��������
	WORD							wTypeID;							//��������
	TCHAR							szTypeName[LEN_TYPE];				//��������
};

//��Ϸ����
struct tagGameKind
{
	WORD							wTypeID;							//��������
	WORD							wSortID;							//��������
	WORD							wKindID;							//��������
	WORD							wGameID;							//ģ������
	DWORD							dwOnLineCount;						//��������
	TCHAR							szKindName[LEN_KIND];				//��Ϸ����
	TCHAR							szProcessName[LEN_PROCESS];			//��������
};

//��Ϸ����
struct tagGameServer
{
	//������Ϣ
	WORD							wKindID;							//��������
	WORD							wSortID;							//��������
	WORD							wServerID;							//��������
	WORD							wServerPort;						//����˿�
	DWORD							dwOnLineCount;						//��������

	//������Ϣ
	SCORE							lServerScore;						//��Ԫ����
	SCORE							lMinServerScore;					//��Ҫ����

	//������Ϣ
	TCHAR							szServerAddr[32];					//��������
	TCHAR							szServerName[LEN_SERVER];			//��������

	//�γ����緿������
	WORD							wServerKind;							//�Ƿ���������
	TCHAR							szServerPassWork[LEN_SERVER];			//��������

};

//������Ϣ
struct tagOnLineInfoKind
{
	WORD							wKindID;							//���ͱ�ʶ
	DWORD							dwOnLineCount;						//��������
};

//������Ϣ
struct tagOnLineInfoServer
{
	WORD							wServerID;							//�����ʶ
	DWORD							dwOnLineCount;						//��������
};

//////////////////////////////////////////////////////////////////////////////////
//�û���Ϣ

//����״̬
struct tagTableStatus
{
	BYTE							cbTableLock;						//������־
	BYTE							cbPlayStatus;						//��Ϸ��־
};

//�û�״̬
struct tagUserStatus
{
	WORD							wTableID;							//��������
	WORD							wChairID;							//����λ��
	BYTE							cbUserStatus;						//�û�״̬
};

//�û���չ��Ϣ
struct tagUserSpreadInfo
{	
	TCHAR                           szIpAddrDescribe[128];              //��ַ����
};

//�û�����
struct tagUserScore
{
	SCORE							lScore;								//�û�����
	SCORE							lInsure;							//�û�����
	DWORD							dwWinCount;							//ʤ������
	DWORD							dwLostCount;						//ʧ������
	DWORD							dwDrawCount;						//�;�����
	DWORD							dwFleeCount;						//��������
	DWORD							dwExperience;						//�û�����
};

//�ֻ��û�����<add by hxh 20160624>
struct tagMobileUserScore
{
	SCORE							lScore;								//�û�����
	//SCORE							lInsure;							//�û�����
	DWORD							dwWinCount;							//ʤ������
	DWORD							dwLostCount;						//ʧ������
	DWORD							dwDrawCount;						//�;�����
	DWORD							dwFleeCount;						//��������
	DWORD							dwExperience;						//�û�����
};

//�û���Ϣ
struct tagUserInfo
{
	//��������
	DWORD							dwUserID;							//�û� I D
	TCHAR							szNickName[LEN_NICKNAME];			//�û��ǳ�

	//�û�����
	WORD							wFaceID;							//ͷ������
	BYTE							cbGender;							//�û��Ա�
	BYTE							cbMemberOrder;						//��Ա�ȼ�
	BYTE							cbMasterOrder;						//����ȼ�

	//�û�״̬
	WORD							wTableID;							//��������
	WORD							wChairID;							//��������
	BYTE							cbUserStatus;						//�û�״̬

	//������Ϣ
	SCORE							lScore;								//�û�����
	SCORE							lInsure;							//�û�����
	DWORD							dwWinCount;							//ʤ������
	DWORD							dwLostCount;						//ʧ������
	DWORD							dwDrawCount;						//�;�����
	DWORD							dwFleeCount;						//��������
	SCORE							lUserMedal;							//�û�����
	DWORD							dwExperience;						//�û�����

	//��չ��Ϣ
	TCHAR                           szAddrDescribe[LEN_ADDR_DESCRIBE]; //��ַ����
};

//�û���Ϣ
struct tagUserInfoHead
{
	//�û�����
	DWORD							dwUserID;							//�û� I D

	//�û�����
	WORD							wFaceID;							//ͷ������
	BYTE							cbGender;							//�û��Ա�
	BYTE							cbMemberOrder;						//��Ա�ȼ�
	BYTE							cbMasterOrder;						//����ȼ�

	//�û�״̬
	WORD							wTableID;							//��������
	WORD							wChairID;							//��������
	BYTE							cbUserStatus;						//�û�״̬

	//������Ϣ
	SCORE							lScore;								//�û�����
	SCORE							lInsure;							//�û�����
	DWORD							dwWinCount;							//ʤ������
	DWORD							dwLostCount;						//ʧ������
	DWORD							dwDrawCount;						//�;�����
	DWORD							dwFleeCount;						//��������
	DWORD							dwExperience;						//�û�����
};

//�û���Ϣ
struct tagUserRemoteInfo
{
	//�û���Ϣ
	DWORD							dwUserID;							//�û���ʶ
	TCHAR							szNickName[LEN_NICKNAME];			//�û��ǳ�

	//�ȼ���Ϣ
	BYTE							cbGender;							//�û��Ա�
	BYTE							cbMemberOrder;						//��Ա�ȼ�
	BYTE							cbMasterOrder;						//����ȼ�

	//λ����Ϣ
	WORD							wKindID;							//���ͱ�ʶ
	WORD							wServerID;							//�����ʶ
	TCHAR							szGameServer[LEN_SERVER];			//����λ��
};

//////////////////////////////////////////////////////////////////////////////////

//�㳡����
struct tagGamePlaza
{
	WORD							wPlazaID;							//�㳡��ʶ
	TCHAR							szServerAddr[32];					//�����ַ
	TCHAR							szServerName[32];					//��������
};

//��������
struct tagLevelItem
{
	LONG							lLevelScore;						//�������
	TCHAR							szLevelName[16];					//��������
};

//��Ա����
struct tagMemberItem
{
	BYTE							cbMemberOrder;						//�ȼ���ʶ
	TCHAR							szMemberName[16];					//�ȼ�����
};

//��������
struct tagMasterItem
{
	BYTE							cbMasterOrder;						//�ȼ���ʶ
	TCHAR							szMasterName[16];					//�ȼ�����
};

//�б�����
struct tagColumnItem
{
	BYTE							cbColumnWidth;						//�б���
	BYTE							cbDataDescribe;						//�ֶ�����
	TCHAR							szColumnName[16];					//�б�����
};

//��ַ��Ϣ
struct tagAddressInfo
{
	TCHAR							szAddress[32];						//�����ַ
};

//������Ϣ
struct tagDataBaseParameter
{
	WORD							wDataBasePort;						//���ݿ�˿�
	TCHAR							szDataBaseAddr[32];					//���ݿ��ַ
	TCHAR							szDataBaseUser[32];					//���ݿ��û�
	TCHAR							szDataBasePass[32];					//���ݿ�����
	TCHAR							szDataBaseName[32];					//���ݿ�����
};

//��������
struct tagServerOptionInfo
{
	//�ҽ�����
	WORD							wKindID;							//�ҽ�����
	WORD							wSortID;							//���б�ʶ

	//��������
	BYTE							cbRevenueRatio;						//˰�ձ���
	SCORE							lRestrictScore;						//���ƻ���
	SCORE							lMinTableScore;						//��ͻ���
	SCORE							lMinEnterScore;						//��ͻ���
	SCORE							lMaxEnterScore;						//��߻���

	//��Ա����
	BYTE							cbMinEnterMember;					//��ͻ�Ա
	BYTE							cbMaxEnterMember;					//��߻�Ա

	//��������
	DWORD							dwServerRule;						//�������
	TCHAR							szServerName[LEN_SERVER];			//��������
};

//////////////////////////////////////////////////////////////////////////////////

#pragma pack()

#endif