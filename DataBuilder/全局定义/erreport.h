BOOL errDll(char *filename)
{
       HINSTANCE hDll;
      typedef void (WINAPI* LPFUNC)(char *);
       hDll = LoadLibrary(_T("errlib.dll"));//װ�ض�̬���ӿ�
       if(hDll != NULL)
       {
              LPFUNC lpfnDllFunc = (LPFUNC)GetProcAddress(hDll,"callpro");//װ�غ���
              if(!lpfnDllFunc)
              {
                     FreeLibrary(hDll);
                     return FALSE;
              }
              else
              {
               lpfnDllFunc(filename);//���ú���
            }            
       }
       return TRUE;
}
