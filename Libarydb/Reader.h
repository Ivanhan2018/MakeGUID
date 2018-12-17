#ifndef _READER_H
#define _READER_H
#include "appoint.h"
#include "Mysql_select.h"
#include "ways.h"
class Reader
{
private:
	string Reader_id;
	string Reader_pwd;
	string Reader_name;
	string Reader_type;
	int Max;
	int number;
public:
	Ways *way;
	Reader():Reader_id("0"),Reader_pwd("0"),Reader_name("0"),Reader_type("0"),number(0)
	{
		if(Reader_type=="本科生")
			Max=10;
		else if(Reader_type=="研究生")
			Max=20;
		else if(Reader_type=="博士生")
			Max=30;
		else if(Reader_type=="已注销")
			Max=0;
		else
			Max=0;
	}

	Reader(string id,string pwd ,string name,int type,int num=0):Reader_id(id),Reader_pwd(pwd),Reader_name(name),number(num)
	{
		if(type==1)
		{
			Max=10;
			Reader_type="本科生";
		}
		else if(type==2)
		{
			Max=20;
			Reader_type="研究生";
		}
		else if(type==3)
		{
			Max=30;
			Reader_type="博士生";
		}
		else
			cout<<"读者类型参数错误！"<<endl;
	}
	Reader(const Reader & p)
	{
		Reader_id=p.Reader_id;
		Reader_pwd=p.Reader_pwd;
		Reader_type=p.Reader_type;
		Reader_name=p.Reader_name;
		Max=p.Max;
		number=p.number;
	}
	Reader & operator=(const Reader &p)
	{
		if(this!=&p)
		{
			Reader_id=p.Reader_id;
			Reader_pwd=p.Reader_pwd;
			Reader_type=p.Reader_type;
			Reader_name=p.Reader_name;
			Max=p.Max;
			number=p.number;
		}
		return *this;
	}
	~Reader(){}
	///////////////////////////////////////////////////////////
    int select_Lost(Chaxun & se);//丢失书本查询
	int select_Compens(Chaxun & se);//赔款书本查询 
	int select_Library(Chaxun & se);//图书馆在册书查询
	int select_History(Chaxun & se);//借阅历史查询
	int select_Book_now(Chaxun & se);//现借书及情况查询
	int pwd_Change(Chaxun & se);//更改密码操作 
	int reserva_Book(Chaxun & se);//预定图书操作
	int cancel_reserva_Book(Chaxun & se);//取消预订图书操作
	int select_reserva_Book(Chaxun & se);//预约情况查询
};
#endif