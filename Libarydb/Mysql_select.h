#ifndef _Mysql_select_H
#define _Mysql_select_H
#if defined(_WIN32)||defined(_WIN64)
#include <windows.h>
#endif
#include "mysql.h"//良好的编程习惯最后引入mysql.h！
#include <stdio.h>
#include <string.h>

class Chaxun
{
private:
	MYSQL *conn;
public:
	char * data;
	Chaxun():data(NULL)
	{
 		conn = mysql_init((MYSQL*) 0);  
 		if(conn!=NULL && mysql_real_connect(conn,"192.168.1.166","root","mysql55","Libarydb",3306,NULL,0))
 		{
			try
			{
				mysql_query(conn,"set names 'gb2312'");;
			}
			catch (...)
			{
				printf("设置失败！\n");
				return ;
			}
 			if(!mysql_select_db(conn,"tushuguanli"))
 			{
 				printf("初始化成功！\n");
 				conn ->reconnect = 1;
 			}
 			else
 				printf("初始化失败！\n");
 		}
	}
	
	Chaxun(const char * ip,const char * id,const char * pwd,const char * db,int port):data(NULL)
	{
 		conn = mysql_init((MYSQL*) 0);  
 		if(conn!=NULL && mysql_real_connect(conn,ip,id,pwd,db,port,NULL,0))
 		{
			try
			{
				mysql_query(conn,"set names 'gb2312'");;
			}
			catch (...)
			{
				printf("设置失败！\n");
				return ;
			}
 			if(!mysql_select_db(conn,db))
 			{
 				printf("初始化成功！\n");
 				conn ->reconnect = 1;
 			}
 			else
 				printf("初始化失败！\n");
		}
		else
		{
		       printf("数据库连接失败！ip=%s,user=%s,pwd=%s,db=%s,port=%d\n",ip,id,pwd,db,port);
		}
	}
	~Chaxun()
	{
		mysql_close(conn);
	}
	
	MYSQL_RES * Demand(const char * condition)
	{
		try
		{
			mysql_query(conn,condition);
		}
		catch (...)
		{
			printf("查询失败！\n");
			return 0;
		}
		MYSQL_RES * recordSet = mysql_store_result(conn); 
		return recordSet;
	}
	
	void Demand_str(const char * condition)
	{
		try
		{
			mysql_query(conn,condition);
		}
		catch (...)
		{
			printf("查询失败！\n");
			return ;
		}
		MYSQL_RES * recordSet = mysql_store_result(conn); 
		long j = mysql_num_fields(recordSet);
		MYSQL_ROW row;
		char *dd,*ee;
		int i=0;
		data=new char[10];
		strcpy(data,"");
		while( row = mysql_fetch_row(recordSet)) 
		{ 
			dd=new char[200];
			strcpy(dd,"");
			for(int l=0 ; l< j;l++) 
			{ 
				if(row[l]==NULL || !strlen(row[l])){}
				else 
				{
					strcat(dd,row[l]);	
					strcat(dd,"|");
				}
			} 
			i=strlen(data)+1;
			ee=data;
			data=NULL;
			data=new char[strlen(dd)+i+1];
			strcpy(data,ee);
			strcat(data,dd);
			strcat(data,"@");
			delete dd;
			delete ee;
		}
	}
	
	void Demand_str_one(const char * condition,int i,int j)
	{
		try
		{
			mysql_query(conn,condition);
		}
		catch (...)
		{
			printf("查询失败！\n");
			return ;
		}
		MYSQL_RES * recordSet = mysql_store_result(conn);
		if(recordSet==NULL)
			return;
		MYSQL_ROW row;
		int k=-1;
		data=new char[200];
		strcpy(data,"");
		while( row = mysql_fetch_row(recordSet))
		{
			++k;
			if(k==i)
				strcat(data,row[j]);
		}
	}

	int Run(const char *str)
	{
		try
		{
			if(!mysql_query(conn,str))
				return 1;
			else
				return 2;
		}
		catch (...)
		{
			return 0;
		}
	}
};

#endif