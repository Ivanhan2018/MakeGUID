#ifndef MACRO_HEAD_FILE
#define MACRO_HEAD_FILE

#include "math.h"

//////////////////////////////////////////////////////////////////////////////////
//���ó���

//��Ч��ֵ
#define INVALID_BYTE				((BYTE)(0xFF))						//��Ч��ֵ
#define INVALID_WORD				((WORD)(0xFFFF))					//��Ч��ֵ
#define INVALID_DWORD				((DWORD)(0xFFFFFFFF))				//��Ч��ֵ

//////////////////////////////////////////////////////////////////////////////////

//����ά��
#define CountArray(Array) (sizeof(Array)/sizeof(Array[0]))

//��Ч��ַ
#define INVALID_IP_ADDRESS(IPAddress) (((IPAddress==0L)||(IPAddress==INADDR_NONE)))

//////////////////////////////////////////////////////////////////////////////////

//�洢����
#ifdef _UNICODE
	#define CountStringBuffer CountStringBufferW
#else
	#define CountStringBuffer CountStringBufferA
#endif

//�洢����
#define CountStringBufferA(String) ((UINT)((lstrlenA(String)+1)*sizeof(CHAR)))
#define CountStringBufferW(String) ((UINT)((lstrlenW(String)+1)*sizeof(WCHAR)))

//////////////////////////////////////////////////////////////////////////////////

//�ӿ��ͷ�
#define SafeRelease(pObject) { if (pObject!=NULL) { pObject->Release(); pObject=NULL; } }

//ɾ��ָ��
#define SafeDelete(pData) { try { delete pData; } catch (...) { ASSERT(FALSE); } pData=NULL; } 

//�رվ��
#define SafeCloseHandle(hHandle) { if (hHandle!=NULL) { CloseHandle(hHandle); hHandle=NULL; } }

//ɾ������
#define SafeDeleteArray(pData) { try { delete [] pData; } catch (...) { ASSERT(FALSE); } pData=NULL; } 

//////////////////////////////////////////////////////////////////////////////////

//���ڱȽ�
#define SCORE_EQUAL(FirstScore,SecondScore) (fabs(FirstScore-SecondScore)<SCORE_ZERO)
//С�ڱȽ�
#define SCORE_LESS(FirstScore,SecondScore)	(FirstScore<SecondScore)
//���ڱȽ�
#define SCORE_GREATER(FirstScore,SecondScore) (FirstScore>SecondScore)
//С�ڵ���
#define SCORE_LESS_EQUAL(FirstScore,SecondScore) (FirstScore<=SecondScore)
//���ڵ���
#define SCORE_GREATER_EQUAL(FirstScore,SecondScore) (FirstScore>=SecondScore)

//��������
inline DOUBLE Double_Round(DOUBLE dValue,int Retainbits,int Afterbits)	
{			
	DOUBLE TempValue=dValue;
	for(BYTE i=0;i<Afterbits;i++)								
	{															 
        LONGLONG  lValue,lScale=1;								
        for(BYTE j=0;j<Retainbits+Afterbits-1-i;j++) lScale *=  10;				
        lScale *= 2;											
        lValue = (LONGLONG)(TempValue * lScale);								
        lValue += (lValue % 2);	
		DOUBLE TrnasValue = (DOUBLE)lValue;
        TempValue = (TrnasValue/lScale);						
	}		
	return TempValue;
}

//////////////////////////////////////////////////////////////////////////////////

#endif